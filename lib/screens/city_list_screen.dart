import 'package:flutter/material.dart';
import 'package:weather_app/services/city_service.dart';
import 'package:weather_app/screens/city_search_screen.dart';

class CityListScreen extends StatefulWidget {
  const CityListScreen({super.key});

  @override
  State<CityListScreen> createState() => _CityListScreenState();
}

class _CityListScreenState extends State<CityListScreen> {
  final CityService _cityService = CityService();
  List<String> _cities = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    List<String> cities = await _cityService.getCities();
    setState(() {
      _cities = cities;
      _isLoading = false;
    });
  }

  Future<void> _removeCity(String city) async {
    await _cityService.removeCity(city);
    _loadCities();
  }

  Future<void> _getCurrentLocation() async {
    // Return empty string to indicator "Use Current Location"
    Navigator.pop(context, "");
  }

  void _selectCity(String city) {
    Navigator.pop(context, city);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Şehirlerim",
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
        padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
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
        child: Column(
          children: [
            // Current Location Option
            GestureDetector(
              onTap: _getCurrentLocation,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.my_location,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(width: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mevcut Konum",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "GPS Kullan",
                          style: TextStyle(fontSize: 14, color: Colors.white70),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white.withOpacity(0.7),
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white24),
            const SizedBox(height: 10),
            _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Expanded(
                    child: _cities.isEmpty
                        ? Center(
                            child: Text(
                              "Henüz kayıtlı şehir yok.",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 16,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: _cities.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 15),
                            itemBuilder: (context, index) {
                              String city = _cities[index];
                              return Dismissible(
                                key: Key(city),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  _removeCity(city);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("$city silindi"),
                                      backgroundColor: Colors.red.withOpacity(
                                        0.8,
                                      ),
                                    ),
                                  );
                                },
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () => _selectCity(city),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.1),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.location_city,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 20),
                                        Text(
                                          city,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white.withOpacity(0.7),
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CitySearchScreen()),
          ).then((_) => _loadCities());
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.indigo),
      ),
    );
  }
}
