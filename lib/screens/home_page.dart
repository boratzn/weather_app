import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/blocs/bloc/weather_bloc.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/screens/weather_detail_page.dart';
import 'package:weather_app/utility/utility.dart';
import 'package:weather_app/widgets/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.location});

  final String location;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var constants = Constants();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(Assets.images.skyNight.path),
          ),
        ),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              context
                  .read<WeatherBloc>()
                  .add(GetWeather(location: widget.location));
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WeatherLoaded) {
              Weather weather = state.weather;

              return Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: MyAppBar(
                          location: weather.location!.name!,
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: ListView(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Lottie.asset(
                                      constants.setAnimation(
                                          weather.current!.condition!.text!),
                                      width: 250),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${weather.current!.tempC!.round()}°",
                                      style: const TextStyle(
                                          fontSize: 70,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          "Son Güncelleme",
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          weather.current!.lastUpdated!
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.white),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.1),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                      height: 20,
                                    ),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        weather.forecast!.forecastday!.length,
                                    itemBuilder: (context, index) {
                                      var day =
                                          weather.forecast!.forecastday![index];
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            Utility.dateToDayandMonth(
                                                day.date!),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            Utility.dateToDay(day.date!),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          Image.network(
                                            'https:${weather.forecast!.forecastday![index].day!.condition!.icon!}',
                                            width: 40,
                                          ),
                                          Text(
                                            '${day.day!.mintempC!.round()}°/${day.day!.maxtempC!.round()}°',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WeatherDetailPage(
                                          weather: weather,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Detaylı Bilgi İçin Dokunun",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Center(
              child: Text("Hava Durumu Yüklenirken Hata Oluştu!!"),
            );
          },
        ),
      ),
    );
  }
}
