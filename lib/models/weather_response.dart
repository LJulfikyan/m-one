class WeatherResponse {
  final double latitude;
  final double longitude;
  final double generationtime_ms;
  final int utc_offset_seconds;
  final String timezone;
  final String timezone_abbreviation;
  final double elevation;
  final Map<String, dynamic> current_weather;

  WeatherResponse(
      {required this.latitude,
      required this.longitude,
      required this.generationtime_ms,
      required this.utc_offset_seconds,
      required this.timezone,
      required this.timezone_abbreviation,
      required this.elevation,
      required this.current_weather});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      latitude: json['latitude'],
      longitude: json['latitude'],
      generationtime_ms: json['generationtime_ms'],
      utc_offset_seconds: json['utc_offset_seconds'],
      timezone: json['timezone'],
      timezone_abbreviation: json['timezone_abbreviation'],
      elevation: json['elevation'],
      current_weather: json['current_weather'],
    );
  }
}
