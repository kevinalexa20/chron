class Weather {
  // final String name;
  final String cityName;
  final String mainCondition;
  final double temperature;

  Weather({
    // this.name = '',
    required this.cityName,
    required this.mainCondition,
    required this.temperature,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? '',
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }
}
