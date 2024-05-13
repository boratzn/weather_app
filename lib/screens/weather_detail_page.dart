import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/utility/utility.dart';
import 'package:weather_app/widgets/animated_list_item.dart';

class WeatherDetailPage extends StatefulWidget {
  const WeatherDetailPage({super.key, required this.weather});

  final Weather weather;

  @override
  State<WeatherDetailPage> createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {
  int selectedIdx = 0;
  Constants constants = Constants();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var selectedDay = widget.weather.forecast!.forecastday![selectedIdx];
    TextStyle style = const TextStyle(fontSize: 20, color: Colors.white);
    TextStyle subStyle =
        TextStyle(fontSize: 12, color: Colors.white.withOpacity(.5));

    return Scaffold(
      backgroundColor: constants.primaryColor,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(Assets.images.night.path),
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
          child: Stack(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10,
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.weather.forecast!.forecastday!.length,
                      itemBuilder: (context, index) {
                        var day = widget.weather.forecast!.forecastday![index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 38),
                          child: InkWell(
                            radius: 15,
                            onTap: () {
                              setState(() {
                                selectedIdx = index;
                              });
                            },
                            child: AnimatedListItem(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(color: Colors.white),
                                  color: selectedIdx == index
                                      ? Colors.white.withOpacity(.3)
                                      : null,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${day.day!.maxtempC!.round()}°',
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      Image.network(
                                        'https:${widget.weather.forecast!.forecastday![index].day!.condition!.icon!}',
                                        width: 40,
                                      ),
                                      Text(
                                        Utility.dateToDayandMonth(day.date!),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      Text(
                                        Utility.dateToDay(day.date!),
                                        style: const TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 12,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: size.width / 2 - 30,
                              height: size.height * 0.13,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: ListTile(
                                  leading: Image.asset(
                                    Assets.images.rainy.path,
                                    width: 25,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    '%${selectedDay.day!.dailyChanceOfRain!}',
                                    style: style,
                                  ),
                                  subtitle: Text(
                                    'Yağmur Oranı',
                                    style: subStyle,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width / 2 - 30,
                              height: size.height * 0.13,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: ListTile(
                                  leading: Image.asset(
                                    Assets.images.humidity.path,
                                    width: 25,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    '%${selectedDay.day!.avghumidity!}',
                                    style: style,
                                  ),
                                  subtitle: Text(
                                    'Nem Oranı',
                                    style: subStyle,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: size.width / 2 - 30,
                              height: size.height * 0.13,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: ListTile(
                                  leading: Image.asset(
                                    Assets.images.thermometer.path,
                                    width: 25,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    '${selectedDay.day!.avgtempC!}',
                                    style: style,
                                  ),
                                  subtitle: Text(
                                    'Hissedilen',
                                    style: subStyle,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width / 2 - 30,
                              height: size.height * 0.13,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: ListTile(
                                  leading: Image.asset(
                                    Assets.images.whirlwind.path,
                                    width: 25,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    '${selectedDay.day!.maxwindKph!} km',
                                    style: style,
                                  ),
                                  subtitle: Text(
                                    'Rüzgar Hızı',
                                    style: subStyle,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: size.width / 2 - 30,
                              height: size.height * 0.13,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: ListTile(
                                  leading: Image.asset(
                                    Assets.images.sun.path,
                                    width: 25,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    '%${selectedDay.day!.uv!}',
                                    style: style,
                                  ),
                                  subtitle: Text(
                                    'UV',
                                    style: subStyle,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width / 2 - 30,
                              height: size.height * 0.13,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: ListTile(
                                  leading: Image.asset(
                                    Assets.images.cloud.path,
                                    width: 25,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    '%${selectedDay.hour![0].cloud}',
                                    style: style,
                                  ),
                                  subtitle: Text(
                                    'Bulut',
                                    style: subStyle,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: size.width / 2 - 30,
                              height: size.height * 0.13,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: ListTile(
                                  leading: Image.asset(
                                    Assets.images.sunrise.path,
                                    width: 25,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    Utility.convetTo24Hours(
                                        selectedDay.astro!.sunrise!),
                                    style: style,
                                  ),
                                  subtitle: Text(
                                    'Gün Doğumu',
                                    style: subStyle,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width / 2 - 30,
                              height: size.height * 0.13,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: ListTile(
                                  leading: Image.asset(
                                    Assets.images.sunset.path,
                                    width: 25,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    Utility.convetTo24Hours(
                                        selectedDay.astro!.sunset!),
                                    style: style,
                                  ),
                                  subtitle: Text(
                                    'Gün Batımı',
                                    style: subStyle,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
