// import 'package:ecosensetest/widgets/aqi_level_card.dart' show AQILevelCard;
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../eco_delivery_dialog.dart'; // استدعاء الكلاس

class GovernmentTipsScreen extends StatelessWidget {
  const GovernmentTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // عرض الديالوج عند الدخول
    Future.microtask(() {
      EcoDeliveryDialog.show(context);
    });

    final List<Map<String, dynamic>> aqiLevels = [
      {
        'level': "Good (0–50)",
        'color': Colors.green,
        'icon': LucideIcons.smile,
        'tip': "✅ Air quality is excellent.\n"
            "📊 Continue routine monitoring.\n"
            "🌳 Promote tree-planting and eco-friendly city programs.",
      },
      {
        'level': "Moderate (51–100)",
        'color': Colors.yellow,
        'icon': LucideIcons.meh,
        'tip':
            "⚠️ Acceptable air quality for most, but could affect sensitive individuals.\n"
                "📣 Notify healthcare centers and schools.\n"
                "🌐 Encourage public awareness campaigns.",
      },
      {
        'level': "Unhealthy for Sensitive Groups (101–150)",
        'color': Colors.orange,
        'icon': LucideIcons.alertTriangle,
        'tip':
            "🧑‍⚕️ Issue health advisories for children, elderly, and people with conditions.\n"
                "🔍 Monitor emission sources — factories, traffic zones.\n"
                "🚦 Suggest reducing non-essential outdoor public events.",
      },
      {
        'level': "Unhealthy (151–200)",
        'color': Colors.red,
        'icon': LucideIcons.frown,
        'tip': "📢 Alert the public via media and emergency channels.\n"
            "🧪 Increase air quality checks in high-risk areas.\n"
            "🚫 Limit heavy industrial and transport emissions temporarily.",
      },
      {
        'level': "Very Unhealthy (201–300)",
        'color': Colors.purple,
        'icon': LucideIcons.skull,
        'tip': "🚨 Issue strong public health warnings.\n"
            "🚷 Enforce partial curfews or reduce public transportation.\n"
            "📉 Limit or suspend polluting activities immediately.",
      },
      {
        'level': "Hazardous (301+)",
        'color': Colors.brown,
        'icon': LucideIcons.radiation,
        'tip': "🛑 Declare environmental emergency.\n"
            "📢 Broadcast real-time updates and action plans.\n"
            "🏥 Coordinate emergency services and shelter facilities.",
      },
    ];

    return Scaffold(
      backgroundColor:
          const Color(0xFFf1fdf3), // نفس خلفية RegularUserTipsScreen
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LucideIcons.shieldCheck,
                  size: 22,
                  color: Color(0xFF1b5e20),
                ),
                SizedBox(width: 8),
                Text(
                  "Government Tips",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1b5e20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Guidelines for policy & emergency response 🌍",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.5,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                itemCount: aqiLevels.length,
                itemBuilder: (context, index) {
                  final item = aqiLevels[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: (item['color'] as Color).withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (item['color'] as Color).withOpacity(0.15),
                          ),
                          child: Icon(
                            item['icon'] as IconData,
                            color: item['color'] as Color,
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['level'] as String,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: item['color'] as Color,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item['tip'] as String,
                                style: const TextStyle(
                                  fontSize: 14.5,
                                  height: 1.6,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
