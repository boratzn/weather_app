import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/blocs/bloc/weather_bloc.dart';

class Utility {
  static TextEditingController controller = TextEditingController();

  static String dateToDay(DateTime date) {
    String day = DateFormat('EEE').format(date);
    switch (day) {
      case 'Mon':
        return 'Pzt';
      case 'Tue':
        return 'Sal';
      case 'Wed':
        return 'Çar';
      case 'Thu':
        return 'Per';
      case 'Fri':
        return 'Cum';
      case 'Sat':
        return 'Cmt';
      case 'Sun':
        return 'Paz';
    }
    return 'Pzt';
  }

  static String dateToDayandMonth(DateTime date) {
    return DateFormat('d/M').format(date);
  }

  static String convetTo24Hours(String hour) {
    var arr = hour.split(' ');
    var currHour = arr[0].split(':');
    if (arr[1] == 'PM') {
      var temp = int.parse(currHour[0]);
      currHour[0] = (temp + 12).toString();
    } else {
      return arr[0];
    }
    return '${currHour[0]}:${currHour[1]}';
  }

  static void testAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        bool isLoading = false;
        String? errorMessage;

        return StatefulBuilder(
          builder: (context, setState) {
            return BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ), // Blur background
              child: Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15), // Glassy background
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Şehir Ara",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 25),
                      TextField(
                        controller: controller,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: "Şehir İsmi Girin...",
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      if (errorMessage != null) ...[
                        const SizedBox(height: 10),
                        Text(
                          errorMessage!,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  if (controller.text.trim().isEmpty) return;

                                  setState(() {
                                    isLoading = true;
                                    errorMessage = null;
                                  });

                                  try {
                                    var results = await context
                                        .read<WeatherBloc>()
                                        .weatherApiService
                                        .searchLocation(controller.text.trim());

                                    if (results.isEmpty) {
                                      setState(() {
                                        isLoading = false;
                                        errorMessage =
                                            "Şehir bulunamadı. Lütfen geçerli bir isim girin.";
                                      });
                                    } else {
                                      if (context.mounted) {
                                        context.read<WeatherBloc>().add(
                                          GetWeather(
                                            location: controller.text.trim(),
                                          ),
                                        );
                                        Navigator.pop(context);
                                        controller.text = "";
                                      }
                                    }
                                  } catch (e) {
                                    setState(() {
                                      isLoading = false;
                                      errorMessage = "Bir hata oluştu.";
                                    });
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "ARA",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Future<bool> showLocationPermissionDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (context) => BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 50,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Konum İzni",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Uygulamanın düzgün çalışabilmesi ve size en yakın hava durumunu gösterebilmesi için konum erişimine ihtiyacı var. Lütfen devam ederek izin verin.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.2),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                        ),
                        child: const Text(
                          "İZİN VER",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text(
                        "VAZGEÇ",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ) ??
        false;
  }
}
