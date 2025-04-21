import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoosePlanScreen extends StatelessWidget {
  const ChoosePlanScreen({super.key});

  // دالة لتخزين نوع المستخدم والتنقل
  Future<void> _saveUserTypeAndNavigate(
      BuildContext context, String userType, String route) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userType', userType.toLowerCase());
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                const SizedBox(height: 20),
                const Text(
                  'Welcome to EcoSense\nChoose your plan!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Inria Serif',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF48A47C),
                  ),
                ),
                const SizedBox(height: 20),

                // User Plan
                buildPlanCard(
                  context,
                  title: 'User',
                  features: [
                    '- Air Quality Updates',
                    '- Pollution Notification',
                    '- Eco Friendly Tips',
                    '- Interactive Maps',
                  ],
                ),
                const SizedBox(height: 2),

                // Business Plan
                buildPlanCard(
                  context,
                  title: 'Business',
                  features: [
                    '- Sustainable Practices Resource',
                    '- Sustainability Goal Tools',
                    '- Environmental Impact Insights',
                    '- Emission Reduction Recommendations',
                  ],
                ),
                const SizedBox(height: 2),

                // Government Plan
                buildPlanCard(
                  context,
                  title: 'Government',
                  features: [
                    '- Comprehensive Analytics',
                    '- AI-driven Pollution Identification',
                    '- Policy Suggestions',
                    '- Monitoring Tools',
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPlanCard(BuildContext context,
      {required String title, required List<String> features}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xD8C6E0E2),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 19,
                fontFamily: 'Inika',
                fontWeight: FontWeight.bold,
                color: Color(0xFF48A47C),
              ),
            ),
            const SizedBox(height: 10),
            // Features
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: features
                  .map((feature) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Text(
                          feature,
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'JejuGothic',
                              color: Color(0xFF535353)),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            // Start Button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // تخزين نوع المستخدم والتنقل
                  if (title == 'User') {
                    _saveUserTypeAndNavigate(
                        context, 'user', '/user-onboarding');
                  } else if (title == 'Business') {
                    _saveUserTypeAndNavigate(
                        context, 'business', '/business-onboarding');
                  } else if (title == 'Government') {
                    _saveUserTypeAndNavigate(
                        context, 'government', '/government-onboarding');
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: const Color(0xFF48A47C),
                ),
                child: const Text(
                  'Start',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
