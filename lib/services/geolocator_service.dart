import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

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
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
    String area = await getLocationInfo(position);
    return area;
  }

  Future<String> getLocationInfo(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isEmpty) return "Istanbul";
    Placemark place = placemarks[0];
    return place.subAdministrativeArea ?? "Istanbul";
  }
}
