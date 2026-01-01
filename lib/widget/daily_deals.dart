import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omnicart/constant/app_colors.dart';
import 'package:omnicart/constant/text_style.dart';
import 'package:omnicart/widget/custom_buttons.dart';

class DailyDeals extends StatelessWidget {
  const DailyDeals({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.lightGreen),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Daily Deal!", style: AppTextStyle.main),

          SizedBox(height: 30),

          Center(child: Image.asset("images/headphone.png")),

          SizedBox(height: 15),

          Center(
            child: Text(
              "Premium Noise-Cancelling\n Headphones",
              style: AppTextStyle.main,
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 10),

          Center(
            child: Text(
              "Immerse yourself in crystal-clear audio with our top-rated noise-cancelling headphones.",
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 12),

          Center(
            child: Text(
              "₦5490.99",
              style: GoogleFonts.roboto(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor,
              ),
            ),
          ),

          SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: CustomButton(
                  title: "Details",
                  onPressed: () {},
                  icon: Icons.details_sharp,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: CustomButton(
                  icon: Icons.add,
                  onPressed: () {},
                  title: "Add",
                  foreground: AppColors.mainColor,
                  background: Colors.white,
                  side: BorderSide(color: AppColors.mainColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//
