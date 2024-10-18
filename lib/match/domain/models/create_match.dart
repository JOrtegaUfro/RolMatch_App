import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rol_match/match/data/services/create_match_service.dart';
import 'package:rol_match/match/domain/dialogs/create_dialogs.dart';
import 'package:rol_match/match/domain/models/match.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

class CreateMatch {
  //Metodo con logica para crear partido
  void create() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    SecureStorage secureStorage = new SecureStorage();

    CreateMatchService matchService = new CreateMatchService();
    double latitud = prefs.getDouble("latitud") as double;
    double longitud = prefs.getDouble("longitud") as double;
    String date = prefs.getString("date") as String;
    String duration = prefs.getString("duration") as String;
    String hora = prefs.getString("hora") as String;
    String sport = prefs.getString("deporte") as String;
    int slots = prefs.getInt("totalSlots") as int;
    int players = prefs.getInt("totalPlayers") as int;
    String userName = await secureStorage.readSecureData('name');

    print("Guardando $date, $hora, $sport, $latitud, $longitud, $duration");

    Match match = Match(
        latitud: latitud,
        longitud: longitud,
        date: date,
        duration: duration,
        hora: hora,
        sport: sport,
        totalSlots: slots,
        totalPlayers: players,
        userName: userName);
    matchService.createMatch(match);
  }

  //build se encarga de activar la creacion de partido y mostrar un dialog para los casos extras
  void build(BuildContext context) async {
    CreateDialogs dialogs = new CreateDialogs();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int slots = prefs.getInt("totalSlots") as int;
    int players = prefs.getInt("totalPlayers") as int;
    create();

    if (slots < players) {
      Navigator.pushNamed(context, '/agendaPartido');
    } else {
      dialogs.showSlotsDialog(context);
    }
  }
}
