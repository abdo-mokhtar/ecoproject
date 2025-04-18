import 'package:ecosensetest/widgets/aqi_level_card.dart' show AQILevelCard;
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'eco_delivery_dialog.dart'; // استدعاء الكلاس

class GovernmentTipsScreen extends StatelessWidget {
  const GovernmentTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // عرض الديالوج عند الدخول
    Future.microtask(() {
      EcoDeliveryDialog.show(context);
    });

    return Scaffold(
      appBar: AppBar(title: const Text("Tips for Government")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          AQILevelCard(
            level: "Good (0–50)",
            color: Colors.green,
            icon: LucideIcons.smile,
            tip: "Continue monitoring. Promote green initiatives.",
          ),
          AQILevelCard(
            level: "Moderate (51–100)",
            color: Colors.yellow,
            icon: LucideIcons.meh,
            tip:
                "Notify sensitive groups but no need for alert. Continue standard operations.",
          ),
          AQILevelCard(
            level: "Unhealthy for Sensitive Groups (101–150)",
            color: Colors.orange,
            icon: LucideIcons.alertTriangle,
            tip:
                "Issue health advisories for vulnerable populations. Monitor emission sources.",
          ),
          AQILevelCard(
            level: "Unhealthy (151–200)",
            color: Colors.red,
            icon: LucideIcons.frown,
            tip:
                "Alert the public. Prepare response plans and reduce emissions.",
          ),
          AQILevelCard(
            level: "Very Unhealthy (201–300)",
            color: Colors.purple,
            icon: LucideIcons.skull,
            tip:
                "Issue strong warnings. Enforce restrictions on polluting activities.",
          ),
          AQILevelCard(
            level: "Hazardous (301+)",
            color: Colors.brown,
            icon: LucideIcons.radiation,
            tip:
                "Declare environmental emergency. Activate emergency protocols.",
          ),
        ],
      ),
    );
  }
}
