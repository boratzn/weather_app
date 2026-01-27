import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/utility/utility.dart';

class GeoLocatorService {
  Future<String> getLocation() async {
    // Konum iznini kontrol et
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Konum izni yoksa, izin iste
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return "Istanbul";
      }
    }

    // Mevcut konumu al
    try {
      // Check if location services are enabled first
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return "Istanbul";
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // Return coordinates directly for better API accuracy
      return "${position.latitude},${position.longitude}";
    } catch (e) {
      return "Istanbul";
    }
  }

  Future<String> getLocationWithContext(BuildContext context) async {
    // Konum iznini kontrol et
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Show rationale dialog before requesting permission
      bool accepted = await Utility.showLocationPermissionDialog(context);

      if (!accepted) {
        return "Istanbul";
      }

      // Now request permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return "Istanbul";
      }
    }

    // Mevcut konumu al
    try {
      // Check if location services are enabled first
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Optionally show dialog here too if user meant "Location Service"
        return "Istanbul";
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      return "${position.latitude},${position.longitude}";
    } catch (e) {
      return "Istanbul";
    }
  }
}
