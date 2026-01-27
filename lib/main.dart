import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/bloc/weather_bloc.dart';
import 'package:weather_app/gen/assets.gen.dart';
import 'package:weather_app/screens/home_page.dart';
import 'package:weather_app/services/geolocator_service.dart';
import 'package:weather_app/services/weather_api.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Status bar'ı şeffaf yapar
    ),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WeatherBloc(WeatherApiService())),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LocationWrapper(),
    );
  }
}

class LocationWrapper extends StatefulWidget {
  const LocationWrapper({super.key});

  @override
  State<LocationWrapper> createState() => _LocationWrapperState();
}

class _LocationWrapperState extends State<LocationWrapper> {
  String? location;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    // Wait for the build to complete so context is valid for dialogs
    await Future.delayed(Duration.zero);
    if (!mounted) return;

    String loc = await GeoLocatorService().getLocationWithContext(context);

    if (mounted) {
      setState(() {
        location = loc;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.skyNight.path),
            fit: BoxFit.cover,
          ),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : HomePage(location: location ?? "Istanbul"),
      ),
    );
  }
}
