import 'package:ecosensetest/onboarding/style_onborading.dart'
    show StyleOnBoarding;
import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          Expanded(
            child: StyleOnBoarding(
                controller: controller, pageContent: pageContent),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                // عند الضغط على الزرار، يذهب إلى HomeScreen مع إرسال نوع الخطة 'User'
                Navigator.pushReplacementNamed(
                  context,
                  '/home', // تأكد من أنك تعرفت على هذا الـ route في main.dart
                  arguments: 'User', // إرسال نوع الخطة كـ argument
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: const Color(0xFF48A47C),
              ),
              child: const Text('Start',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
