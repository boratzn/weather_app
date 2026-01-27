import 'package:shared_preferences/shared_preferences.dart';

class CityService {
  static const String _keyCities = 'saved_cities';

  Future<List<String>> getCities() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyCities) ?? [];
  }

  Future<void> addCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cities = prefs.getStringList(_keyCities) ?? [];

    // Avoid duplicates (case insensitive check could be added, keeping simple for now)
    if (!cities.contains(cityName)) {
      cities.add(cityName);
      await prefs.setStringList(_keyCities, cities);
    }
  }

  Future<void> removeCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cities = prefs.getStringList(_keyCities) ?? [];

    cities.remove(cityName);
    await prefs.setStringList(_keyCities, cities);
  }
}
