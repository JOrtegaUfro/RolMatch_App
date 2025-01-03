import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';

import 'package:rol_match/match/domain/models/player.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

//Servicio d eobtencion de partido en vista avanzada
class AdvancedReportService {
  final Dio dio;

  final SecureStorage? secureStorage;
  String _ip = dotenv.env['APP_IP']!;
  AdvancedReportService({Dio? dio, this.secureStorage}) : dio = dio ?? Dio();
  Future<List<Player>> getAllReportedPlayers() async {
    String _url = 'http://$_ip/admin/reported/1';
    dio.options.headers['Content-Type'] = 'application/json';

    var response = await dio.get(_url);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data;

      List<Player> players =
          jsonResponse.map((json) => Player.fromJson(json)).toList();

      return players;
    } else {
      List<Player> players = [];
      return players;
    }

    throw Exception('ERROR Fallo carga de jugadores de un partido');
  }
}
