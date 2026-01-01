import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:omnicart/admin/ad_home.dart';
import 'package:omnicart/constant/text_style.dart';
import 'package:omnicart/widget/custom_buttons.dart';
import 'package:omnicart/widget/mytext_field.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final snapshot = await FirebaseFirestore.instance.collection("Admin").get();

    for (var result in snapshot.docs) {
      // Check username
      if (result.data()['username'] == username.text.trim()) {
        // Check password
        if (result.data()['password'].toString().trim() ==
            password.text.trim()) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Login Successfully")));

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdHome()),
          );
          return;
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Incorrect password")));
          return;
        }
      }
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Invalid username")));
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
            Center(child: Text("ADMIN LOGIN", style: AppTextStyle.main)),
            SizedBox(height: 10),

            SizedBox(height: 10),
            myTextField(title: "Username", controller: username),
            const SizedBox(height: 10),
            myTextField(
              title: "Password",
              isPassword: true,
              controller: password,
            ),
            const SizedBox(height: 30),

            CustomButton(title: "Login", onPressed: login),
          ],
        ),
      ),
    );
  }
}
