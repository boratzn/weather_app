import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_api.dart';
import 'package:weather_app/services/city_service.dart';

class CitySearchScreen extends StatefulWidget {
  const CitySearchScreen({super.key});

  @override
  State<CitySearchScreen> createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  final WeatherApiService _apiService = WeatherApiService();
  final CityService _cityService = CityService();

  List<dynamic> _searchResults = [];
  bool _isLoading = false;

  // Debounce could be added, but manual search button for simplicity
  final TextEditingController _controller = TextEditingController();

  Future<void> _search(String query) async {
    if (query.length < 3) return;

    setState(() {
      _isLoading = true;
    });

    final results = await _apiService.searchLocation(query);

    setState(() {
      _searchResults = results;
      _isLoading = false;
    });
  }

  Future<void> _addCity(String cityName) async {
    await _cityService.addCity(cityName);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$cityName favorilere eklendi"),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context); // Return to CityListScreen
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Şehir Ara",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade900,
              Colors.indigo.shade800,
              Colors.blue.shade900,
            ],
          ),
        ),
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              onSubmitted: _search,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Şehir adı girin (örn: Istanbul)",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () => _search(_controller.text),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Expanded(
                    child: ListView.separated(
                      itemCount: _searchResults.length,
                      separatorBuilder: (context, index) =>
                          const Divider(color: Colors.white24),
                      itemBuilder: (context, index) {
                        final item = _searchResults[index];
                        final name = item['name'];
                        final region = item['region'];
                        final country = item['country'];
                        //final fullText = "$name, $country";

                        return ListTile(
                          title: Text(
                            name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "$region, $country",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: Colors.white,
                            ),
                            onPressed: () => _addCity(name),
                          ),
                          onTap: () => _addCity(name),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
