import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AirQualityCard extends StatefulWidget {
  @override
  _AirQualityCardState createState() => _AirQualityCardState();
}

class _AirQualityCardState extends State<AirQualityCard> {
  Map<String, dynamic>? airQualityData;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchAirQualityData();
  }

  Future<void> _fetchAirQualityData() async {
    const token = 'demo'; // Replace with your token in production
    final url = 'https://api.waqi.info/feed/cairo/?token=$token';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'ok') {
          setState(() {
            airQualityData = data['data'];
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'Failed to fetch air quality data';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Failed to fetch air quality data';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching data: $e';
        isLoading = false;
      });
    }
  }

  String getAQILabel(int aqi) {
    if (aqi <= 50) return 'Good';
    if (aqi <= 100) return 'Moderate';
    if (aqi <= 150) return 'Unhealthy for Sensitive Groups';
    if (aqi <= 200) return 'Unhealthy';
    return 'Very Unhealthy';
  }

  Color getAQIColor(int aqi) {
    if (aqi <= 50) return Colors.green;
    if (aqi <= 100) return Colors.yellow;
    if (aqi <= 150) return Colors.orange;
    if (aqi <= 200) return Colors.red;
    return Colors.purple;
  }

  double normalizeValue(double value, double max) {
    return (value / max).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: const Padding(
          padding: const EdgeInsets.all(16.0),
          child: const Column(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text('Loading Air Quality Data...'),
            ],
          ),
        ),
      );
    }

    if (errorMessage.isNotEmpty) {
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.error, color: Colors.red, size: 32),
              const SizedBox(width: 8),
              Expanded(
                  child: Text(errorMessage,
                      style: const TextStyle(color: Colors.red))),
            ],
          ),
        ),
      );
    }

    final aqi = airQualityData?['aqi'] ?? 0;
    final components = airQualityData?['iaqi'] ?? {};

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    const Icon(Icons.air, color: Colors.green, size: 32),
                    const SizedBox(width: 8),
                    const Text('Cairo Air Quality',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    // Open the external link
                    // Open URL: "https://openweathermap.org/api/air-pollution"
                  },
                  child: const Text(
                    'Data Source',
                    style: const TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Air Quality Index: ${getAQILabel(aqi)}',
                style: const TextStyle(fontSize: 14)),
            LinearProgressIndicator(
              value: normalizeValue(aqi.toDouble(), 500),
              minHeight: 6,
              valueColor: AlwaysStoppedAnimation<Color>(getAQIColor(aqi)),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            for (var entry in components.entries)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${entry.key.toUpperCase()}: ${entry.value['v']} μg/m³',
                        style: const TextStyle(fontSize: 14)),
                    LinearProgressIndicator(
                      value: normalizeValue(entry.value['v'].toDouble(), 200),
                      minHeight: 6,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(entry.value['v'] <= 100
                              ? Colors.green
                              : entry.value['v'] <= 150
                                  ? Colors.yellow
                                  : Colors.red),
                      backgroundColor: Colors.grey[300],
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Text('Last updated: ${DateTime.now().toLocal()}'),
          ],
        ),
      ),
    );
  }
}
