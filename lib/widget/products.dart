import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omnicart/constant/app_colors.dart';
import 'package:omnicart/constant/text_style.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String id;
  final double price;
  final String imageBase64;
  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageBase64,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 180,
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(0.5, 6),
              ),
            ],
          ),
          padding: EdgeInsets.only(top: 10, left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.memory(
                  base64Decode(imageBase64),
                  fit: BoxFit.cover,
                  width: 250,
                ),
              ),
              SizedBox(height: 20),
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.avgmain,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₦${price.toStringAsFixed(2)}",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
