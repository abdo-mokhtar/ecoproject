import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RegularUserTipsScreen extends StatelessWidget {
  const RegularUserTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> aqiLevels = [
      {
        'level': "Good (0–50)",
        'color': const Color(0xFF81c784),
        'icon': LucideIcons.sun,
        'tip': "☀️ Excellent air quality — enjoy outdoor activities freely!\n"
            "🏃‍♂️ Great time for jogging, biking, or taking kids to the park.\n"
            "🌬️ Open windows to ventilate your home and bring in fresh air.",
      },
      {
        'level': "Moderate (51–100)",
        'color': const Color(0xFFdce775),
        'icon': LucideIcons.cloudSun,
        'tip': "😷 Air is okay — sensitive individuals should be cautious.\n"
            "🚶‍♀️ Take short outdoor breaks instead of long exposure.\n"
            "🪴 Keep indoor plants to help filter air naturally.",
      },
      {
        'level': "Unhealthy for Sensitive Groups (101–150)",
        'color': Colors.orange,
        'icon': LucideIcons.alertTriangle,
        'tip':
            "🚫 Avoid intense outdoor activity if you have asthma or heart issues.\n"
                "😷 Wear a mask if staying outside for long.\n"
                "💊 Keep your medication or inhaler close at all times.",
      },
      {
        'level': "Unhealthy (151–200)",
        'color': Colors.red,
        'icon': LucideIcons.frown,
        'tip': "❌ Avoid outdoor exercise — especially during midday.\n"
            "🏠 Stay indoors with windows and doors shut.\n"
            "🧼 Use air purifiers to keep indoor air clean.",
      },
      {
        'level': "Very Unhealthy (201–300)",
        'color': Colors.purple,
        'icon': LucideIcons.skull,
        'tip':
            "⚠️ Significant health risk — stay indoors as much as possible.\n"
                "🧴 Avoid indoor pollutants like candles or incense.\n"
                "😷 Wear a certified mask if you need to go outside.\n"
                "💧 Drink plenty of water to keep lungs hydrated.",
      },
      {
        'level': "Hazardous (301+)",
        'color': Colors.brown,
        'icon': LucideIcons.radiation,
        'tip': "🚨 Emergency conditions — avoid all outdoor exposure.\n"
            "🔒 Seal windows and doors, and stay in the cleanest room.\n"
            "🌬️ Use HEPA filters and keep air clean indoors.\n"
            "📢 Follow government health alerts and stay updated.",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFf1fdf3), // خلفية مريحة للعين
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  LucideIcons.user,
                  size: 22,
                  color: Color(0xFF2e7d32),
                ),
                SizedBox(width: 8),
                Text(
                  "Regular User Tips",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2e7d32),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Practical guidance for everyday air quality 🌿",
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
