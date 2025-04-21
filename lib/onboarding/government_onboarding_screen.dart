import 'package:ecosensetest/onboarding/style_onborading.dart'
    show StyleOnBoarding;
import 'package:flutter/material.dart';

class GovernmentOnboardingScreen extends StatelessWidget {
  const GovernmentOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pageContent = [
      {
        'title': 'Comprehensive Analytics',
        'description':
            'This approach helps identify patterns, predict outcomes, and provide actionable recommendations',
        'json': 'assets/json/Comprehensive Analytics Animation.json',
      },
      {
        'title': 'AI-driven Pollution Identification',
        'description':
            'Use of artificial intelligence to detect, analyze, and monitor pollution levels.',
        'json': 'assets/json/AI Driven Pollution Identification Animation.json',
      },
      {
        'title': 'Environmental Impact Insights',
        'description':
            'Help organizations, policymakers, and individuals assess factors like carbon emissions, resource consumption, waste generation, and ecosystem disruption.',
        'json': 'assets/json/Environmental Impact Insight Animation.json',
      },
      {
        'title': 'Mentoring Tools',
        'description':
            'Aim to guide governments, organizations, and stakeholders in implementing effective measures.',
        'json': 'assets/json/Mentoring Tools Animation.json',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: StyleOnBoarding(
        controller: PageController(viewportFraction: 1, keepPage: true),
        pageContent: pageContent,
      ),
    );
  }
}
