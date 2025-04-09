import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const double _padding = 16.0;
  static const double _spacing = 20.0;
  static const double _borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const _AppBarTitle(),
        centerTitle: true,
      ),
      body: const _AboutPageContent(),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'About',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}

class _AboutPageContent extends StatelessWidget {
  const _AboutPageContent();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: const EdgeInsets.all(AboutPage._padding),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _HeaderBox(),
          SizedBox(height: AboutPage._spacing),
          _ContentSection(
            title: 'Our Mission',
            icon: Icons.public,
            content:
                'Our mission is to empower users with accurate, real-time data on air and water quality to promote healthier living, safer workplaces, and sustainable communities worldwide.',
          ),
          SizedBox(height: AboutPage._spacing),
          _ContentSection(
            title: 'How EcoSense Works',
            icon: Icons.bar_chart,
            content:
                'EcoSense collects data using IoT sensors and external sources, analyzes it with machine learning, and provides personalized insights and recommendations through a user-friendly app and website.',
          ),
          SizedBox(height: AboutPage._spacing),
          _ContentSection(
            title: 'Data Collection',
            icon: Icons.sensors,
            content:
                'IoT sensors gather real-time environmental data including air quality metrics (NO₂, SO₂, CO₂, CO) and water quality indicators.',
          ),
          SizedBox(height: AboutPage._spacing),
          _ContentSection(
            title: 'Analysis',
            icon: Icons.analytics,
            content:
                'Advanced machine learning algorithms process the data to identify patterns and predict future trends.',
          ),
          SizedBox(height: AboutPage._spacing),
          _ContentSection(
            title: 'Insights',
            icon: Icons.insights,
            content:
                'Users receive personalized recommendations and alerts through our intuitive interface.',
          ),
          SizedBox(height: AboutPage._spacing),
          _ContentSection(
            title: 'UN SDG',
            icon: Icons.eco,
            content:
                'SDG 3: Health and Well-being\nEnsuring healthy lives and promoting well-being for all.\n\nSDG 11: Sustainable Cities\nAdvanced machine learning algorithms process the data to identify patterns and predict future trends.\n\nSDG 13: Climate Action\nUsers receive personalized recommendations and alerts through our intuitive interface.',
          ),
        ],
      ),
    );
  }
}

class _HeaderBox extends StatelessWidget {
  const _HeaderBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AboutPage._padding),
      decoration: BoxDecoration(
        color: Colors.green.shade300,
        borderRadius: BorderRadius.circular(AboutPage._borderRadius),
      ),
      child: const Row(
        children: [
          Icon(Icons.public, color: Colors.white, size: 40),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Transforming Environmental Insights into Action',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentSection extends StatelessWidget {
  const _ContentSection({
    required this.title,
    required this.icon,
    required this.content,
  });

  final String title;
  final IconData icon;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.green.shade700),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(AboutPage._borderRadius),
          ),
          child: Text(
            content,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
