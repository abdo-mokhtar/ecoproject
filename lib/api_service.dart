/*import 'dart:convert';
import 'package:http/http.dart' as http;

// API keys
const String OPENWEATHER_API_KEY = 'bd5e378503939ddaee76f12ad7a97608';
const String AIRVISUAL_API_KEY = '5ec4a4b7-1f76-4176-a0fb-92b135f402a5';

// Function to fetch air quality data
Future<Map<String, dynamic>?> getAirQualityData() async {
  final String url =
      'https://api.openweathermap.org/data/2.5/air_pollution?lat=30.0444&lon=31.2357&appid=$OPENWEATHER_API_KEY';

  try {
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print('Failed to load air quality data: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching air quality data: $e');
    return null;
  }
}

// Function to fetch water quality data (AirVisual API in this example)
Future<Map<String, dynamic>?> getWaterQualityData() async {
  final String url =
      'https://api.waqi.info/feed/cairo/?token=$AIRVISUAL_API_KEY';

  try {
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      print('Failed to load water quality data: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching water quality data: $e');
    return null;
  }
}
 */
import 'dart:convert';
import 'dart:math';  // Import this for random number generation
import 'package:http/http.dart' as http;

class AirQualityData {
  final String timestamp;
  final double aqi;
  final double co;
  final double no;
  final double no2;
  final double o3;
  final double so2;
  final double pm25;
  final double pm10;
  final double nh3;

  AirQualityData({
    required this.timestamp,
    required this.aqi,
    required this.co,
    required this.no,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm25,
    required this.pm10,
    required this.nh3,
  });

  // Factory method to create AirQualityData from a Map (e.g., JSON)
  factory AirQualityData.fromJson(Map<String, dynamic> json) {
    return AirQualityData(
      timestamp: json['timestamp'],
      aqi: json['aqi'],
      co: json['co'],
      no: json['no'],
      no2: json['no2'],
      o3: json['o3'],
      so2: json['so2'],
      pm25: json['pm25'],
      pm10: json['pm10'],
      nh3: json['nh3'],
    );
  }
}

class WaterQualityData {
  final String timestamp;
  final double ph;
  final double conductivity;
  final double turbidity;

  WaterQualityData({
    required this.timestamp,
    required this.ph,
    required this.conductivity,
    required this.turbidity,
  });

  // Factory method to create WaterQualityData from a Map (e.g., JSON)
  factory WaterQualityData.fromJson(Map<String, dynamic> json) {
    return WaterQualityData(
      timestamp: json['timestamp'],
      ph: json['ph'],
      conductivity: json['conductivity'],
      turbidity: json['turbidity'],
    );
  }
}

const String WAQI_TOKEN = 'demo'; // Replace with your token in production
const String WAQI_BASE_URL = 'https://api.waqi.info/feed';

Future<List<AirQualityData>> fetchAirQualityData(DateTime startDate, DateTime endDate) async {
  try {
    final response = await http.get(Uri.parse('$WAQI_BASE_URL/cairo/?token=$WAQI_TOKEN'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] != 'ok') {
        throw Exception('Failed to fetch air quality data');
      }

      // Generate historical data based on current values
      final days = (endDate.difference(startDate).inHours / 24).ceil();
      final random = Random();  // Create a Random instance

      List<AirQualityData> airQualityDataList = List.generate(days, (i) {
        final date = startDate.add(Duration(days: i));
        final baseAqi = data['data']['aqi'] ?? 80;
        final variation = (random.nextDouble() * 20 - 10);

        return AirQualityData(
          timestamp: date.toIso8601String(),
          aqi: (baseAqi + variation).clamp(0, double.infinity),
          co: (1.2 + random.nextDouble()).clamp(0, double.infinity),
          no: (0.5 + random.nextDouble() * 0.3).clamp(0, double.infinity),
          no2: (0.8 + random.nextDouble() * 0.4).clamp(0, double.infinity),
          o3: (0.4 + random.nextDouble() * 0.2).clamp(0, double.infinity),
          so2: (0.3 + random.nextDouble() * 0.2).clamp(0, double.infinity),
          pm25: ((data['data']['iaqi']['pm25']?['v'] ?? 25) + random.nextDouble() * 10).clamp(0, double.infinity),
          pm10: ((data['data']['iaqi']['pm10']?['v'] ?? 45) + random.nextDouble() * 15).clamp(0, double.infinity),
          nh3: (0.2 + random.nextDouble() * 0.1).clamp(0, double.infinity),
        );
      });

      return airQualityDataList;
    } else {
      throw Exception('Failed to load air quality data');
    }
  } catch (error) {
    print('Error fetching air quality data: $error');
    return [];
  }
}

Future<List<WaterQualityData>> fetchWaterQualityData(DateTime startDate, DateTime endDate) async {
  final days = (endDate.difference(startDate).inHours / 24).ceil();
  final random = Random();  // Create a Random instance

  List<WaterQualityData> waterQualityDataList = List.generate(days, (i) {
    final date = startDate.add(Duration(days: i));
    return WaterQualityData(
      timestamp: date.toIso8601String(),
      ph: 7 + (random.nextDouble() * 0.8 - 0.4),
      conductivity: 400 + (random.nextDouble() * 100),
      turbidity: 3 + (random.nextDouble() * 2),
    );
  });

  return waterQualityDataList;
}
