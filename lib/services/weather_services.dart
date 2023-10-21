import 'dart:convert';
// import 'dart:html';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:rvp/model/weather_model.dart';

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final url = '$BASE_URL?q=$cityName&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error fetching weather data');
    }
  }

  Future<String> getCurrentCity() async {
    //gettin permission from User
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // throw Exception('Location permission denied');
    }

    //gettin current location

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    //convert to placemark objects
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    //get city name from placemark

    String? city = placemarks[0].locality;

    return city ?? '';

    // final url = '$BASE_URL?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric';
    // final response = await http.get(Uri.parse(url));
    // if (response.statusCode == 200) {
    //   return jsonDecode(response.body)['name'];
    // } else {
    //   throw Exception('Error fetching current location');
    // }
  }
}
