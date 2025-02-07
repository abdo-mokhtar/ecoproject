import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WaterQualityCard extends StatefulWidget {
  @override
  _WaterQualityCardState createState() => _WaterQualityCardState();
}

class _WaterQualityCardState extends State<WaterQualityCard> {
  Future<Map<String, dynamic>> fetchWaterQualityData() async {
    const token = '5ec4a4b7-1f76-4176-a0fb-92b135f402a5';
    final response = await http
        .get(Uri.parse('https://api.waqi.info/feed/cairo/?token=$token'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load water quality data');
    }
  }

  Widget getQualityLabel(double value) {
    if (value <= 50) {
      return Text('Excellent', style: TextStyle(color: Colors.green));
    } else if (value <= 100) {
      return Text('Good', style: TextStyle(color: Colors.blue));
    } else if (value <= 150) {
      return Text('Fair', style: TextStyle(color: Colors.yellow));
    } else if (value <= 200) {
      return Text('Poor', style: TextStyle(color: Colors.orange));
    } else {
      return Text('Very Poor', style: TextStyle(color: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchWaterQualityData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Card(
            elevation: 8,
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text("Loading water quality data..."),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Card(
            elevation: 8,
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.error, color: Colors.red),
                  SizedBox(width: 8),
                  Text("Error loading water quality data"),
                ],
              ),
            ),
          );
        } else if (snapshot.hasData) {
          var waterData = snapshot.data!['data']['iaqi'];
          double ph = waterData['ph']?['v'] ?? 7.0;
          double conductivity = waterData['ec']?['v'] ?? 500.0;
          double turbidity = waterData['t']?['v'] ?? 5.0;

          return Card(
            elevation: 8,
            margin: EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.water_damage, color: Colors.blue),
                          SizedBox(width: 8),
                          Text('Cairo Water Quality',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          // Open URL in browser
                        },
                        child: Text("Data Source",
                            style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  buildQualityRow("pH Level", ph, 14, ph),
                  buildQualityRow(
                      "Conductivity (μS/cm)", conductivity, 1000, conductivity),
                  buildQualityRow("Turbidity (NTU)", turbidity, 10, turbidity),
                  SizedBox(height: 10),
                  Text(
                    "Last updated: ${DateTime.now().toLocal().toString()}",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget buildQualityRow(
      String label, double value, double maxValue, double currentValue) {
    double progress = (currentValue / maxValue) * 100;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text('$value',
                  style: TextStyle(fontSize: 14, color: Colors.blue)),
            ],
          ),
          SizedBox(height: 4),
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Container(
                height: 8,
                width: progress,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
