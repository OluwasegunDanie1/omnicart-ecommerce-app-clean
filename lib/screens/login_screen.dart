import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omnicart/constant/app_colors.dart';
import 'package:omnicart/constant/text_style.dart';
import 'package:omnicart/provider/auth_provider.dart';

import 'package:omnicart/screens/main_home.dart';
import 'package:omnicart/screens/register_screen.dart';

import 'package:omnicart/widget/custom_buttons.dart';
import 'package:omnicart/widget/mytext_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  //final String? category;
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();

    super.dispose();
  }

  //Register Function
  Future<void> handleLogin() async {
    try {
      await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).login(email.text.trim(), password.text.trim());
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login successful!!!")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainHome()),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text("Welcome Back", style: AppTextStyle.main)),
            SizedBox(height: 10),
            Center(
              child: Text(
                "Login",
                style: GoogleFonts.poppins(
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(height: 10),
            myTextField(title: "Email", controller: email),
            SizedBox(height: 10),
            myTextField(
              title: "Password",
              isPassword: true,
              controller: password,
            ),
            SizedBox(height: 30),

            CustomButton(
              title: "Login",
              onPressed: handleLogin,
              icon: Icons.login_outlined,
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: GoogleFonts.poppins(
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    "Register",
                    style: GoogleFonts.poppins(
                      color: AppColors.mainColor,
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
  }
}
