import 'package:flutter/material.dart';
import 'package:weather/ui/home_page.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeUI(),
      debugShowCheckedModeBanner: false,
    );
  }
}
