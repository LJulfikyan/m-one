import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:weather/models/weather_response.dart';
import 'package:weather/ui/colors.dart';
import 'dart:math';
import 'package:http/http.dart' as http;

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  State<HomeUI> createState() => _HomeUIState();
}

bool isNight = true;

ScrollController scrollController = ScrollController();
String locationName = 'Armenia, Yerevan';
List<String> iconList = [
  'windy.png',
  'stormy.png',
  'rainy.png',
  'moon.png',
  'cloudy.png',
];
final _random = Random();
String icon() => iconList[_random.nextInt(iconList.length)];

int degree() => 30 + _random.nextInt(39 - 30);
List<Map<String, dynamic>> sevenDayForecast = [
  {
    'date': DateTime.now(),
    'weather': icon(),
    'degree': degree(),
  },
  {
    'date': DateTime.now().add(const Duration(days: 1)),
    'weather': icon(),
    'degree': degree(),
  },
  {
    'date': DateTime.now().add(const Duration(days: 2)),
    'weather': icon(),
    'degree': degree(),
  },
  {
    'date': DateTime.now().add(const Duration(days: 3)),
    'weather': icon(),
    'degree': degree(),
  },
  {
    'date': DateTime.now().add(const Duration(days: 4)),
    'weather': icon(),
    'degree': degree(),
  },
  {
    'date': DateTime.now().add(const Duration(days: 5)),
    'weather': icon(),
    'degree': degree(),
  },
  {
    'date': DateTime.now().add(const Duration(days: 6)),
    'weather': icon(),
    'degree': degree(),
  }
];

class _HomeUIState extends State<HomeUI> {
  late Future<WeatherResponse> futureWeather;
  Future<WeatherResponse> fetchWeather() async {
    final response = await http.get(Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=40.18&longitude=44.51&current_weather=true&timezone=auto'));
    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DateTime now = DateTime.now();
    String formattedDay = DateFormat('EEEE').format(now);
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    return Scaffold(
      backgroundColor: isNight ? const Color(0xFFE5E7F7) : Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: clear,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60))),
            height: height * 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.05),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 60),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/location.png'),
                            const SizedBox(
                              width: 6,
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 1000),
                              child: Stack(
                                children: [
                                  Visibility(
                                      child: Text(
                                    locationName,
                                    style: TextStyle(
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 22,
                                      color: textColor,
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            Image.asset(
                              "assets/images/arrow.png",
                              scale: 1.3,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Icon(
                                Icons.more_vert,
                                size: 20,
                                color: textColor,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.3,
                      child: Column(
                        children: [
                          FutureBuilder<WeatherResponse>(
                            future: futureWeather,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return GradientText(
                                  "${snapshot.data!.current_weather['temperature']}°C",
                                  colors: const [
                                    Color(0x4DE8FCFF),
                                    Color(0xFFE8FCFF)
                                  ],
                                  style: const TextStyle(
                                      fontFamily: "Rubik",
                                      fontSize: 80,
                                      height: 1.5,
                                      fontWeight: FontWeight.w500),
                                  gradientType: GradientType.linear,
                                  gradientDirection: GradientDirection.btt,
                                );
                              } else {
                                return const Text('An error occurred');
                              }
                            },
                          ),
                          Image.asset(
                            'assets/images/moon.png',
                            scale: 1.4,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Text(
                              'Clear',
                              style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  letterSpacing: 4),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.06,
                      child: Column(
                        children: [
                          Text(
                            formattedDay,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 30),
            child: SizedBox(
              width: width - 45,
              child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "7 Days",
                      style: TextStyle(
                        color: Color(0xCC6D7AAA),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: Color(0xCC6D7AAA),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
              height: 140,
              child: Scrollbar(
                controller: scrollController,
                thumbVisibility: true,
                child: ListView.builder(
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: sevenDayForecast.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(12, 10, 0, 50),
                        child: Container(
                          height: 90,
                          width: width / 7,
                          decoration: BoxDecoration(
                              color: clear,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(sevenDayForecast[index]['date']),
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                    color: textColor),
                              ),
                              SizedBox(
                                height: 20,
                                child: Image.asset(
                                  "assets/images/${sevenDayForecast[index]['weather']}",
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ))
        ],
      ),
    );
  }
}
