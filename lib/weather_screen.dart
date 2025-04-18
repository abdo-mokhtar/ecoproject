import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart'
    show
        ButtonStyleData,
        DropdownButton2,
        DropdownStyleData,
        IconStyleData,
        MenuItemStyleData;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ecosensetest/weather_api.dart';
import 'package:ecosensetest/weather_model.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  ApiResponse? response;
  bool inProgress = false;
  Location mylocation = Location(
      name: 'Cairo',
      region: 'Al Qahirah',
      country: 'Egypt',
      lat: 30.05,
      lon: 31.25,
      tzId: "Africa/Cairo",
      localtimeEpoch: 1741458073,
      localtime: "2025-03-08 20:21");

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final myWeather = WeatherApi();

    try {
      setState(() {
        inProgress = true;
      });

      // Get weather data including forecast
      final currentResponse = await myWeather.getWeatherData(
          mylocation.name, "current.json", false);
      final forecastResponse = await myWeather.getWeatherData(
          mylocation.name, "forecast.json", true);

      final weatherData = ApiResponse(
        location: mylocation,
        current: Current.fromJson(jsonDecode(currentResponse.body)['current']),
        forecast:
            Forecast.fromJson(jsonDecode(forecastResponse.body)["forecast"]),
      );
      setState(() {
        response = weatherData;
        inProgress = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print('error');
      }

      setState(() {
        inProgress = false;
      });

      // Show error message to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error : $e',
            style: const TextStyle(color: Colors.white), // Text color
          ),
          backgroundColor: Colors.red, // Background color
          behavior: SnackBarBehavior.floating, // Floating effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
          action: SnackBarAction(
            label: 'Retry',
            textColor: Colors.white,
            onPressed: () {
              fetchWeatherData(); // Retry fetching data
            },
          ),
          duration: const Duration(seconds: 3), // Auto-dismiss duration
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.cloud_outlined,
                          color: Color(0xFF64B5F6), size: 35),
                      SizedBox(width: 5),
                      Text("Weather",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25)),
                      Spacer(),
                      Icon(Icons.open_in_new, color: Color(0xFF64B5F6)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            color: Color(0xFF64B5F6),
                            size: 22), // زيادة حجم الأيقونة قليلاً
                        const SizedBox(width: 8), // زيادة المسافة
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            value: mylocation.name,
                            hint: const Text(
                              'Select City',
                              style: const TextStyle(
                                color: const Color(0xFF64B5F6), // أخضر داكن
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            items: [
                              "Alexandria",
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
                                child: Text(
                                  city,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade800, // رمادي داكن
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  mylocation.name = newValue;
                                  fetchWeatherData();
                                });
                              }
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 40,
                              width: 150,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFF64B5F6),
                                  width: 1,
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.shade100, // ظل أخضر فاتح
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 300,
                              width: 220,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.blue.shade100.withOpacity(0.3),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.blue.shade50,
                                    Colors.white,
                                  ],
                                ),
                              ),
                              offset: const Offset(0, -5),
                            ),
                            iconStyleData: IconStyleData(
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: const Color(0xFF64B5F6), // أخضر داكن
                                size: 28,
                              ),
                              openMenuIcon: Icon(
                                Icons.arrow_drop_up,
                                color: Colors.blue.shade800,
                              ),
                            ),
                            menuItemStyleData: MenuItemStyleData(
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              overlayColor:
                                  WidgetStateProperty.resolveWith<Color>(
                                (states) {
                                  if (states.contains(WidgetState.hovered)) {
                                    return Colors.blue
                                        .shade50; // تأثير أخضر فاتح عند hover
                                  }
                                  return Colors.transparent;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  inProgress
                      ? const CircularProgressIndicator()
                      : _buildMainWeatherCard(),
                  const SizedBox(height: 20),
                  _buildWeatherDetails(),
                  const SizedBox(height: 20),
                  const Text("24-Hour Forecast",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
              Text("${response?.current?.tempC?.toInt() ?? '--'}°C",
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              const Spacer(),
              //weather image condition
              if (response?.current?.condition?.icon != null)
                Container(
                  padding: const EdgeInsets.all(2),
                  child: Image.network(
                    'https:${response?.current?.condition?.icon}',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error,
                          size: 40, color: Colors.red);
                    },
                  ),
                )
            ],
          ),
          Text("Feels like ${response?.current?.feelslikeC?.toInt() ?? '--'}°C",
              style: const TextStyle(fontSize: 16, color: Colors.grey)),
          Text(response?.current?.condition?.text ?? "--",
              style: const TextStyle(fontSize: 16, color: Color(0xFF757575))),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildDetailBox(
                  "Humidity",
                  "${response?.current?.humidity ?? '--'}%",
                  Icons.water_drop,
                ),
                _buildDetailBox(
                  "Wind Speed",
                  "${response?.current?.windKph?.toInt() ?? '--'} km/h",
                  Icons.air,
                ),
                _buildDetailBox(
                  "Pressure",
                  "${response?.current?.pressureMb?.toInt() ?? '--'} hPa",
                  Icons.speed,
                ),
                _buildDetailBox(
                  "Feels Like",
                  "${response?.current?.feelslikeC?.toInt() ?? '--'}°C",
                  Icons.thermostat,
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF42A5F5), size: 30),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 2),
          Text(value,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildHourlyForecast() {
    // Get all hourly data from multiple days
    final day1HourlyData = response?.forecast?.forecastday?[0].hour;
    final day2HourlyData = response?.forecast?.forecastday?[1].hour;

    if (day1HourlyData == null ||
        day1HourlyData.isEmpty ||
        day2HourlyData == null ||
        day2HourlyData.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'No forecast data available.\nPlease check your internet connection.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 12), // تقليل المسافة بين النص والزرار
            ElevatedButton(
              onPressed: () {
                fetchWeatherData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent, // مهم لجعل التدرج يعمل
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // تقليل انحناء الزوايا
                ),
                padding: EdgeInsets.zero, // إزالة الـ padding الافتراضي
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.blue.shade300],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade700, Colors.blue.shade300],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade700, Colors.blue.shade300],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        fetchWeatherData();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.transparent, // مهم لجعل التدرج يعمل
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Retry",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Filter to get only the next 24 hours
    final now = DateTime.now();
    final next24Hours = [
      ...(day1HourlyData),
      ...(day2HourlyData),
    ].where((hour) {
      final hourTime =
          DateTime.fromMillisecondsSinceEpoch((hour.timeEpoch ?? 0) * 1000);
      return hourTime.isAfter(now) &&
          hourTime.isBefore(now.add(const Duration(hours: 24)));
    }).toList();

    if (next24Hours.isEmpty) {
      return const Center(child: Text('No hourly data available'));
    }

    return Scrollbar(
      // Wrap with Scrollbar
      thumbVisibility: false, // Make the thumb always visible
      thickness: 5, // Adjust thickness
      radius: const Radius.circular(10), // Rounded edges for the scrollbar
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: next24Hours.length,
        itemBuilder: (context, index) {
          final hour = next24Hours[index];
          final hourTime =
              DateTime.fromMillisecondsSinceEpoch((hour.timeEpoch ?? 0) * 1000);
          final formattedTime =
              DateFormat('h a').format(hourTime); // Format to AM/PM

          return Container(
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              border: Border.all(
                color: Colors.lightBlueAccent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Time display (h:mm a)
                Text(
                  formattedTime,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                // Weather icon
                if (hour.condition?.icon != null)
                  Image.network(
                    'https:${hour.condition!.icon}',
                    width: 40,
                    height: 40,
                  ),
                const SizedBox(height: 5),
                // Temperature display
                Text(
                  '${hour.tempC?.toInt() ?? '--'}°C',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const SizedBox(height: 5),
                // Humidity display
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.water_drop, // Humidity icon
                      size: 16,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${hour.humidity ?? '--'}%',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                // Wind speed display
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.air, // Wind icon
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${hour.windKph?.toInt() ?? '--'} km/h',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: WeatherScreen(),
  ));
}
