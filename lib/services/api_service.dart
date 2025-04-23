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

// دالة لحساب AQI باستخدام معادلة الاستيفاء الخطي (لـ PM2.5 فقط هنا)
double calculateAQIFromPM25(double pm25) {
  List<Map<String, dynamic>> breakpoints = [
    {"pmMin": 0.0, "pmMax": 12.0, "aqiMin": 0, "aqiMax": 50},
    {"pmMin": 12.1, "pmMax": 35.4, "aqiMin": 51, "aqiMax": 100},
    {"pmMin": 35.5, "pmMax": 55.4, "aqiMin": 101, "aqiMax": 150},
    {"pmMin": 55.5, "pmMax": 150.4, "aqiMin": 151, "aqiMax": 200},
    {"pmMin": 150.5, "pmMax": 250.4, "aqiMin": 201, "aqiMax": 300},
    {"pmMin": 250.5, "pmMax": 350.4, "aqiMin": 301, "aqiMax": 400},
    {"pmMin": 350.5, "pmMax": 500.4, "aqiMin": 401, "aqiMax": 500},
  ];

  for (var range in breakpoints) {
    if (pm25 >= range["pmMin"] && pm25 <= range["pmMax"]) {
      double aqi = ((range["aqiMax"] - range["aqiMin"]) /
                  (range["pmMax"] - range["pmMin"])) *
              (pm25 - range["pmMin"]) +
          range["aqiMin"];
      return aqi;
    }
  }

  return 500; // في حالة أعلى من الحد الأعلى
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

      final hourly = json['hourly'];
      if (hourly == null || hourly['time'] == null) {
        print("⚠️ No hourly data in the response!");
        return [];
      }

      final time = List<String>.from(hourly['time']);
      final pm10 = List<num?>.from(hourly['pm10'] ?? []);
      final pm25 = List<num?>.from(hourly['pm2_5'] ?? []);
      final co = List<num?>.from(hourly['carbon_monoxide'] ?? []);
      final no2 = List<num?>.from(hourly['nitrogen_dioxide'] ?? []);
      final so2 = List<num?>.from(hourly['sulphur_dioxide'] ?? []);
      final o3 = List<num?>.from(hourly['ozone'] ?? []);

      List<AirQualityData> data = [];

      for (int i = 0; i < time.length; i++) {
        if (pm10.length > i &&
            pm25.length > i &&
            co.length > i &&
            no2.length > i &&
            so2.length > i &&
            o3.length > i &&
            pm10[i] != null &&
            pm25[i] != null &&
            co[i] != null &&
            no2[i] != null &&
            so2[i] != null &&
            o3[i] != null) {
          final calculatedAQI = calculateAQIFromPM25(pm25[i]!.toDouble());
          data.add(AirQualityData(
            timestamp: time[i],
            pm10: pm10[i]!.toDouble(),
            pm25: pm25[i]!.toDouble(),
            co: co[i]!.toDouble(),
            no2: no2[i]!.toDouble(),
            so2: so2[i]!.toDouble(),
            o3: o3[i]!.toDouble(),
            aqi: calculatedAQI,
          ));
        }
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
