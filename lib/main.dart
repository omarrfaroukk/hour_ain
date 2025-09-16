import 'package:flutter/material.dart';
import 'package:hour_ain/core/constants/app_routes.dart';
import 'package:hour_ain/features/auth/sign_in/views/sign_in.dart';
import 'package:hour_ain/features/auth/sign_up/views/sign_up.dart';
import 'package:hour_ain/features/onboarding/on_boarding.dart';

import 'features/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.onboarding,
      debugShowCheckedModeBanner: false,
      home: OnBoarding(),

      routes: {
        AppRoutes.home: (context)=> const HomePage(),
        AppRoutes.onboarding: (context) => const OnBoarding(),
        AppRoutes.signin: (context) => const SignIn(),
        AppRoutes.signup: (context)=> const SignUp(),
      },
      );
  }
}
