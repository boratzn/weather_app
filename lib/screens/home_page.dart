import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/blocs/bloc/weather_bloc.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/screens/weather_detail_page.dart';
import 'package:weather_app/utility/utility.dart';
import 'package:weather_app/widgets/appbar.dart';
import 'package:weather_app/screens/city_list_screen.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.location});

  final String location;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _refreshWeather() async {
    context.read<WeatherBloc>().add(GetWeather(location: widget.location));
  }

  @override
  Widget build(BuildContext context) {
    var constants = Constants();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade900,
              Colors.indigo.shade800,
              Colors.blue.shade900,
            ],
          ),
        ),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoading) {
              context.read<WeatherBloc>().add(
                GetWeather(location: widget.location),
              );
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            if (state is WeatherLoaded) {
              Weather weather = state.weather;

              // Null check: If API returns success but data is somehow incomplete
              if (weather.current == null || weather.forecast == null) {
                return RefreshIndicator(
                  onRefresh: _refreshWeather,
                  color: Colors.white,
                  backgroundColor: Colors.indigo.shade800,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: MyAppBar(
                                  location:
                                      (weather.location?.name ?? 'Unknown'),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final selectedCity = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CityListScreen(),
                                    ),
                                  );

                                  if (selectedCity != null) {
                                    if (selectedCity == "") {
                                      context.read<WeatherBloc>().add(
                                        GetWeather(location: ""),
                                      );
                                    } else {
                                      context.read<WeatherBloc>().add(
                                        GetWeather(location: selectedCity),
                                      );
                                    }
                                  }
                                },
                                icon: const Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 100),
                          const Center(
                            child: Text(
                              "Veri alınamadı. Lütfen tekrar deneyin.",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              var current = weather.current!;
              var todayForecast = weather.forecast!.forecastday![0];

              // Calculate min/max for chart axis dynamic scaling
              var temps = todayForecast.hour!.map((h) => h.tempC!).toList();
              double minTemp = temps.reduce((a, b) => a < b ? a : b);
              double maxTemp = temps.reduce((a, b) => a > b ? a : b);
              double axisMin = minTemp - 3;
              double axisMax = maxTemp + 3;
              // Ensure at least 10 degrees range to prevent zooming in too much
              if (axisMax - axisMin < 10) {
                double diff = 10 - (axisMax - axisMin);
                axisMax += diff / 2;
                axisMin -= diff / 2;
              }

              return RefreshIndicator(
                onRefresh: _refreshWeather,
                color: Colors.white,
                backgroundColor: Colors.indigo.shade800,
                child: SafeArea(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: MyAppBar(
                                location: (weather.location?.name ?? 'Unknown'),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                final selectedCity = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CityListScreen(),
                                  ),
                                );

                                if (selectedCity != null) {
                                  if (selectedCity == "") {
                                    // Empty string means use GPS
                                    // You might need to refactor GetWeather event to handle this explicitly
                                    // or just pass "London" as fallback if logic resides in BLoC
                                    // Ideally, pass a flag or handle in BLoC.
                                    // For now, let's assume valid CityName or re-trigger location check
                                    // A simple way is to pass "GPS" or handle empty string in BLoC as 'use location'
                                    context.read<WeatherBloc>().add(
                                      GetWeather(location: ""),
                                    );
                                  } else {
                                    context.read<WeatherBloc>().add(
                                      GetWeather(location: selectedCity),
                                    );
                                  }
                                }
                              },
                              icon: const Icon(Icons.menu, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Column(
                            children: [
                              Lottie.asset(
                                constants.setAnimation(
                                  current.condition!.code!,
                                ),
                                height: 200,
                              ),
                              Text(
                                "${current.tempC!.round()}°",
                                style: const TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  height: 1,
                                ),
                              ),
                              Text(
                                current.condition!.text!,
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "H: ${todayForecast.day!.maxtempC!.round()}°  L: ${todayForecast.day!.mintempC!.round()}°",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Saatlik Tahmin",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Hourly Forecast Section
                        Container(
                          height: 180,
                          padding: const EdgeInsets.all(10), // Add padding
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            primaryXAxis: CategoryAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                              axisLine: const AxisLine(width: 0),
                              labelStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              majorTickLines: const MajorTickLines(size: 0),
                              interval: 3,
                            ),
                            primaryYAxis: NumericAxis(
                              isVisible: false,
                              minimum: axisMin,
                              maximum: axisMax,
                            ),
                            tooltipBehavior: TooltipBehavior(
                              enable: true,
                              header: '',
                              canShowMarker: false,
                              format: 'point.x : point.y°',
                            ),
                            series: <CartesianSeries>[
                              SplineAreaSeries<Hour, String>(
                                dataSource: todayForecast.hour!,
                                xValueMapper: (Hour data, _) =>
                                    DateFormat('HH:mm').format(
                                      DateFormat(
                                        'yyyy-MM-dd HH:mm',
                                      ).parse(data.time!),
                                    ),
                                yValueMapper: (Hour data, _) =>
                                    data.tempC!.round(),
                                dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  labelAlignment: ChartDataLabelAlignment.top,
                                ),
                                borderColor: Colors.amber,
                                borderWidth: 4,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.amber.withOpacity(0.35),
                                    Colors.amber.withOpacity(0.0),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                markerSettings: const MarkerSettings(
                                  isVisible: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Gelecek Tahminler",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        WeatherDetailPage(weather: weather),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Detaylar",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white.withOpacity(0.7),
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        // Daily Forecast List
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: weather.forecast!.forecastday!.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            var day = weather.forecast!.forecastday![index];
                            return Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      Utility.dateToDay(day.date!),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.network(
                                          'https:${day.day!.condition!.icon!}',
                                          width: 30,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            day.day!.condition!.text ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(
                                                0.7,
                                              ),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${day.day!.maxtempC!.round()}°",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          " / ${day.day!.mintempC!.round()}°",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.white.withOpacity(
                                              0.7,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return const Center(
              child: Text(
                "Hava Durumu Yüklenirken Hata Oluştu!!",
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Utility.testAlert(context);
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.2),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(Icons.search, size: 28, color: Colors.white),
        ),
      ),
    );
  }
}
