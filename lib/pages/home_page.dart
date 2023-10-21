import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rvp/model/weather_model.dart';
import 'package:rvp/services/weather_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //apiKey
  final _weatherService = WeatherService('30084953c6063cfa3728e43a5c7a9b3e');
  Weather? _weather;

  //fetch Weather
  _fetchWeather() async {
    // get current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() => _weather = weather);
    } catch (e) {
      print(e);
    }
  }

  //get weather lat lon
  

  //weather animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json'; //default

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  //initState
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  //animation using lottie

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'CHRON',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple.shade400,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //city name
              Text(
                _weather?.cityName ?? 'Loading...',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),

              //animation
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

              //temperature
              Text(
                '${_weather?.temperature.round()}°C',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                ),
              ),

              //condition
              Text(
                _weather?.mainCondition ?? 'Loading...',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ));
  }
}
