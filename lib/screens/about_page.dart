import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const double _padding = 16.0;
  static const double _spacing = 24.0;
  static const double _borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFf1fdf3),
              Color(0xFFd4f4e2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const _AppBarTitle(),
                centerTitle: true,
              ),
              const Expanded(child: _AboutPageContent()),
            ],
          ),
        ),
      ),
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
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }
}

class _AboutPageContent extends StatelessWidget {
  const _AboutPageContent();

  @override
  Widget build(BuildContext context) {
    final contentWidgets = const [
      _HeaderBox(),
      _ContentSection(
        title: 'Our Mission',
        icon: Icons.public,
        content:
            'We empower users with real-time data on air and water quality to promote healthier lives and sustainable communities.',
      ),
      _ContentSection(
        title: 'How EcoSense Works',
        icon: Icons.bar_chart_rounded,
        content:
            'We collect data from sensors and external sources, analyze it using AI, and deliver personalized insights via our app.',
      ),
      _ContentSection(
        title: 'Data Collection',
        icon: Icons.sensors_rounded,
        content:
            'Our IoT sensors capture real-time data on air quality (NO₂, SO₂, CO₂, CO) and water quality indicators.',
      ),
      _ContentSection(
        title: 'Analysis',
        icon: Icons.analytics_rounded,
        content:
            'Machine learning identifies environmental patterns and predicts future conditions.',
      ),
      _ContentSection(
        title: 'Insights',
        icon: Icons.insights_rounded,
        content:
            'Users receive tailored recommendations and alerts via a user-friendly interface.',
      ),
      _ContentSection(
        title: 'UN SDGs',
        icon: Icons.eco_rounded,
        content:
            '🌱 SDG 3: Health and Well-being\nEnsuring healthy lives for all.\n\n🏙️ SDG 11: Sustainable Cities\nImproving urban sustainability and resilience.\n\n🌍 SDG 13: Climate Action\nTaking urgent action to combat climate change.',
      ),
    ];

    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.all(AboutPage._padding),
        itemCount: contentWidgets.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AboutPage._spacing),
                  child: contentWidgets[index],
                ),
              ),
            ),
          );
        },
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
        gradient: LinearGradient(
          colors: [Colors.green.shade400, Colors.green.shade600],
        ),
        borderRadius: BorderRadius.circular(AboutPage._borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade100,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(Icons.public, color: Colors.white, size: 40),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Transforming Environmental Insights into Action',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
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
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AboutPage._borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.green.shade700),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(
                fontSize: 14.5,
                color: Colors.grey.shade800,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
