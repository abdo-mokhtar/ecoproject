/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String city = "Cairo";
  Map<String, dynamic>? weatherData;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    final apiKey = dotenv.env['WEATHER_API_KEY']; // Ensure your key is correctly stored in .env
    if (apiKey == null || apiKey.isEmpty) {
      setState(() {
        errorMessage = "API key is missing!";
        isLoading = false;
      });
      return;
    }

    final url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          weatherData = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Failed to fetch weather data";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Something went wrong: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Weather"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(
        child: Text(
          errorMessage!,
          style: const TextStyle(color: Colors.red, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      )
          : buildWeatherContent(),
    );
  }

  Widget buildWeatherContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            city,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${weatherData!['main']['temp']}°C",
                    style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    weatherData!['weather'][0]['description'],
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Image.network(
                "https://openweathermap.org/img/wn/${weatherData!['weather'][0]['icon']}@2x.png",
                width: 80,
                height: 80,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              weatherInfo("Humidity", "${weatherData!['main']['humidity']}%"),
              weatherInfo("Wind", "${weatherData!['wind']['speed']} km/h"),
              weatherInfo("Pressure", "${weatherData!['main']['pressure']} hPa"),
            ],
          ),
        ],
      ),
    );
  }

  Widget weatherInfo(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
 */
/*
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      var response = await Dio().get('https://api.example.com/weather');
      setState(() {
        weatherData = response.data;
      });
    } catch (e) {
      print('Error fetching weather data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        centerTitle: true,
      ),
      body: weatherData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cairo",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${weatherData!["temperature"]}°C",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.nights_stay, size: 40),
              ],
            ),
            Text("Clear", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _weatherInfo("Humidity", "${weatherData!["humidity"]}%"),
                _weatherInfo("Wind Speed", "${weatherData!["wind_speed"]} km/h"),
                _weatherInfo("Pressure", "${weatherData!["pressure"]} hPa"),
              ],
            ),
            SizedBox(height: 20),
            Text("24-Hour Forecast", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: weatherData!["hourly"].length,
                itemBuilder: (context, index) {
                  var hourData = weatherData!["hourly"][index];
                  return _hourlyForecast(hourData);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _weatherInfo(String title, String value) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Text(value, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _hourlyForecast(Map<String, dynamic> hourData) {
    return Container(
      width: 80,
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.nights_stay, size: 30),
          Text("${hourData["temp"]}°C", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("${hourData["humidity"]}%", style: TextStyle(fontSize: 14)),
          Text("${hourData["wind_speed"]} km/h", style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
 */
/*import 'package:flutter/material.dart';
import 'package:ecosensetest/services/weather_service.dart';  // استبدل your_app_name باسم مشروعك

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? weatherData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    try {
      Map<String, dynamic> data = await _weatherService.fetchWeather(lat: 30.0444, lon: 31.2357);
      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather in Cairo")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : weatherData == null
          ? Center(child: Text("Failed to load weather data"))
          : _buildWeatherUI(),
    );
  }

  Widget _buildWeatherUI() {
    var currentWeather = weatherData!['current_weather'];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("${currentWeather['temperature']}°C", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          Text("Humidity: ${currentWeather['relative_humidity']}%"),
          Text("Wind Speed: ${currentWeather['windspeed']} km/h"),
          Text("Pressure: ${currentWeather['pressure']} hPa"),
        ],
      ),
    );
  }
}
 */

import 'package:flutter/material.dart';
import 'package:ecosensetest/location-selector-screen.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  Expanded(
          child:Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Expanded(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.cloud_outlined, color: Colors.green,size: 35,),
                    SizedBox(width: 5),
                    Text("Weather", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25)),
                    Spacer(),
                    Icon(Icons.open_in_new, color: Colors.green),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.grey,size: 20,),
                      const Text("Cairo", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      //LocationDropdown()
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child:Expanded(
                        child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          _buildMainWeatherCard(),
                          SizedBox(height: 20),
                          _buildWeatherDetails(),
                          SizedBox(height: 20),
                          Text("24-Hour Forecast", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          SizedBox(height: 150, child: _buildHourlyForecast()),
                        ],
                      ),
                    ),
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

  Widget _buildMainWeatherCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("13°C", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue)),
              Padding(
                padding: EdgeInsets.fromLTRB(60,5,0,0),
                child: Icon(Icons.shield_moon_outlined, color: Colors.blue,size: 45,),
              ),
            ],
          ),
          Text("Feels like 12.3°C", style: TextStyle(fontSize: 16, color: Colors.grey)),
          Text("Clear", style: TextStyle(fontSize: 16, color: Color(0xFF757575))),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(19,0,8,8),
                  child: _buildDetailBox("Humidity", "62%", Icons.water_drop),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,0,20,8),
                  child: _buildDetailBox("Wind Speed", "12 km/h", Icons.air),
                ),

              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(19,8,8,0),
                  child: _buildDetailBox("Pressure", "1024 hPa", Icons.speed),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(8,8,20,0),
                  child: _buildDetailBox("Feels Like", "12°C", Icons.thermostat),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailBox(String title, String value, IconData icon) {
    return Container(
      width: 130,
      height: 110,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.blue, size: 30),
          SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
          SizedBox(height: 2),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildHourlyForecast() {
    final List<Map<String, String>> forecast = [
      {"time": "12AM", "temp": "10°C", "wind": "13 km/h", "humidity": "58%"},
      {"time": "1AM", "temp": "13°C", "wind": "12 km/h", "humidity": "62%"},
      {"time": "2AM", "temp": "10°C", "wind": "10 km/h", "humidity": "60%"},
      {"time": "3AM", "temp": "9°C", "wind": "8 km/h", "humidity": "61%"},
      {"time": "4AM", "temp": "9°C", "wind": "7 km/h", "humidity": "62%"},
      {"time": "12AM", "temp": "10°C", "wind": "13 km/h", "humidity": "58%"},
      {"time": "1AM", "temp": "13°C", "wind": "12 km/h", "humidity": "62%"},
      {"time": "2AM", "temp": "10°C", "wind": "10 km/h", "humidity": "60%"},
      {"time": "3AM", "temp": "9°C", "wind": "8 km/h", "humidity": "61%"},
      {"time": "4AM", "temp": "9°C", "wind": "7 km/h", "humidity": "62%"},
      {"time": "12AM", "temp": "10°C", "wind": "13 km/h", "humidity": "58%"},
      {"time": "1AM", "temp": "13°C", "wind": "12 km/h", "humidity": "62%"},
      {"time": "2AM", "temp": "10°C", "wind": "10 km/h", "humidity": "60%"},
      {"time": "3AM", "temp": "9°C", "wind": "8 km/h", "humidity": "61%"},
      {"time": "4AM", "temp": "9°C", "wind": "7 km/h", "humidity": "62%"},
      {"time": "12AM", "temp": "10°C", "wind": "13 km/h", "humidity": "58%"},
      {"time": "1AM", "temp": "13°C", "wind": "12 km/h", "humidity": "62%"},
      {"time": "2AM", "temp": "10°C", "wind": "10 km/h", "humidity": "60%"},
      {"time": "3AM", "temp": "9°C", "wind": "8 km/h", "humidity": "61%"},
      {"time": "4AM", "temp": "9°C", "wind": "7 km/h", "humidity": "62%"},
      {"time": "12AM", "temp": "10°C", "wind": "13 km/h", "humidity": "58%"},
      {"time": "1AM", "temp": "13°C", "wind": "12 km/h", "humidity": "62%"},
      {"time": "2AM", "temp": "10°C", "wind": "10 km/h", "humidity": "60%"},
      {"time": "3AM", "temp": "9°C", "wind": "8 km/h", "humidity": "61%"},
    ];

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: forecast.length,
      itemBuilder: (context, index) {
        final item = forecast[index];
        return Container(
          width: 100,
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item["time"]!, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              Text(item["temp"]!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
              SizedBox(height: 5),
              Text("${item["humidity"]}", style: TextStyle(fontSize: 12)),
              Text("${item["wind"]}", style: TextStyle(fontSize: 12)),
            ],
          ),
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WeatherScreen(),
  ));
}















