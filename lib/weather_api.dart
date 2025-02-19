import 'dart:convert';
import 'package:ecosensetest/constants.dart';
import 'package:ecosensetest/weathermodel.dart';
import 'package:http/http.dart' as http;


class WeatherApi{
  final String baseUrl="http://api.weatherapi.com/v1/current.json";


  Future<ApiResponse> getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$weatherApiKey&q=$location";
    try{
      final response = await http.get(Uri.parse(apiUrl));
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if(response.statusCode==200){
        return ApiResponse.fromJson(jsonDecode(response.body));
      }else{
        throw Exception("Failed to load weather: ${response.body}");
      }
    }catch(e){
        throw Exception("Error: $e");
    }
  }
}