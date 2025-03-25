import 'package:dio/dio.dart';
import 'package:weather_app/models/weather.dart';

class WeatherApiService {
  String apiKey = "eb385c1792a94adc8a6121459240304";
  String baseUrl = "https://api.weatherapi.com/v1/forecast.json?q=";

  final dio = Dio();

  Future<Weather> getWeather(String location) async {
    late Response<dynamic> response;
    late Weather weather;
    try {
      var url = "$baseUrl$location&days=5&aqi=no&alerts=no&key=$apiKey";
      response = await dio.get(url);
      Location loc =
          Location.fromJson(response.data["location"] as Map<String, dynamic>);
      Current current =
          Current.fromJson(response.data["current"] as Map<String, dynamic>);
      Forecast forecast =
          Forecast.fromJson(response.data["forecast"] as Map<String, dynamic>);
      weather = Weather(location: loc, forecast: forecast, current: current);
    } catch (e) {
      return Weather();
    }

    return weather;
  }
}
