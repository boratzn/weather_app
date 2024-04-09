import 'package:dio/dio.dart';
import 'package:weather_app/models/weather.dart';

class WeatherApiService {
  String baseUrl =
      "https://api.weatherapi.com/v1/forecast.json?key=eb385c1792a94adc8a6121459240304&q=";

  final dio = Dio();

  Future<Weather> getWeather(String location) async {
    var response;
    try {
      var url = "$baseUrl$location&days=10&aqi=no&alerts=no";
      response = await dio.get(url);
    } catch (e) {}
    Location loc =
        Location.fromJson(response.data["location"] as Map<String, dynamic>);
    Current current =
        Current.fromJson(response.data["current"] as Map<String, dynamic>);
    Forecast forecast =
        Forecast.fromJson(response.data["forecast"] as Map<String, dynamic>);
    Weather weather =
        Weather(location: loc, forecast: forecast, current: current);
    return weather;
  }
}
