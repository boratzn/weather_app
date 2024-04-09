import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/bloc/weather_bloc.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/screens/home_page.dart';
import 'package:weather_app/services/geolocator_service.dart';
import 'package:weather_app/services/weather_api.dart';
import 'package:weather_app/utility/utility.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
          future: GeoLocatorService().getLocation(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // Konum alındıktan sonra hava durumu bilgisini al
              Size size = MediaQuery.of(context).size;
              return Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(Assets.images.skyNight.path),
                )),
                child: HomePage(
                  location: snapshot.data ?? "London",
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Utility.testAlert(context);
          },
          child: const Icon(
            Icons.search,
            size: 30,
          ),
        ),
      ),
    );
  }
}
