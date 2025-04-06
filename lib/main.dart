import 'package:ecosensetest/home_screen.dart';
import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'start_page.dart';
import 'choose_plan_screen.dart';
import 'user_onboarding_screen.dart';
import 'business_onboarding_screen.dart';
import 'government_onboarding_screen.dart';
import 'signup.dart';
import 'login.dart';

void main() {
  runApp(EcoSenseApp());
}

class EcoSenseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // البداية تكون من SplashScreen
      routes: {
        '/': (context) => const SplashScreen(),
        '/start': (context) => const StartPage(),
        '/choose-plan': (context) => const ChoosePlanScreen(),
        '/user-onboarding': (context) => UserOnboardingScreen(),
        '/business-onboarding': (context) => BusinessOnboardingScreen(),
        '/government-onboarding': (context) => GovernmentOnboardingScreen(),
        '/home': (context) => const HomeScreen(),
        '/signup': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
