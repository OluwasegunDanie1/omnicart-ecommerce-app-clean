import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:omnicart/constant/app_colors.dart';
import 'package:omnicart/model/database_methods.dart';
import 'package:omnicart/services/payment_gateway.dart';
import 'package:omnicart/widget/app_bar.dart';
import 'package:omnicart/widget/custom_buttons.dart';

class ProductDetails extends StatefulWidget {
  final String id;
  final String name;
  final double price;
  final String imageBase64;
  final String category;
  final String desc;

  const ProductDetails({
    super.key,
    required this.name,
    required this.price,
    required this.category,
    required this.imageBase64,
    required this.desc,
    required this.id,
  });

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                title: "Product Details",
                icon: Icons.arrow_back_ios,
                iconic: Icons.shopping_cart_outlined,
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.memory(
                        base64Decode(widget.imageBase64),
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Text(category),
                    Text(
                      "₦${widget.price.toStringAsFixed(2)}",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainColor,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(widget.desc),
                    SizedBox(height: 30),
                    Divider(),
                    SizedBox(height: 70),
                    CustomButton(
                      icon: Icons.credit_card,
                      title: "Add to Cart",
                      onPressed: () async {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please login to add to cart"),
                            ),
                          );
                          return;
                        }
                        await DbMethods().addToCart(
                          userId: user.uid,
                          productData: {
                            "id": widget.id,
                            "name": widget.name,
                            "price": widget.price,
                            "imageBase64": widget.imageBase64,
                            "quantity": 1,
                          },
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Added to cart")),
                        );
                      },
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
