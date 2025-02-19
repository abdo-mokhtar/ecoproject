import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double aspectRatio = screenWidth / screenHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.cloud_outlined,
                          color: Colors.green, size: screenWidth * 0.08),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        "Weather",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.06),
                      ),
                      const Spacer(),
                      Icon(Icons.open_in_new,
                          color: Colors.green, size: screenWidth * 0.06),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          color: Colors.grey, size: screenWidth * 0.05),
                      Text("Cairo",
                          style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  _buildMainWeatherCard(screenWidth, screenHeight),
                  SizedBox(height: screenHeight * 0.03),
                  _buildWeatherDetails(screenWidth, aspectRatio),
                  SizedBox(height: screenHeight * 0.03),
                  Text("24-Hour Forecast",
                      style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: screenHeight * 0.02),
                  SizedBox(
                      height: screenHeight * 0.18,
                      child: _buildHourlyForecast(screenWidth)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainWeatherCard(double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("13°C",
                  style: TextStyle(
                      fontSize: screenWidth * 0.1,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              const Spacer(),
              Icon(Icons.shield_moon_outlined,
                  color: Colors.blue, size: screenWidth * 0.12),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          Text("Feels like 12.3°C",
              style:
                  TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey)),
          Text("Clear",
              style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: const Color(0xFF757575))),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails(double screenWidth, double aspectRatio) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: screenWidth * 0.03,
      mainAxisSpacing: screenWidth * 0.03,
      childAspectRatio: aspectRatio * 2.5,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildDetailBox("Humidity", "62%", Icons.water_drop, screenWidth),
        _buildDetailBox("Wind Speed", "12 km/h", Icons.air, screenWidth),
        _buildDetailBox("Pressure", "1024 hPa", Icons.speed, screenWidth),
        _buildDetailBox("Feels Like", "12°C", Icons.thermostat, screenWidth),
      ],
    );
  }

  Widget _buildDetailBox(
      String title, String value, IconData icon, double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.blue, size: screenWidth * 0.08),
          SizedBox(height: screenWidth * 0.015),
          Text(title,
              style:
                  TextStyle(fontSize: screenWidth * 0.035, color: Colors.grey)),
          Text(value,
              style: TextStyle(
                  fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildHourlyForecast(double screenWidth) {
    final List<Map<String, String>> forecast = [
      {"time": "12AM", "temp": "10°C", "wind": "13 km/h", "humidity": "58%"},
      {"time": "1AM", "temp": "13°C", "wind": "12 km/h", "humidity": "62%"},
      {"time": "2AM", "temp": "10°C", "wind": "10 km/h", "humidity": "60%"},
      {"time": "3AM", "temp": "9°C", "wind": "8 km/h", "humidity": "61%"},
      {"time": "4AM", "temp": "9°C", "wind": "7 km/h", "humidity": "62%"},
    ];

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: forecast.length,
      itemBuilder: (context, index) {
        final item = forecast[index];
        return Container(
          width: screenWidth * 0.28,
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
          padding: EdgeInsets.all(screenWidth * 0.03),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item["time"]!,
                  style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: screenWidth * 0.015),
              Text(item["temp"]!,
                  style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              SizedBox(height: screenWidth * 0.015),
              Text("Humidity: ${item["humidity"]}",
                  style: TextStyle(fontSize: screenWidth * 0.03)),
              Text("Wind: ${item["wind"]}",
                  style: TextStyle(fontSize: screenWidth * 0.03)),
            ],
          ),
        );
      },
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: WeatherScreen(),
  ));
}
