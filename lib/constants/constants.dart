import 'package:flutter/material.dart';
import 'package:weather_app/gen/assets.gen.dart';

class Constants {
  final Color primaryColor = const Color(0xFF90B2F9);
  final Color secondaryColor = const Color(0xFF90B2F8);

  String setAnimation(int code) {
    if (code == 1000) return Assets.animations.clear.path;
    if (code == 1003) return Assets.animations.partlyCloudyDay.path;
    if (code == 1006 || code == 1009) return Assets.animations.overcast.path;
    if ([1030, 1135, 1147].contains(code)) return Assets.animations.mist.path;

    // Rain
    if ([
      1063,
      1150,
      1153,
      1180,
      1183,
      1186,
      1189,
      1192,
      1195,
      1240,
      1243,
      1246,
    ].contains(code)) {
      return Assets.animations.rain.path;
    }

    // Thunder
    if ([1087, 1273, 1276, 1279, 1282].contains(code)) {
      return Assets.animations.thundery.path;
    }

    // Snow
    if ([
      1066,
      1114,
      1117,
      1210,
      1213,
      1216,
      1219,
      1222,
      1225,
      1255,
      1258,
    ].contains(code)) {
      return Assets.animations.snowy.path;
    }

    return Assets.animations.clear.path; // Default fallback
  }
}
