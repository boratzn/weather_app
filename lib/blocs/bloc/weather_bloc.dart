import 'package:bloc/bloc.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/services/weather_api.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherApiService weatherApiService;
  WeatherBloc(this.weatherApiService) : super(WeatherLoading()) {
    on<GetWeather>((event, emit) async {
      try {
        var weather = await weatherApiService.getWeather(event.location);
        emit(WeatherLoaded(weather: weather));
      } catch (e) {
        emit(WeatherError());
      }
    });
  }
}
