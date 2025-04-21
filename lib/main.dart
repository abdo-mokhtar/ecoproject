import 'package:ecosensetest/onboarding/business_onboarding_screen.dart'
    show BusinessOnboardingScreen;
import 'package:ecosensetest/onboarding/government_onboarding_screen.dart'
    show GovernmentOnboardingScreen;
import 'package:ecosensetest/onboarding/user_onboarding_screen.dart'
    show UserOnboardingScreen;
import 'package:ecosensetest/screens/choose_plan_screen.dart'
    show ChoosePlanScreen;

import 'package:ecosensetest/screens/login_screen.dart';
import 'package:ecosensetest/screens/signup_screen.dart' show SignUpScreen;
import 'package:ecosensetest/screens/splash_screen.dart' show SplashScreen;
import 'package:ecosensetest/screens/start_page.dart' show StartPage;
import 'package:flutter/material.dart';

import 'screens/navigationdestination/home_screen_business.dart'
    show HomeScreenBusiness;
import 'screens/navigationdestination/home_screen_goverment.dart'
    show HomeScreenGoverment;
import 'screens/navigationdestination/home_screen_user.dart'
    show HomeScreenUser;

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
        '/homegoverment': (context) => const HomeScreenGoverment(),
        '/signup': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
        '/homeuser': (context) => const HomeScreenUser(),
        '/homebusiness': (context) => const HomeScreenBusiness(),
      },
    );
  }
}
