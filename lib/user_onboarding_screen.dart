import 'package:ecosensetest/style_onborading.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UserOnboardingScreen extends StatelessWidget {
  final controller = PageController(viewportFraction: 1, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pageContent = [
      {
        'title': 'Air Quality Updates',
        'description':
            'Daily tips on how to reduce their environmental impact and adopt more sustainable habits',
        'json': 'assets/json/Animation - 1732729633428.json',
      },
      {
        'title': 'Pollution Notification',
        'description':
            'This feature alerts users with timely notifications about rising pollution levels in their area such as PM2.5, CO2, NO2',
        'json': 'assets/json/Notification Animation.json',
      },
      {
        'title': 'Eco-Friendly Tips',
        'description':
            'Daily tips on how to reduce their environmental impact and adopt more sustainable habits',
        'json': 'assets/json/Tips animation.json',
      },
      {
        'title': 'Interactive Maps',
        'description':
            'Real-time maps that display the levels of air pollution across different regions',
        'json': 'assets/json/Interactive Map Animation.json',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: StyleOnBoarding(controller: controller, pageContent: pageContent),
    );
  }
}
