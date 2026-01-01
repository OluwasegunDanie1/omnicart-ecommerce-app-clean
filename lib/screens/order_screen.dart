import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omnicart/constant/app_colors.dart';
import 'package:omnicart/model/database_methods.dart';
import 'package:omnicart/widget/app_bar.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Stream<QuerySnapshot>? orderStream;
  final DbMethods dbMethods = DbMethods();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Color statusColor(String status) {
    switch (status) {
      case "Delivered":
        return Colors.green;
      case "On the way":
        return Colors.orange;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<void> loadOrders() async {
    final user = _auth.currentUser;
    if (user == null || user.email == null) {
      debugPrint("User not logged in");
      return;
    }

    orderStream = dbMethods.getOrders(user.email!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  Widget allOrders() {
    if (orderStream == null) {
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    }

    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: orderStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No orders yet"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final ds = snapshot.data!.docs[index];
              final status = ds["status"] ?? "Pending";

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ListTile(
                  tileColor: Colors.white,
                  leading: const Icon(Icons.shopping_bag),
                  title: Text(
                    "₦${ds["totalAmount"]}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.mainColor,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Items: ${ds["totalQuantity"]}",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Products: ${List<String>.from(ds["products"].map((p) => p["name"])).join(", ")}",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Ordered at: ${(ds["createdAt"] as Timestamp).toDate()}",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Text(
                        "Status: $status",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: statusColor(status),
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          CustomAppBar(
            title: "My Orders",
            icon: Icons.arrow_back_ios,
            iconic: Icons.shopping_cart_outlined,
          ),
          allOrders(),
        ],
      ),
    );
  }
}
