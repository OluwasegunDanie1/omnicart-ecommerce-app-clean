import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:omnicart/constant/text_style.dart';
import 'package:omnicart/model/database_methods.dart';
import 'package:omnicart/services/payment_gateway.dart';
import 'package:omnicart/services/user_details.dart';
import 'package:omnicart/widget/custom_buttons.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // final String userId = "testUser";
  final DbMethods dbMethods = DbMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // getSharedprefhelper() async {
  //   name = await Sharedprefhelper().getuserName();
  //   email = await Sharedprefhelper().getuserEmail();
  //   setState(() {});
  // }

  // onTheLoad() async {
  //   await getSharedprefhelper();
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();
  }

  double calculateTotal(List<QueryDocumentSnapshot> docs) {
    double total = 0;
    for (var doc in docs) {
      total += doc["price"] * doc["quantity"];
    }
    return total;
  }

  int calculateTotalQuantity(List<QueryDocumentSnapshot> docs) {
    int totalQty = 0;
    for (var doc in docs) {
      totalQty += (doc["quantity"] as num).toInt();
    }
    return totalQty;
  }

  Future<void> makePayment(double totalAmount) async {
    try {
      final user = _auth.currentUser;

      if (user == null || user.email == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User details not loaded")),
        );
        return;
      }
      final name = user.displayName ?? "No Name";
      final email = user.email!;
      final userId = user.uid;

      var paymentIntent = await createPaymentIntent(
        totalAmount.toString(),
        "NGN",
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: name,
        ),
      );

      await displayPaymentSheet(userId, name, email);
    } catch (e) {
      print("Payment error: $e");
    }
  }

  Future<void> displayPaymentSheet(
    String userId,
    String name,
    String email,
  ) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      final cartSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("cart")
          .get();

      final products = cartSnapshot.docs.map((doc) {
        return {
          "id": doc["id"],
          "name": doc["name"],
          "price": doc["price"],
          "quantity": doc["quantity"],
        };
      }).toList();

      final orderInfoMap = {
        "userId": userId,
        "userName": name,
        "userEmail": email,
        "products": products,
        "totalAmount": calculateTotal(cartSnapshot.docs),
        "totalQuantity": calculateTotalQuantity(cartSnapshot.docs),
        "createdAt": Timestamp.now(),
        "status": "Pending",
      };

      await dbMethods.orderDetails(orderInfoMap);

      // clear cart
      for (var doc in cartSnapshot.docs) {
        await doc.reference.delete();
      }

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.check_circle, color: Colors.green, size: 40),
              SizedBox(height: 10),
              Text("Payment Successful"),
            ],
          ),
        ),
      );

      Navigator.pop(context);
    } on StripeException catch (e) {
      print("Stripe error: $e");
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(content: Text("Payment cancelled")),
      );
    } catch (e) {
      print("Error: $e");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(content: Text("Payment failed: $e")),
      );
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        "amount": calculateAmount(amount),
        "currency": currency,
        "payment_method_types[]": "card",
      };

      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          "Authorization": "Bearer $secretKey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: body,
      );

      return jsonDecode(response.body);
    } catch (err) {
      throw Exception("Error charging user: $err");
    }
  }

  String calculateAmount(String amount) {
    final calculatedAmount = (double.parse(amount) * 100).toInt();
    return calculatedAmount.toString();
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    if (user == null) {
      return const Scaffold(body: Center(child: Text("User not logged in")));
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Cart",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .collection("cart")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          }

          double totalPrice = calculateTotal(docs);
          int totalQuantity = calculateTotalQuantity(docs);

          return Column(
            children: [
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index];

                    return Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10,
                        top: 7,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(10),
                            child: Image.memory(
                              base64Decode(data["imageBase64"]),
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            data["name"],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          subtitle: Text(
                            "₦${data["price"]} × ${data["quantity"]}",
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              data.reference.delete();
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(thickness: 1),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Items: $totalQuantity",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "Total: ₦${totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    CustomButton(
                      icon: Icons.credit_card_outlined,
                      title: "Pay with Stripe",
                      onPressed: () {
                        makePayment(totalPrice);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
