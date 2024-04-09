import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utility {
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
    var alert = const AlertDialog(
      title: Text("Test"),
      content: Text("Done..!"),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
