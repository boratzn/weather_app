import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/bloc/weather_bloc.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/screens/home_page.dart';
import 'package:weather_app/services/geolocator_service.dart';
import 'package:weather_app/services/weather_api.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Status bar'ı şeffaf yapar
  ));
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherBloc(WeatherApiService()),
        )
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(Assets.images.skyNight.path),
          )),
          child: const HomePage(
            location: "İstanbul",
          ),
        ),
      ),
    );
  }
}
