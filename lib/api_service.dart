import 'dart:convert';
import 'dart:math'; // لتوليد بيانات عشوائية
import 'package:http/http.dart' as http;

class AirQualityData {
  final String timestamp;
  final double aqi;
  final double co;
  final double no2;
  final double o3;
  final double so2;
  final double pm25;
  final double pm10;

  AirQualityData({
    required this.timestamp,
    required this.aqi,
    required this.co,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm25,
    required this.pm10,
  });

  // Factory method لتحويل JSON إلى كائن
  factory AirQualityData.fromJson(Map<String, dynamic> json) {
    return AirQualityData(
      timestamp: json['timestamp'],
      aqi: json['aqi'],
      co: json['co'],
      no2: json['no2'],
      o3: json['o3'],
      so2: json['so2'],
      pm25: json['pm25'],
      pm10: json['pm10'],
    );
  }
}

const String WAQI_TOKEN = 'demo'; // ضع التوكن الحقيقي هنا
const String WAQI_BASE_URL = 'https://api.waqi.info/feed';

Future<List<AirQualityData>> fetchAirQualityData(
    DateTime startDate, DateTime endDate) async {
  try {
    final response =
        await http.get(Uri.parse('$WAQI_BASE_URL/cairo/?token=$WAQI_TOKEN'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] != 'ok') {
        throw Exception('Failed to fetch air quality data');
      }

      // توليد بيانات تاريخية بناءً على القيم الحالية
      final days = (endDate.difference(startDate).inHours / 24).ceil();
      final random = Random();

      List<AirQualityData> airQualityDataList = List.generate(days, (i) {
        final date = startDate.add(Duration(days: i));
        final baseAqi = data['data']['aqi'] ?? 80;
        final variation = (random.nextDouble() * 20 - 10);

        return AirQualityData(
          timestamp: date.toIso8601String(),
          aqi: (baseAqi + variation).clamp(0, double.infinity),
          co: (1.2 + random.nextDouble()).clamp(0, double.infinity),
          no2: (0.8 + random.nextDouble() * 0.4).clamp(0, double.infinity),
          o3: (0.4 + random.nextDouble() * 0.2).clamp(0, double.infinity),
          so2: (0.3 + random.nextDouble() * 0.2).clamp(0, double.infinity),
          pm25: ((data['data']['iaqi']['pm25']?['v'] ?? 25) +
                  random.nextDouble() * 10)
              .clamp(0, double.infinity),
          pm10: ((data['data']['iaqi']['pm10']?['v'] ?? 45) +
                  random.nextDouble() * 15)
              .clamp(0, double.infinity),
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
