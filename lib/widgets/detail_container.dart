import 'package:flutter/material.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/models/weather.dart';

class DetailContainer extends StatelessWidget {
  const DetailContainer({
    super.key,
    required this.size,
    required this.selectedDay,
    required this.style,
    required this.subStyle,
  });

  final Size size;
  final Forecastday selectedDay;
  final TextStyle style;
  final TextStyle subStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 2 - 30,
      height: size.height * 0.13,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha:.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            Assets.images.rainy.path,
            width: 30,
            color: Colors.white,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '%${selectedDay.day!.dailyChanceOfRain!}',
                style: style,
              ),
              Text(
                'Yağmur Oranı',
                style: subStyle,
              )
            ],
          )
        ],
      ),
    );
  }
}
