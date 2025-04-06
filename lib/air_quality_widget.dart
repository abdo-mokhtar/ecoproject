import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ecosensetest/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class AirQualityWidget extends StatefulWidget {
  const AirQualityWidget({super.key});

  @override
  _AirQualityWidgetState createState() => _AirQualityWidgetState();
}

class _AirQualityWidgetState extends State<AirQualityWidget> {
  late Future<List<AirQualityData>> airQualityFuture;

  // قايمة المدن المصرية مع إحداثياتها
  final List<Map<String, dynamic>> egyptianCities = [
    {"name": "Cairo", "lat": 30.0444, "lon": 31.2357},
    {"name": "Giza", "lat": 30.0131, "lon": 31.2089},
    {"name": "Alexandria", "lat": 31.2001, "lon": 29.9187},
    {"name": "Mansoura", "lat": 31.0379, "lon": 31.3743},
    {"name": "Assiut", "lat": 27.1820, "lon": 31.1840},
    {"name": "Luxor", "lat": 25.6872, "lon": 32.6396},
    {"name": "Aswan", "lat": 24.0889, "lon": 32.8998},
    {"name": "Sharm El Sheikh", "lat": 27.9158, "lon": 34.3296},
    {"name": "Hurghada", "lat": 27.2579, "lon": 33.8116},
    {"name": "Port Said", "lat": 31.2653, "lon": 32.3019},
    {"name": "Suez", "lat": 29.9668, "lon": 32.5498},
    {"name": "Zagazig", "lat": 30.5877, "lon": 31.5020},
    {"name": "Tanta", "lat": 30.7865, "lon": 31.0004},
    {"name": "Damietta", "lat": 31.4175, "lon": 31.8144},
    {"name": "Faiyum", "lat": 29.3084, "lon": 30.8441},
  ];

  // المدينة المختارة (افتراضيًا القاهرة)
  Map<String, dynamic> selectedCity = {
    "name": "Cairo",
    "lat": 30.0444,
    "lon": 31.2357
  };

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      airQualityFuture = fetchAirQualityData(
        selectedCity['lat'],
        selectedCity['lon'],
        DateTime.now()
                .subtract(const Duration(days: 7))
                .millisecondsSinceEpoch /
            1000.0, // قيمة الوقت كـ double
        DateTime.now().millisecondsSinceEpoch /
            1000.0, // القيمة الحالية كـ double
      );
    });
  }

  // دالة حساب AQI باستخدام الاستيفاء الخطي
  double calculateAQI(
      double concentration, double Clow, double Chigh, int Ilow, int Ihigh) {
    return ((Ihigh - Ilow) / (Chigh - Clow)) * (concentration - Clow) + Ilow;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: airQualityFuture,
          builder: (context, AsyncSnapshot<List<AirQualityData>> snapshot) {
            print("Snapshot state: ${snapshot.connectionState}");
            print("Snapshot has data: ${snapshot.hasData}");
            print("Snapshot data: ${snapshot.data}");
            print("Snapshot error: ${snapshot.error}");

            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoadingWidget();
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error.toString());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return _buildNoDataWidget();
            }

            final airQuality = snapshot.data!.last;
            print("Displaying data for: ${airQuality.timestamp}");

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(),
                        const Divider(),
                        _buildAirQualityIndex(airQuality.aqi),
                        const SizedBox(height: 12),
                        _buildPollutant("CO", airQuality.co, 1000),
                        _buildPollutant("NO₂", airQuality.no2, 200),
                        _buildPollutant("O₃", airQuality.o3, 120,
                            color: Colors.orange),
                        _buildPollutant("SO₂", airQuality.so2, 20),
                        _buildPollutant("PM2.5", airQuality.pm25, 50),
                        _buildPollutant("PM10", airQuality.pm10, 100),
                        const Divider(),
                        _buildBottomSection(airQuality.timestamp),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'Loading Air Quality Data...',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "Error: $error",
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildNoDataWidget() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            const BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 50, color: Colors.redAccent),
            const SizedBox(height: 10),
            const Text(
              "No Data Available",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Please check your network settings or try another city.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 15),

            // زر Retry مع تحسين الشكل والتدرج
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade400,
                    Colors.blue.shade400
                  ], // تدرج اللون
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.shade200.withOpacity(0.5), // ظل ناعم
                    blurRadius: 6,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  _refreshData();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // شفاف ليظهر التدرج
                  shadowColor: Colors.transparent,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Retry",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.air, color: Colors.green, size: 28),
        const SizedBox(width: 8),

        // City name + Air Quality with Expanded to take full available width
        Expanded(
          child: Text(
            "${selectedCity['name']} Air Quality",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(width: 8), // Provide spacing to avoid tight layout

        // City Dropdown
        _buildCityDropdown(),
      ],
    );
  }

  Widget _buildCityDropdown() {
    return Container(
      width:
          150, // Set a specific width for the dropdown to avoid it expanding too much
      child: DropdownButton<String>(
        value: selectedCity['name'],
        icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
        underline: const SizedBox(),
        onChanged: (newCityName) {
          if (newCityName != null) {
            final newCity = egyptianCities.firstWhere(
              (city) => city['name'] == newCityName,
              orElse: () => egyptianCities[0],
            );
            setState(() {
              selectedCity = newCity;
              _refreshData();
            });
          }
        },
        items: egyptianCities.map((city) {
          return DropdownMenuItem<String>(
            value: city['name'],
            child: Text(
              city['name'],
              style: const TextStyle(
                color: Colors.green,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAirQualityIndex(double aqi) {
    int roundedAQI = aqi.round();
    String status = "Good";
    Color color = Colors.green;

    if (roundedAQI > 50 && roundedAQI <= 100) {
      status = "Moderate";
      color = Colors.yellow;
    } else if (roundedAQI > 100 && roundedAQI <= 150) {
      status = "Unhealthy for Sensitive Groups";
      color = Colors.orange;
    } else if (roundedAQI > 150 && roundedAQI <= 200) {
      status = "Unhealthy";
      color = Colors.red;
    } else if (roundedAQI > 200 && roundedAQI <= 300) {
      status = "Very Unhealthy";
      color = Colors.purple;
    } else if (roundedAQI > 300) {
      status = "Hazardous";
      color = Colors.brown;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Air Quality Index (AQI)",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "$roundedAQI - $status",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPollutant(String name, double value, double max,
      {Color color = Colors.green}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: (value / max).clamp(0.0, 1.0),
          backgroundColor: Colors.grey.shade300,
          color: color,
          minHeight: 8,
        ),
        const SizedBox(height: 4),
        Text(
          "${value.toStringAsFixed(1)} µg/m³",
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildBottomSection(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedDate = DateFormat('yyyy/MM/dd').format(dateTime);
    String formattedTime = DateFormat('HH:mm').format(dateTime);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date: $formattedDate",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              "Time: $formattedTime",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        _buildRefreshButton(),
      ],
    );
  }

  Widget _buildRefreshButton() {
    return InkWell(
      onTap: _refreshData,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade300, Colors.blue.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.refresh, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              "Refresh",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
