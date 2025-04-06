import 'dart:convert';
import 'package:http/http.dart' as http;

// كلاس لتمثيل بيانات جودة الهواء
class AirQualityData {
  final String timestamp;
  final double pm10;
  final double pm25;
  final double co;
  final double no2;
  final double so2;
  final double o3;
  final double aqi;

  AirQualityData({
    required this.timestamp,
    required this.pm10,
    required this.pm25,
    required this.co,
    required this.no2,
    required this.so2,
    required this.o3,
    required this.aqi,
  });
}

// دالة لجلب البيانات من API
Future<List<AirQualityData>> fetchAirQualityData(
    double lat, double lon, double from, double to) async {
  final url =
      'https://air-quality-api.open-meteo.com/v1/air-quality?latitude=$lat&longitude=$lon&start=$from&end=$to&hourly=pm10,pm2_5,carbon_monoxide,nitrogen_dioxide,sulphur_dioxide,ozone';

  print("➡️ Fetching air quality data from: $url");

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      print("✅ Raw API response: $json");

      if (json['hourly'] == null || json['hourly']['time'] == null) {
        print("⚠️ No hourly data in the response!");
        return [];
      }

      final time = List<String>.from(json['hourly']['time']);
      final pm10 = List<double>.from(json['hourly']['pm10']);
      final pm25 = List<double>.from(json['hourly']['pm2_5']);
      final co = List<double>.from(json['hourly']['carbon_monoxide']);
      final no2 = List<double>.from(json['hourly']['nitrogen_dioxide']);
      final so2 = List<double>.from(json['hourly']['sulphur_dioxide']);
      final o3 = List<double>.from(json['hourly']['ozone']);

      List<AirQualityData> data = [];

      for (int i = 0; i < time.length; i++) {
        data.add(AirQualityData(
          timestamp: time[i],
          pm10: pm10[i],
          pm25: pm25[i],
          co: co[i],
          no2: no2[i],
          so2: so2[i],
          o3: o3[i],
          aqi: pm25[i], // ممكن لاحقًا تستخدم دالة حساب AQI حقيقية هنا
        ));
      }

      return data;
    } else {
      print("❌ API Error: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("❌ Exception occurred: $e");
    return [];
  }
}
