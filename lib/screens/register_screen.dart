import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omnicart/constant/app_colors.dart';
import 'package:omnicart/constant/text_style.dart';
import 'package:omnicart/model/database_methods.dart';
import 'package:omnicart/provider/auth_provider.dart';
import 'package:omnicart/screens/login_screen.dart';
import 'package:omnicart/screens/main_home.dart';
import 'package:omnicart/services/user_details.dart';

import 'package:omnicart/widget/custom_buttons.dart';
import 'package:omnicart/widget/mytext_field.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String id = randomAlphaNumeric(10);
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    confirmpassword.dispose();
    super.dispose();
  }

  //Register Function
  Future<void> handleRegister() async {
    if (password.text.trim() != confirmpassword.text.trim()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Password do not match")));
      return;
    }
    try {
      await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).register(email.text.trim(), password.text.trim());

      await Sharedprefhelper().saveUserEmail(email.text.trim());
      await Sharedprefhelper().saveUserId(id);
      await Sharedprefhelper().saveUserName(name.text.trim());
      await Sharedprefhelper().saveUserImage("images/user.png");

      Map<String, dynamic> userInfo = {
        "name": name.text.trim(),
        "email": email.text.trim(),
        "id": id,
        "image": "images/user.png",
      };
      await DbMethods().addUserDetails(userInfo, id);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Registration successful!!!")));
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10, top: 120),
          child: Column(
            children: [
              Center(
                child: Text("Create Your Account", style: AppTextStyle.main),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Join Omnimart to discover amazing products\n and deals.",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.submain,
                ),
              ),
              SizedBox(height: 20),
              myTextField(title: "Full Name", controller: name),
              SizedBox(height: 10),
              myTextField(title: "Email", controller: email),
              SizedBox(height: 10),
              myTextField(
                title: "Password",
                isPassword: true,
                controller: password,
              ),
              SizedBox(height: 10),
              myTextField(
                title: "Confirm Password",
                isPassword: true,
                controller: confirmpassword,
              ),
              SizedBox(height: 30),

              CustomButton(
                title: "Register",
                onPressed: handleRegister,
                icon: Icons.login_sharp,
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.poppins(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      "Login",
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
      ),
    );
  }
}
