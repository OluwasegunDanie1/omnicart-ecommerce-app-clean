import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omnicart/constant/app_colors.dart';
import 'package:omnicart/constant/text_style.dart';

import 'package:omnicart/screens/register_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int selectedIndex = 0;

  final List<Map<String, dynamic>> onboardings = [
    {
      "image": "images/onb.png",
      "title": "Browse Products",
      "subtitle":
          "Discover a world of choices! Explore \n diverse categories and effortlessly\n search for your favorite items.",
      "button": "Next",
    },
    {
      "image": "images/cart.png",
      "title": "Add to Cart",
      "subtitle":
          "Easily add products to your cart and enjoy\n a quick, streamlined checkout process.",
      "button": "Next",
    },
    {
      "image": "images/markon.png",
      "title": "Secure Stripe Payments",
      "subtitle":
          "Experience fast, secure, and seamless\n payments powered by Stripe, ensuring\n your transactions are always protected.",
      "button": "Get Started",
    },
  ];

  void nextPage() {
    if (selectedIndex < onboardings.length - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegisterScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: onboardings.length,
        onPageChanged: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        itemBuilder: (context, index) {
          final data = onboardings[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset(data["image"]),
              SizedBox(height: 20),
              Text(data["title"], style: AppTextStyle.main),
              SizedBox(height: 20),
              Text(
                textAlign: TextAlign.center,
                data["subtitle"],
                style: AppTextStyle.submain,
              ),

              SizedBox(height: 200),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(onboardings.length, (index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 3),
                    margin: EdgeInsets.all(5),
                    height: 10,
                    width: selectedIndex == index ? 25 : 10,
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? AppColors.mainColor
                          : AppColors.gray,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  );
                }),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (selectedIndex != onboardings.length - 1)
                      Text(
                        "Skip",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 30,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: nextPage,
                      child: Text(
                        data["button"],
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
