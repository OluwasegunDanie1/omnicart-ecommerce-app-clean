import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omnicart/constant/app_colors.dart';

class AppTextStyle {
  static TextStyle main = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static TextStyle avgmain = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static TextStyle submain = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.gray,
  );
}
