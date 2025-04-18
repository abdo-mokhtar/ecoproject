import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'aqi_level_card.dart';

class BusinessTipsScreen extends StatelessWidget {
  const BusinessTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tips for Businesses")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          AQILevelCard(
            level: "Good (0–50)",
            color: Colors.green,
            icon: LucideIcons.smile,
            tip:
                "No restrictions. Safe to conduct outdoor operations or events.",
          ),
          AQILevelCard(
            level: "Moderate (51–100)",
            color: Colors.yellow,
            icon: LucideIcons.meh,
            tip: "Monitor sensitive staff. Normal activities may continue.",
          ),
          AQILevelCard(
            level: "Unhealthy for Sensitive Groups (101–150)",
            color: Colors.orange,
            icon: LucideIcons.alertTriangle,
            tip:
                "Ensure good indoor air quality. Reduce exposure for vulnerable staff.",
          ),
          AQILevelCard(
            level: "Unhealthy (151–200)",
            color: Colors.red,
            icon: LucideIcons.frown,
            tip: "Consider modifying work hours or relocating tasks indoors.",
          ),
          AQILevelCard(
            level: "Very Unhealthy (201–300)",
            color: Colors.purple,
            icon: LucideIcons.skull,
            tip: "Minimize outdoor tasks. Encourage remote work.",
          ),
          AQILevelCard(
            level: "Hazardous (301+)",
            color: Colors.brown,
            icon: LucideIcons.radiation,
            tip:
                "Suspend operations where possible. Shift to remote working fully.",
          ),
        ],
      ),
    );
  }
}
