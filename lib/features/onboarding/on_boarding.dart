import 'package:flutter/material.dart';
import 'package:hour_ain/core/constants/app_routes.dart';
import 'package:hour_ain/core/constants/app_typography.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_images.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.bgimage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(image: AssetImage(AppImages.applogo), height: 200),
                Text(
                  textAlign: TextAlign.center,
                  "Look awesome & Save Some ",
                  style: AppTypography.title1,
                ),

                Text(
                  textAlign: TextAlign.center,
                  "Step into a world of personalized services that enhance your beauty and well-being.",
                  style: AppTypography.body2,
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.signin);
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.buttonColor,
                    ),
                    child: Center(
                      child: Text("Let's start", style: AppTypography.title2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
