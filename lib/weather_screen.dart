import 'package:flutter/material.dart';
import 'package:ecosensetest/weather_api.dart';
import 'package:ecosensetest/weathermodel.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  ApiResponse? response;
  bool inProgress = false;
  String selectedCity = "Cairo";

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    setState(() => inProgress = true);
    response = await WeatherApi().getCurrentWeather(selectedCity);
    setState(() => inProgress = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.cloud_outlined, color: Colors.green, size: 35),
                      const SizedBox(width: 5),
                      const Text("Weather", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25)),
                      const Spacer(),
                      const Icon(Icons.open_in_new, color: Colors.green),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined, color: Colors.grey, size: 20),
                        const SizedBox(width: 5),
                        DropdownButton<String>(
                          value: selectedCity,
                          items: [ "Alexandria",
                            "Aswan",
                            "Asyut",
                            "Beheira",
                            "Beni Suef",
                            "Cairo",
                            "Dakahlia",
                            "Damietta",
                            "Faiyum",
                            "Gharbia",
                            "Giza",
                            "Ismailia",
                            "Kafr El Sheikh",
                            "Luxor",
                            "Matrouh",
                            "Minya",
                            "Monufia",
                            "New Valley",
                            "North Sinai",
                            "Port Said",
                            "Qalyubia",
                            "Qena",
                            "Red Sea",
                            "Sharqia",
                            "Sohag",
                            "South Sinai",
                            "Suez"
                          ].map((String city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCity = newValue!;
                              fetchWeatherData();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  inProgress ? const CircularProgressIndicator() : _buildMainWeatherCard(),
                  const SizedBox(height: 20),
                  _buildWeatherDetails(),
                  const SizedBox(height: 20),
                  const Text("24-Hour Forecast", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  SizedBox(height: 150, child: _buildHourlyForecast()),
                ],
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("${response?.current?.tempC?.toInt()?? '--'}°C", style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue)),
              const Spacer(),
              const Icon(Icons.shield_moon_outlined, color: Colors.blue, size: 45),
            ],
          ),
          Text("Feels like ${response?.current?.feelslikeC ?? '--'}°C", style: const TextStyle(fontSize: 16, color: Colors.grey)),
          Text(response?.current?.condition?.text ?? "--", style: const TextStyle(fontSize: 16, color: Color(0xFF757575))),
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
        child:_buildDetailBox("Humidity", "${response?.current?.humidity ?? '--'}%", Icons.water_drop),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8,0,20,8),
          child:_buildDetailBox("Wind Speed", "${response?.current?.windKph?.toInt() ?? '--'} km/h", Icons.air),
        ),
      ],
    ),
     Row(
       children: [
         Padding(
           padding: const EdgeInsets.fromLTRB(19,8,8,0),
           child: _buildDetailBox("Pressure", "${response?.current?.pressureMb?.toInt() ?? '--'} hPa", Icons.speed),
         ),
         Padding(
           padding: const EdgeInsets.fromLTRB(8,8,20,0),
           child: _buildDetailBox("Feels Like", "${response?.current?.feelslikeC?.toInt() ?? '--'}°C", Icons.thermostat),
        ),
      ],
     ),
    ],
   ),
  ),
 );
}
///////////////////////////////////////////////////////////////////////
  Widget _buildDetailBox(String title, String value, IconData icon) {
    return Container(
      width: 130,
      height: 110,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: Color(0xFF42A5F5), size: 30),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
  Widget _buildHourlyForecast() {
    final List<Map<String, String>> forecast = [
      {"time": "12AM","temp": "10°C", "wind": "13 km/h", "humidity": "58%"},
      {"time": "1AM", "temp": "13°C", "wind": "12 km/h", "humidity": "62%"},
      {"time": "2AM", "temp": "10°C", "wind": "10 km/h", "humidity": "60%"},
      {"time": "3AM", "temp": "9°C", "wind": "8 km/h", "humidity": "61%"},
      {"time": "4AM", "temp": "9°C", "wind": "7 km/h", "humidity": "62%"},
      {"time": "5AM", "temp": "10°C", "wind": "13 km/h", "humidity": "58%"},
      {"time": "6AM", "temp": "13°C", "wind": "12 km/h", "humidity": "62%"},
      {"time": "7AM", "temp": "10°C", "wind": "10 km/h", "humidity": "60%"},
      {"time": "8AM", "temp": "9°C", "wind": "8 km/h", "humidity": "61%"},
      {"time": "9AM", "temp": "9°C", "wind": "7 km/h", "humidity": "62%"},
      {"time": "10AM", "temp": "10°C", "wind": "13 km/h", "humidity": "58%"},
      {"time": "11M", "temp": "13°C", "wind": "12 km/h", "humidity": "62%"},
      {"time": "12AM", "temp": "10°C", "wind": "13 km/h", "humidity": "58%"},
      {"time": "1AM", "temp": "13°C", "wind": "12 km/h", "humidity": "62%"},
      {"time": "2AM", "temp": "10°C", "wind": "10 km/h", "humidity": "60%"},
      {"time": "3AM", "temp": "9°C", "wind": "8 km/h", "humidity": "61%"},
      {"time": "4AM", "temp": "9°C", "wind": "7 km/h", "humidity": "62%"},
      {"time": "5AM", "temp": "10°C", "wind": "13 km/h", "humidity": "58%"},
      {"time": "6AM", "temp": "13°C", "wind": "12 km/h", "humidity": "62%"},
      {"time": "7AM", "temp": "10°C", "wind": "10 km/h", "humidity": "60%"},
      {"time": "8AM", "temp": "9°C", "wind": "8 km/h", "humidity": "61%"},
      {"time": "9AM", "temp": "9°C", "wind": "7 km/h", "humidity": "62%"},
      {"time": "10AM", "temp": "10°C", "wind": "13 km/h", "humidity": "58%"},
      {"time": "11M", "temp": "13°C", "wind": "12 km/h", "humidity": "62%"},
    ];

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: forecast.length,
      itemBuilder: (context, index) {
        final item = forecast[index];
        return Container(
          width: 100,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item["time"]!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              //Image.asset("${item["image"]}"),
              //const SizedBox(height: 5),
              Text(item["temp"]!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
              const SizedBox(height: 5),
              Text("${item["humidity"]}", style: const TextStyle(fontSize: 12)),
              Text("${item["wind"]}", style: const TextStyle(fontSize: 12)),
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