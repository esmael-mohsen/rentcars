import 'package:flutter/material.dart';
import 'package:rentapp/core/assets/app_images.dart';
import 'package:rentapp/presentation/home/pages/home_page.dart';

class OnpordingPage extends StatelessWidget {
  const OnpordingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF2C2B34),

      body: SafeArea(
        child: Column(children: [_onboardingImage(), _textAndButton(context)]),
      ),
    );
  }

  Widget _onboardingImage() {
    return Expanded(
      child: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.onboarding),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _textAndButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(35.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Premium Cars.\nEnjoy the luxury",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 42,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 7),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Premium and prestige car daily rental.\nExperience the thrill at a lower price",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 19,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (Route<dynamic> route) => false,
              );
            },
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  "Let's Go",
                  style: TextStyle(
                    color: Color(0XFF2C2B34),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
