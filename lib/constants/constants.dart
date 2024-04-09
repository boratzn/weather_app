import 'package:flutter/material.dart';
import 'package:weather_app/gen/assets.gen.dart';

class Constants {
  final Color primaryColor = const Color(0xFF90B2F9);
  final Color secondaryColor = const Color(0xFF90B2F8);

  setAnimation(String state) {
    switch (state) {
      case 'Clear':
      case 'Sunny':
        return Assets.animations.clear.path;
      case 'Cloudy':
        return Assets.animations.cloudy.path;
      case 'Light drizzle':
      case 'Patchy light drizzle':
        return Assets.animations.drizzle.path;
      case 'Freezing drizzle':
      case 'Heavy freezing drizzle':
        return '';
      case 'Light rain':
      case 'Light rain shower':
      case 'Moderate rain':
      case 'Patchy rain nearby':
      case 'Moderate rain at times':
      case 'Patchy light rain':
        return Assets.animations.rain.path;
      case 'Mist':
        return Assets.animations.mist.path;
      case 'Overcast':
        return Assets.animations.overcast.path;
      case 'Partly cloudy':
      case 'Partly Cloudy':
        return Assets.animations.partlyCloudyDay.path;
      case 'Heavy rain at times':
      case 'Heavy rain':
      case 'Moderate or heavy rain shower':
      case 'Torrential rain shower':
        return '';
      case 'Moderate or heavy freezing rain':
      case 'Light freezing rain':
        return '';
      case 'Light sleet':
      case 'Moderate or heavy sleet':
        return '';
      case 'Patchy light snow':
      case 'Light snow':
      case 'Patchy moderate snow':
      case 'Moderate snow':
      case 'Light sleet showers':
      case 'Light snow showers':
        return '';
      case 'Patchy heavy snow':
      case 'Heavy snow':
      case 'Ice pellets':
      case 'Moderate or heavy sleet showers':
      case 'Moderate or heavy snow showers':
      case 'Light showers of ice pellets':
      case 'Moderate or heavy showers of ice pellets':
      case 'Blizzard':
        return '';
    }
  }
}
