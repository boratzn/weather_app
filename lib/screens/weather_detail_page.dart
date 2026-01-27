import 'package:flutter/material.dart';
import 'package:weather_app/constants/constants.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/utility/utility.dart';

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

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Hava Durumu Detayı",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
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
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Top Horizontal List
              SizedBox(
                height: 150,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 15),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.weather.forecast!.forecastday!.length,
                  itemBuilder: (context, index) {
                    var day = widget.weather.forecast!.forecastday![index];
                    bool isSelected = selectedIdx == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIdx = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 90,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white.withOpacity(0.3)
                              : Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withOpacity(0.2),
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.1),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ]
                              : [],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${day.day!.maxtempC!.round()}°',
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Image.network(
                              'https:${day.day!.condition!.icon!}',
                              width: 40,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              Utility.dateToDayandMonth(day.date!),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              Utility.dateToDay(day.date!),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
              // Grid View Details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.4,
                    padding: const EdgeInsets.only(bottom: 20),
                    children: [
                      // Air Quality Card (Only if available)
                      if (widget.weather.current?.airQuality?.usEpaIndex !=
                          null)
                        _buildDetailCard(
                          icon: Assets.images.cloud.path,
                          value: _getAqiStatus(
                            widget.weather.current!.airQuality!.usEpaIndex!,
                          ),
                          title: 'Hava Kalitesi (EPA)',
                        ),
                      _buildDetailCard(
                        icon: Assets.images.rainy.path,
                        value: '%${selectedDay.day!.dailyChanceOfRain!}',
                        title: 'Yağmur Oranı',
                      ),
                      _buildDetailCard(
                        icon: Assets.images.humidity.path,
                        value: '%${selectedDay.day!.avghumidity!}',
                        title: 'Nem Oranı',
                      ),
                      _buildDetailCard(
                        icon: Assets.images.thermometer.path,
                        value: '${selectedDay.day!.avgtempC!}°',
                        title: 'Hissedilen',
                      ),
                      _buildDetailCard(
                        icon: Assets.images.whirlwind.path,
                        value: '${selectedDay.day!.maxwindKph!} km',
                        title: 'Rüzgar Hızı',
                      ),
                      _buildDetailCard(
                        icon: Assets.images.sun.path,
                        value: '${selectedDay.day!.uv!}',
                        title: 'UV İndeksi',
                      ),
                      _buildDetailCard(
                        icon: Assets.images.cloud.path,
                        value: '%${selectedDay.hour![0].cloud}',
                        title: 'Bulut Oranı',
                      ),
                      _buildDetailCard(
                        icon: Assets.images.sunrise.path,
                        value: Utility.convetTo24Hours(
                          selectedDay.astro!.sunrise!,
                        ),
                        title: 'Gün Doğumu',
                      ),
                      _buildDetailCard(
                        icon: Assets.images.sunset.path,
                        value: Utility.convetTo24Hours(
                          selectedDay.astro!.sunset!,
                        ),
                        title: 'Gün Batımı',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getAqiStatus(double index) {
    int idx = index.toInt();
    switch (idx) {
      case 1:
        return "İyi";
      case 2:
        return "Orta";
      case 3:
        return "Hassas";
      case 4:
        return "Sağlıksız";
      case 5:
        return "Çok Kötü";
      case 6:
        return "Tehlikeli";
      default:
        return "Bilinmiyor";
    }
  }

  Widget _buildDetailCard({
    required String icon,
    required String value,
    required String title,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, width: 35, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
