import 'package:flutter/material.dart';

//Es un gestionador del formato hora
class TimeFormat {
  //formato de hora, de tal manera que se vea por ejemplo como 12:04 o 17:59
  String formatTimeOfDay(TimeOfDay time) {
    final int hour = time.hour;
    final int minute = time.minute;
    String minuteStr;

    if (minute < 10) {
      minuteStr = '0$minute';
    } else {
      minuteStr = '$minute';
    }

    return '$hour:$minuteStr';
  }
}
