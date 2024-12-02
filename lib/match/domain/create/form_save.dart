import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:rol_match/match/domain/util/time_format.dart';

//Esta clase se encarga de la logica de guardado de el formulario
class FormSave {
  final SharedPreferences? sharedPreferences;
  FormSave({
    this.sharedPreferences,
  });
  //Sel almacena el deporte (para el fomulario)
  void saveGame(String game) async {
    final prefs = sharedPreferences ?? await SharedPreferences.getInstance();

    prefs.setString("game", game);
  }

//Se almacena la duracion del partido(del formulario de creación)
  void saveDuration(int duration) async {
    final prefs = sharedPreferences ?? await SharedPreferences.getInstance();

    prefs.setString("duration", "$duration minutos");
  }

//Se almacena la hora del partido (del formualrio)
  void saveHour(TimeOfDay hour) async {
    final prefs = sharedPreferences ?? await SharedPreferences.getInstance();
    TimeFormat timeFormat = new TimeFormat();
    String savedHour = timeFormat.formatTimeOfDay(hour);
    prefs.setString("hora", savedHour);
  }

  //Se almacena la fecha del partido (del formulario)
  void saveDate(DateTime date) async {
    final prefs = sharedPreferences ?? await SharedPreferences.getInstance();

    String savedDate = "${date.toLocal().day}- ${date.toLocal().month}";

    prefs.setString("date", savedDate);
  }
}
