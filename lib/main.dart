import 'package:ecosensetest/onboarding/business_onboarding_screen.dart'
    show BusinessOnboardingScreen;
import 'package:ecosensetest/onboarding/government_onboarding_screen.dart'
    show GovernmentOnboardingScreen;
import 'package:ecosensetest/onboarding/user_onboarding_screen.dart'
    show UserOnboardingScreen;
import 'package:ecosensetest/screens/choose_plan_screen.dart'
    show ChoosePlanScreen;
import 'package:ecosensetest/screens/login_screen.dart';
import 'package:ecosensetest/screens/notification_service.dart';
import 'package:ecosensetest/screens/signup_screen.dart' show SignUpScreen;
import 'package:ecosensetest/screens/splash_screen.dart' show SplashScreen;
import 'package:ecosensetest/screens/start_page.dart' show StartPage;
import 'package:ecosensetest/screens/weather_screen.dart';
import 'package:ecosensetest/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_state.dart';
import 'screens/navigationdestination/home_screen_business.dart'
    show HomeScreenBusiness;
import 'screens/navigationdestination/home_screen_goverment.dart'
    show HomeScreenGoverment;
import 'screens/navigationdestination/home_screen_user.dart'
    show HomeScreenUser;

// استيراد Firebase Core
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Firebase
  await Firebase.initializeApp();

  // تهيئة خدمة الإشعارات
  await NotificationService.init();

  runApp(const EcoSenseApp());
}

class EcoSenseApp extends StatelessWidget {
  const EcoSenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthState()),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/start': (context) => const StartPage(),
          '/choose-plan': (context) => const ChoosePlanScreen(),
          '/user-onboarding': (context) => const UserOnboardingScreen(),
          '/business-onboarding': (context) => const BusinessOnboardingScreen(),
          '/government-onboarding': (context) =>
              const GovernmentOnboardingScreen(),
          '/homegoverment': (context) => const HomeScreenGoverment(),
          '/signup': (context) => SignUpScreen(),
          '/login': (context) => LoginScreen(),
          '/homeuser': (context) => const HomeScreenUser(),
          '/homebusiness': (context) => const HomeScreenBusiness(),
          '/weather': (context) => const WeatherScreen(),
        },
      ),
    );
  }
}
