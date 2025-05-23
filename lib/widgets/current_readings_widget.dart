import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:firebase_database/firebase_database.dart';

class CurrentReadingsWidget extends StatefulWidget {
  const CurrentReadingsWidget({super.key});

  @override
  State<CurrentReadingsWidget> createState() => _CurrentReadingsWidgetState();
}

class _CurrentReadingsWidgetState extends State<CurrentReadingsWidget> {
  final _dbRef = FirebaseDatabase.instance.ref();

  double temperature = 0;
  double humidity = 0;
  double gas = 0;

  @override
  void initState() {
    super.initState();
    _setupDatabase();
    _dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      setState(() {
        temperature = (data['temperature'] as num?)?.toDouble() ?? 0;
        humidity = (data['humidity'] as num?)?.toDouble() ?? 0;
        gas = (data['gas'] as num?)?.toDouble() ?? 0;
      });
    });
  }

  void _setupDatabase() {
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3FCF7),
      body: SafeArea(
        child: SingleChildScrollView(
          // أضفنا SingleChildScrollView هنا
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Current Readings",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                "Live environmental data from the sensors",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              Column(
                children: _buildReadingCards(context), // نمرر context هنا
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildReadingCards(BuildContext context) {
    final cardWidth =
        MediaQuery.of(context).size.width - 32; // عرض البطاقة حسب عرض الشاشة

    return [
      _buildCard(
        context,
        width: cardWidth,
        label: "Temperature",
        value: temperature.toStringAsFixed(1),
        unit: "°C",
        icon: LucideIcons.thermometer,
        status: temperature > 30 ? "Alert" : "Normal",
        statusColor: temperature > 30 ? Colors.red : Colors.green,
      ),
      const SizedBox(height: 16),
      _buildCard(
        context,
        width: cardWidth,
        label: "Humidity",
        value: humidity.toStringAsFixed(1),
        unit: "%",
        icon: LucideIcons.droplets,
        status: humidity < 20 || humidity > 60 ? "Alert" : "Normal",
        statusColor:
            (humidity < 20 || humidity > 60) ? Colors.red : Colors.green,
      ),
      const SizedBox(height: 16),
      _buildCard(
        context,
        width: cardWidth,
        label: "Gas Level",
        value: gas.toStringAsFixed(1),
        unit: "ppm",
        icon: LucideIcons.wind,
        status: gas > 400 ? "Alert" : "Normal",
        statusColor: gas > 400 ? Colors.red : Colors.green,
      ),
    ];
  }

  Widget _buildCard(
    BuildContext context, {
    required double width,
    required String label,
    required String value,
    required String unit,
    required IconData icon,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // مهم لمنع التجاوز
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, size: 20, color: Colors.green),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.circle, size: 10, color: statusColor),
              const SizedBox(width: 4),
              Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
