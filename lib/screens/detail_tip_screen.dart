import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailTipScreen extends StatefulWidget {
  final String level;
  final Color color;

  const DetailTipScreen({
    super.key,
    required this.level,
    required this.color,
  });

  @override
  State<DetailTipScreen> createState() => _DetailTipScreenState();
}

class _DetailTipScreenState extends State<DetailTipScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
            .animate(_fadeAnimation);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData _getIconForLevel(String level) {
    if (level.contains("Good")) return FontAwesomeIcons.faceSmile;
    if (level.contains("Moderate")) return FontAwesomeIcons.faceMeh;
    if (level.contains("Unhealthy for Sensitive"))
      return FontAwesomeIcons.faceFrown;
    if (level.contains("Unhealthy (151")) return FontAwesomeIcons.faceDizzy;
    if (level.contains("Very Unhealthy")) return FontAwesomeIcons.skull;
    if (level.contains("Hazardous")) return FontAwesomeIcons.biohazard;
    return FontAwesomeIcons.circleQuestion;
  }

  String _getLabelForLevel(String level) {
    if (level.contains("Good")) return "Healthy";
    if (level.contains("Moderate")) return "Acceptable";
    if (level.contains("Unhealthy for Sensitive")) return "Caution";
    if (level.contains("Unhealthy (151")) return "Unhealthy";
    if (level.contains("Very Unhealthy")) return "Very Unhealthy";
    if (level.contains("Hazardous")) return "Hazardous";
    return "Unknown";
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> details = {
      "Good (0–50)":
          "Air is clean and stable, allowing for plenty of sunshine and balanced humidity.",
      "Moderate (51–100)":
          "Slightly increased particles may affect visibility and trap heat during the day.",
      "Unhealthy for Sensitive Groups (101–150)":
          "Particles scatter sunlight, reduce direct heating, and make the weather feel dull.",
      "Unhealthy (151–200)":
          "Pollution reduces sunlight, affects cloud formation, and creates a heavy, humid atmosphere.",
      "Very Unhealthy (201–300)":
          "Pollutants significantly increase humidity and make the air feel thick and oppressive.",
      "Hazardous (301+)":
          "Severe pollution traps heat and pollutants near the ground, amplifying health and weather impacts.",
    };

    final Map<String, List<String>> tips = {
      "Good (0–50)": [
        "Enjoy outdoor activities like jogging or cycling.",
        "Open your windows to let in fresh air.",
        "Practice healthy habits like morning walks.",
      ],
      "Moderate (51–100)": [
        "Sensitive groups should monitor symptoms.",
        "Use air purifiers if indoors for long periods.",
        "Limit outdoor exercise during midday.",
      ],
      "Unhealthy for Sensitive Groups (101–150)": [
        "Reduce prolonged outdoor exertion.",
        "Wear masks during outdoor activities.",
        "Keep windows closed and use indoor air filters.",
      ],
      "Unhealthy (151–200)": [
        "Avoid outdoor activities whenever possible.",
        "Use N95 masks outdoors.",
        "Run air purifiers at home continuously.",
      ],
      "Very Unhealthy (201–300)": [
        "Stay indoors and minimize exposure.",
        "Avoid any physical exertion outdoors.",
        "Monitor health and seek medical help if needed.",
      ],
      "Hazardous (301+)": [
        "Emergency alert: Remain indoors.",
        "Seal windows and use air purifiers.",
        "Follow local health advisories closely.",
      ],
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF9FCFB),
      appBar: AppBar(
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
        title: Text(widget.level),
        elevation: 2,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            // ✅ added to fix overflow
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 6,
              shadowColor: widget.color.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      widget.color.withOpacity(0.12),
                      Colors.white.withOpacity(0.95),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              color: widget.color.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                _getIconForLevel(widget.level),
                                size: 60,
                                color: widget.color,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _getLabelForLevel(widget.level),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: widget.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "How Air Quality Affects Weather",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: widget.color,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedOpacity(
                      opacity: 1.0,
                      duration: const Duration(milliseconds: 800),
                      child: Text(
                        details[widget.level] ?? "No detailed info available.",
                        style: const TextStyle(
                          fontSize: 17,
                          height: 1.8,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      "Tips & Precautions",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: widget.color,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...?tips[widget.level]?.map(
                      (tip) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          children: [
                            Icon(Icons.check_circle,
                                color: widget.color, size: 20),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                tip,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
