import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rol_match/match/data/services/create_match_service.dart';
import 'package:rol_match/match/domain/dialogs/create_dialogs.dart';
import 'package:rol_match/match/domain/models/match.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

class CreateMatch {
  @visibleForTesting
  void testCreate(
          SharedPreferences sharedPreference,
          SecureStorage mockSecureStorage,
          CreateMatchService mockCreateMatchService,
          Match testMatch) =>
      _create(
          sharedPreference: sharedPreference,
          mockSecureStorage: mockSecureStorage,
          mockCreateMatchService: mockCreateMatchService,
          testmatch: testMatch);

  //Metodo con logica para crear partido
  void _create(
      {SharedPreferences? sharedPreference,
      SecureStorage? mockSecureStorage,
      CreateMatchService? mockCreateMatchService,
      Match? testmatch}) async {
    final prefs = sharedPreference ?? await SharedPreferences.getInstance();
    final secureStorage = mockSecureStorage ?? new SecureStorage();

    final matchService = mockCreateMatchService ?? new CreateMatchService();
    double latitud = prefs.getDouble("latitud") as double;
    double longitud = prefs.getDouble("longitud") as double;
    String date = prefs.getString("date") as String;
    String duration = prefs.getString("duration") as String;
    String hora = prefs.getString("hora") as String;
    String type = prefs.getString("type") as String;
    int slots = prefs.getInt("totalSlots") as int;
    int players = prefs.getInt("totalPlayers") as int;
    String userName = await secureStorage.readSecureData('name');

    print("Guardando $date, $hora, $type, $latitud, $longitud, $duration");

    Match match = testmatch ??
        Match(
            latitud: latitud,
            longitud: longitud,
            date: date,
            duration: duration,
            hora: hora,
            type: type,
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
    _create();

    if (slots < players) {
      Navigator.pushNamed(context, '/agendaPartido');
    } else {
      dialogs.showSlotsDialog(context);
    }
  }
}
