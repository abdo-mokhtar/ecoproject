import 'package:dropdown_button2/dropdown_button2.dart'
    show
        ButtonStyleData,
        DropdownButton2,
        DropdownStyleData,
        IconStyleData,
        MenuItemStyleData;
import 'package:ecosensetest/models/weather_model.dart';
import 'package:ecosensetest/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, weatherProvider, child) {
        // Handle errors
        if (weatherProvider.weatherData == null && !weatherProvider.isLoading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Error: Failed to load weather data',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                action: SnackBarAction(
                  label: 'Retry',
                  textColor: Colors.white,
                  onPressed: () {
                    weatherProvider.fetchWeatherData();
                  },
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          });
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
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
                              color: Color(0xFF64B5F6), size: 22),
                          const SizedBox(width: 8),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              value: weatherProvider.selectedLocation.name,
                              hint: const Text(
                                'Select City',
                                style: TextStyle(
                                  color: Color(0xFF64B5F6),
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
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  weatherProvider.updateCity(newValue);
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
                                      color: Colors.blue.shade100,
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
                                  color: Color(0xFF64B5F6),
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
                                      return Colors.blue.shade50;
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
                    weatherProvider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _buildMainWeatherCard(weatherProvider.weatherData),
                    const SizedBox(height: 20),
                    _buildWeatherDetails(weatherProvider.weatherData),
                    const SizedBox(height: 20),
                    const Text("24-Hour Forecast",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    SizedBox(
                        height: 150,
                        child: _buildHourlyForecast(
                            weatherProvider.weatherData, context)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainWeatherCard(ApiResponse? response) {
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

  Widget _buildWeatherDetails(ApiResponse? response) {
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

  Widget _buildHourlyForecast(ApiResponse? response, BuildContext context) {
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
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                context.read<WeatherProvider>().fetchWeatherData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.zero,
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
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<WeatherProvider>().fetchWeatherData();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
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
          ],
        ),
      );
    }

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
      thumbVisibility: false,
      thickness: 5,
      radius: const Radius.circular(10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: next24Hours.length,
        itemBuilder: (context, index) {
          final hour = next24Hours[index];
          final hourTime =
              DateTime.fromMillisecondsSinceEpoch((hour.timeEpoch ?? 0) * 1000);
          final formattedTime = DateFormat('h a').format(hourTime);

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
                Text(
                  formattedTime,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                if (hour.condition?.icon != null)
                  Image.network(
                    'https:${hour.condition!.icon}',
                    width: 40,
                    height: 40,
                  ),
                const SizedBox(height: 5),
                Text(
                  '${hour.tempC?.toInt() ?? '--'}°C',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.water_drop,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.air,
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
