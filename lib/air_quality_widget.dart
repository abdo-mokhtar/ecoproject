import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ecosensetest/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class AirQualityWidget extends StatefulWidget {
  @override
  _AirQualityWidgetState createState() => _AirQualityWidgetState();
}

class _AirQualityWidgetState extends State<AirQualityWidget> {
  late Future<List<AirQualityData>> airQualityFuture;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() {
    setState(() {
      airQualityFuture = fetchAirQualityData(
          DateTime.now().subtract(const Duration(days: 7)), DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: airQualityFuture,
          builder: (context, AsyncSnapshot<List<AirQualityData>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildLoadingWidget();
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error.toString());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return _buildNoDataWidget();
            }

            final airQuality = snapshot.data!.last;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
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
                        _buildPollutant("CO", airQuality.co, 300),
                        _buildPollutant("NO₂", airQuality.no2, 10),
                        _buildPollutant("O₃", airQuality.o3, 100,
                            color: Colors.orange),
                        _buildPollutant("SO₂", airQuality.so2, 15),
                        _buildPollutant("PM2.5", airQuality.pm25, 25),
                        _buildPollutant("PM10", airQuality.pm10, 50),
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
          padding: const EdgeInsets.all(16.0),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text(
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
        child: Text("Error: $error",
            style: const TextStyle(color: Colors.red, fontSize: 16)),
      ),
    );
  }

  Widget _buildNoDataWidget() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text("No data available",
            style: TextStyle(color: Colors.grey, fontSize: 16)),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(Icons.air, color: Colors.green, size: 28),
        const SizedBox(width: 8),
        const Text(
          "Cairo Air Quality",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        _buildDataSourceLink(),
      ],
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
          Text(
            "Data Source",
            style: TextStyle(
                color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 4),
          Icon(Icons.open_in_new, size: 16, color: Colors.green),
        ],
      ),
    );
  }

  Widget _buildAirQualityIndex(double aqi) {
    String status = "Good";
    Color color = Colors.green;

    if (aqi > 50) {
      status = "Moderate";
      color = Colors.yellow.shade600;
    }
    if (aqi > 100) {
      status = "Unhealthy";
      color = Colors.red;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Air Quality Index: ",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: (aqi / 200).clamp(0.0, 1.0),
          backgroundColor: Colors.grey.shade300,
          color: color,
          minHeight: 8,
        ),
        const SizedBox(height: 4),
        Text(status,
            style: TextStyle(fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildPollutant(String name, double value, double max,
      {Color color = Colors.green}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(
              width: 50,
              child: Text(name,
                  style: const TextStyle(fontWeight: FontWeight.bold))),
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
          Text("${value.toStringAsFixed(1)} µg/m³",
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
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
            Text("Date: $formattedDate",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Time: $formattedTime",
                style: const TextStyle(fontWeight: FontWeight.bold)),
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
          color: Colors.green,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.refresh, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text("Refresh",
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
