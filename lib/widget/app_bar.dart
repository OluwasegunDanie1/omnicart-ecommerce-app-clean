import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:omnicart/constant/app_colors.dart';
import 'package:omnicart/constant/text_style.dart';
import 'package:omnicart/screens/cart_screen.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  final IconData? icon;
  final IconData? iconi;
  final IconData? iconic;

  const CustomAppBar({
    super.key,
    required this.title,
    this.icon,
    this.iconi,
    this.iconic,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 5, right: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(widget.icon, size: 30, color: Colors.white),
                ),
              ),
              Text(widget.title, style: AppTextStyle.avgmain),
              Row(
                children: [
                  Icon(widget.iconi, size: 30),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => CartScreen()),
                      );
                    },
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseAuth.instance.currentUser == null
                          ? const Stream.empty()
                          : FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('cart')
                                .snapshots(),
                      builder: (context, snapshot) {
                        int cartCount = 0;

                        if (snapshot.hasData) {
                          cartCount = snapshot.data!.docs.length;
                        }

                        return Badge(
                          label: Text(
                            '$cartCount',
                            style: const TextStyle(color: Colors.white),
                          ),
                          child: Icon(widget.iconic, size: 33),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Divider(height: 2, color: Colors.black38),
      ],
    );
  }
}
