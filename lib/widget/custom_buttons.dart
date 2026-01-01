import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omnicart/constant/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final Color? foreground;
  final Color? background;
  final BorderSide? side;
  final IconData? icon;
  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
    this.foreground = Colors.white,
    this.background = AppColors.mainColor,
    this.side,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: foreground,
        backgroundColor: background,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: side ?? BorderSide.none,
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 27),
          SizedBox(width: 10),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
