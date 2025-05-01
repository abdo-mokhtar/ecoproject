import 'dart:convert';
import 'package:ecosensetest/models/weather_model.dart';
import 'package:ecosensetest/screens/weather_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WeatherProvider with ChangeNotifier {
  ApiResponse? _weatherData;
  bool _isLoading = false;
  Location _selectedLocation = Location(
    name: 'Cairo',
    region: 'Al Qahirah',
    country: 'Egypt',
    lat: 30.05,
    lon: 31.25,
    tzId: "Africa/Cairo",
    localtimeEpoch: 1741458073,
    localtime: "2025-03-08 20:21",
  );

  ApiResponse? get weatherData => _weatherData;
  bool get isLoading => _isLoading;
  Location get selectedLocation => _selectedLocation;

  final WeatherApi _weatherApi = WeatherApi();

  WeatherProvider() {
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    try {
      _isLoading = true;
      notifyListeners();

      final currentResponse = await _weatherApi.getWeatherData(
          _selectedLocation.name, "current.json", false);
      final forecastResponse = await _weatherApi.getWeatherData(
          _selectedLocation.name, "forecast.json", true);

      final weatherData = ApiResponse(
        location: _selectedLocation,
        current: Current.fromJson(jsonDecode(currentResponse.body)['current']),
        forecast:
            Forecast.fromJson(jsonDecode(forecastResponse.body)["forecast"]),
      );

      _weatherData = weatherData;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      if (kDebugMode) {
        print('Error fetching weather data: $e');
      }
      throw Exception('Error: $e');
    }
  }

  void updateCity(String newCity) {
    _selectedLocation = Location(
      name: newCity,
      region: _selectedLocation.region,
      country: _selectedLocation.country,
      lat: _selectedLocation.lat,
      lon: _selectedLocation.lon,
      tzId: _selectedLocation.tzId,
      localtimeEpoch: _selectedLocation.localtimeEpoch,
      localtime: _selectedLocation.localtime,
    );
    notifyListeners();
    fetchWeatherData();
  }
}
