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
    var alert = AlertDialog(
      backgroundColor: Colors.indigo,
      title: const Text("Şehir İsmi Girin"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: () {
                context
                    .read<WeatherBloc>()
                    .add(GetWeather(location: controller.text));
                Navigator.pop(context);
                controller.text = "";
              },
              child: const Text("Ara"))
        ],
      ),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
