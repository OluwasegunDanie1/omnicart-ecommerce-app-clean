import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omnicart/constant/app_colors.dart';
import 'package:omnicart/model/database_methods.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders> {
  final DbMethods dbMethods = DbMethods();
  Color statusColor(String status) {
    switch (status) {
      case "Delivered":
        return Colors.green;
      case "On the way":
        return Colors.orange;
      case "Pending":
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Orders (Admin)",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .orderBy("createdAt", descending: true)
            .snapshots(),
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
              final data = ds.data() as Map<String, dynamic>;
              final userEmail = data["userEmail"] ?? "No Email";

              final status = data["status"] ?? "Pending";
              final products = List<Map<String, dynamic>>.from(
                data["products"],
              );

              return Card(
                elevation: 0.05,
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userEmail,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "₦${data["totalAmount"]}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "Items: ${data["totalQuantity"]}",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      Text(
                        "Products: ${products.map((p) => p["name"]).join(", ")}",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Text(
                        "Ordered: ${(data["createdAt"] as Timestamp).toDate()}",

                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "Status: $status",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: statusColor(status),
                        ),
                      ),

                      const Divider(),

                      /// ADMIN ACTION BUTTONS
                      Row(
                        children: [
                          if (status != "On the way")
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0.5,
                                foregroundColor: Colors.black,
                                backgroundColor: Colors.white,
                                minimumSize: Size(80, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.grey),
                                ),
                              ),
                              onPressed: () {
                                dbMethods.updateOrderStatus(
                                  ds.id,
                                  "On the way",
                                );
                              },
                              child: Text(
                                "On the way",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),

                          const SizedBox(width: 20),

                          if (status != "Delivered")
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0.5,
                                foregroundColor: Colors.white,
                                backgroundColor: AppColors.mainColor,
                                minimumSize: Size(80, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                dbMethods.updateOrderStatus(ds.id, "Delivered");
                              },
                              child: Text(
                                "Delivered",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
