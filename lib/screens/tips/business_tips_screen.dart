// import 'package:ecosensetest/widgets/aqi_level_card.dart' show AQILevelCard;
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../eco_delivery_dialog.dart';

class BusinessTipsScreen extends StatelessWidget {
  const BusinessTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // عرض الديالوج عند أول تحميل للشاشة
    Future.microtask(() {
      EcoDeliveryDialog.show(context);
    });

    final List<Map<String, dynamic>> aqiLevels = [
      {
        'level': "Good (0–50)",
        'color': Colors.green,
        'icon': LucideIcons.smile,
        'tip': "✅ No restrictions — safe to operate as usual.\n"
            "🌿 Encourage green practices and sustainable habits in the workplace.\n"
            "📢 Highlight eco-friendly business initiatives to employees and clients.",
      },
      {
        'level': "Moderate (51–100)",
        'color': Colors.yellow,
        'icon': LucideIcons.meh,
        'tip':
            "⚠️ Air quality is acceptable, but some pollutants may be present.\n"
                "🧑‍⚕️ Monitor staff with respiratory issues or allergies.\n"
                "🪴 Improve indoor air with plants or air purifiers.",
      },
      {
        'level': "Unhealthy for Sensitive Groups (101–150)",
        'color': Colors.orange,
        'icon': LucideIcons.alertTriangle,
        'tip': "🚷 Limit prolonged outdoor work for vulnerable employees.\n"
            "🛠️ Improve indoor air filtration systems.\n"
            "🧰 Offer protective gear if outdoor tasks are necessary.",
      },
      {
        'level': "Unhealthy (151–200)",
        'color': Colors.red,
        'icon': LucideIcons.frown,
        'tip': "❌ Avoid scheduling outdoor meetings or labor tasks.\n"
            "🕓 Adjust work hours to reduce exposure.\n"
            "📦 Enable flexible or remote work policies where applicable.",
      },
      {
        'level': "Very Unhealthy (201–300)",
        'color': Colors.purple,
        'icon': LucideIcons.skull,
        'tip': "🚨 Significant health risk for all employees.\n"
            "🏠 Recommend remote work for most departments.\n"
            "🔒 Seal windows and minimize ventilation with outside air.",
      },
      {
        'level': "Hazardous (301+)",
        'color': Colors.brown,
        'icon': LucideIcons.radiation,
        'tip': "🛑 Emergency level — suspend all non-essential on-site operations.\n"
            "💻 Fully switch to remote work protocols.\n"
            "📢 Communicate clearly with staff and stakeholders about the situation.",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFf1fdf3),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LucideIcons.briefcase,
                  size: 22,
                  color: Color(0xFF2e7d32),
                ),
                SizedBox(width: 8),
                Text(
                  "Business Tips",
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
              "Recommendations for safe business operations 💼",
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
                            // ignore: deprecated_member_use
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
