import 'dart:convert';
import 'package:ecosensetest/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  final String apiKey = '693932bfe2eb4469a12204744250303';
  final String baseUrl = 'http://api.weatherapi.com/v1';

  Future<http.Response> getWeatherData(
      String? city, String mydata, bool isforecast) async {
    try {
      final uri = Uri.parse(isforecast
          ? '$baseUrl/$mydata?key=$apiKey&q=$city&days=2'
          : '$baseUrl/$mydata?key=$apiKey&q=$city');
      print(uri);
      final response = await http.get(uri); //Properly assign the response

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(
            'Failed to load weather data. Please check your internet connection.');
      }
    } catch (e) {
      throw Exception('Error: Please check your internet connection.');
    }
  }

  Future<http.Response> getDetailedForecast(String city, String Data) async {
    try {
      final response = await http.get(Uri.parse(
              '$baseUrl/$Data?key=$apiKey&q=$city&days=3') // 使用forecast.json端点
          );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to load forecast data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<ApiResponse> getHourlyForecast(String city) async {
    try {
      final response = await http.get(Uri.parse(
              '$baseUrl/forecast.json?key=$apiKey&q=$city&days=1') // 使用forecast.json端点获取24小时预报
          );

      if (response.statusCode == 200) {
        return ApiResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load hourly forecast: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
