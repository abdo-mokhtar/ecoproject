import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ecosensetest/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class AirQualityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchAirQualityData(
          DateTime.now().subtract(const Duration(days: 7)), DateTime.now()),
      builder: (context, AsyncSnapshot<List<AirQualityData>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading Air Quality Data...'),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No data available"));
        }

        final airQuality = snapshot.data!.last;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.air, color: Colors.green, size: 28),
                      const SizedBox(width: 8),
                      const Text("Cairo Air Quality",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      _buildDataSourceLink(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildAirQualityIndex(airQuality.aqi),
                  const SizedBox(height: 8),
                  _buildPollutant("CO", airQuality.aqi * 1.2, 300),
                  _buildPollutant("NO", airQuality.aqi * 0.1, 1),
                  _buildPollutant("NO₂", airQuality.aqi * 0.2, 10),
                  _buildPollutant("O₃", airQuality.aqi * 0.8, 100,
                      color: Colors.orange),
                  _buildPollutant("SO₂", airQuality.aqi * 0.3, 15),
                  _buildPollutant("PM2.5", airQuality.pm25, 25),
                  _buildPollutant("PM10", airQuality.pm10, 50),
                  _buildPollutant("NH₃", airQuality.aqi * 0.15, 5),
                  const SizedBox(height: 12),
                  _buildTimestamp(airQuality.timestamp),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDataSourceLink() {
    final Uri url = Uri.parse("https://openweathermap.org/api/air-pollution");

    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Data Source",
            style: const TextStyle(
                color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.open_in_new, size: 16, color: Colors.green),
        ],
      ),
    );
  }

  Widget _buildAirQualityIndex(double aqi) {
    String status = "Good";
    Color color = Colors.green;

    if (aqi > 50) {
      status = "Moderate";
      color = Colors.yellow;
    }
    if (aqi > 100) {
      status = "Unhealthy";
      color = Colors.red;
    }

    return Row(
      children: [
        Expanded(
          child: LinearProgressIndicator(
            value: aqi / 200,
            backgroundColor: Colors.grey.shade300,
            color: color,
            minHeight: 8,
          ),
        ),
        const SizedBox(width: 8),
        Text(status,
            style: TextStyle(fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildPollutant(String name, double value, double max,
      {Color color = Colors.green}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: (value / max).clamp(0.0, 1.0),
              backgroundColor: Colors.grey.shade300,
              color: color,
              minHeight: 6,
            ),
          ),
          const SizedBox(width: 8),
          Text("${value.toStringAsFixed(2)} µg/m³",
              style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTimestamp(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    String formattedTime = DateFormat('HH:mm').format(dateTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("Date: ",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(formattedDate),
          ],
        ),
        Row(
          children: [
            const Text("Time: ",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(formattedTime),
          ],
        ),
      ],
    );
  }
}
