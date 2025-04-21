import 'package:ecosensetest/onboarding/style_onborading.dart';
import 'package:flutter/material.dart';

class BusinessOnboardingScreen extends StatelessWidget {
  const BusinessOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> pageContent = [
      {
        'title': 'Sustainable Practice Resource',
        'description':
            'Provide guidelines to encourage responsible consumption, and green business operations.',
        'json': 'assets/json/Sustainable Practice Resource animation.json',
      },
      {
        'title': 'Sustainability Goal Tools',
        'description':
            'Tools help stakeholders make informed decisions to drive positive environmental and social impact',
        'json': 'assets/json/Sustainability Goal Tools Animation.json',
      },
      {
        'title': 'Environmental Impact Insights',
        'description':
            'Help organizations, policymakers, and individuals assess factors like carbon emissions, resource consumption, waste generation, and ecosystem disruption.',
        'json': 'assets/json/Environmental Impact Insights Animation.json',
      },
      {
        'title': 'Emission Reduction Recommendations',
        'description':
            'Strategies aimed at minimizing the release of greenhouse gases (GHGs) and other pollutants into the atmosphere.',
        'json': 'assets/json/Emission Reduction Recommendations Animation.json',
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
