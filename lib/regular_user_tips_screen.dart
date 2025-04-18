import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'aqi_level_card.dart';
import 'eco_delivery_dialog.dart'; // استدعاء الكلاس

class RegularUserTipsScreen extends StatelessWidget {
  const RegularUserTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ استدعاء الدايالوج أول ما تبني الشاشة
    Future.microtask(() {
      EcoDeliveryDialog.show(context);
    });

    final aqiLevels = [
      {
        'level': "Good (0–50)",
        'color': Colors.green,
        'icon': LucideIcons.smile,
        'tip':
            "Enjoy outdoor activities freely. Air quality poses little or no risk.",
      },
      {
        'level': "Moderate (51–100)",
        'color': Colors.yellow,
        'icon': LucideIcons.meh,
        'tip':
            "Safe for most, but consider reducing prolonged outdoor exertion if sensitive.",
      },
      {
        'level': "Unhealthy for Sensitive Groups (101–150)",
        'color': Colors.orange,
        'icon': LucideIcons.alertTriangle,
        'tip':
            "Limit outdoor activity if you have asthma, allergies, or respiratory conditions.",
      },
      {
        'level': "Unhealthy (151–200)",
        'color': Colors.red,
        'icon': LucideIcons.frown,
        'tip': "Avoid strenuous outdoor activities. Consider staying indoors.",
      },
      {
        'level': "Very Unhealthy (201–300)",
        'color': Colors.purple,
        'icon': LucideIcons.skull,
        'tip':
            "Stay indoors. Use an air purifier if available. Wear a mask if outside.",
      },
      {
        'level': "Hazardous (301+)",
        'color': Colors.brown,
        'icon': LucideIcons.radiation,
        'tip':
            "Health emergency. Stay inside with windows closed. Follow official alerts.",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 4,
        title: const Text(
          "Tips for Regular Users",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: aqiLevels.length,
          itemBuilder: (context, index) {
            final item = aqiLevels[index];
            return AQILevelCard(
              level: item['level'] as String,
              color: item['color'] as Color,
              icon: item['icon'] as IconData,
              tip: item['tip'] as String,
            );
          },
        ),
      ),
    );
  }
}
