import 'package:flutter/material.dart';
import 'package:omnicart/constant/app_colors.dart';
import 'package:omnicart/constant/text_style.dart';

class myTextField extends StatefulWidget {
  final String title;
  final String? hinttext;
  final TextEditingController? controller;
  final bool isPassword;
  final IconData? icon;
  final int? maxlines;
  final Function(String)? onChanged;

  const myTextField({
    super.key,
    required this.title,
    this.hinttext,
    this.controller,
    this.isPassword = false,
    this.icon,
    this.onChanged,
    this.maxlines = 1,
  });

  @override
  State<myTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<myTextField> {
  bool obscureText = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: AppTextStyle.avgmain),
        const SizedBox(height: 10),
        TextField(
          maxLines: widget.maxlines,
          onChanged: widget.onChanged,
          controller: widget.controller,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                : null,

            // filled: true,
            // fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            hintStyle: TextStyle(color: AppColors.black),
            hintText: widget.hinttext,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              //borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
