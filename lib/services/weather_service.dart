import 'package:dio/dio.dart';

class WeatherService {
  final Dio _dio = Dio();
  final String apiUrl = "https://www.weatherapi.com/my/";

  Future<Map<String, dynamic>> fetchWeather({required double lat, required double lon}) async {
    try {
      Response response = await _dio.get(apiUrl, queryParameters: {
        "latitude": lat,
        "longitude": lon,
        "current_weather": true
      });

      return response.data;
    } catch (e) {
      throw Exception("Failed to load weather data: $e");
    }
  }
}
