import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';

import 'package:rol_match/match/domain/models/player.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

//Servicio d eobtencion de partido en vista avanzada
class AdvancedService {
  final Dio dio;
  final SharedPreferences? sharedPreferences;
  final SecureStorage? secureStorage;
  String _ip = dotenv.env['APP_IP']!;
  AdvancedService({Dio? dio, this.sharedPreferences, this.secureStorage})
      : dio = dio ?? Dio();

  //
  //
  Future<JoinedMatch> getMatch() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    final prefs = sharedPreferences ?? await SharedPreferences.getInstance();
    int id = prefs.getInt('advanced_match_id')!;
    String _url = 'http://$_ip/games/$id';

    dio.options.headers['Content-Type'] = 'application/json';
    var response = await dio.get(_url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = response.data;
      JoinedMatch match = JoinedMatch.fromJson(jsonResponse);
      return match;
    }

    throw Exception('ERRROR Fallo carga de vista avanzada');
  }

  Future<List<Player>> getAllMatchPlayers() async {
    final prefs = sharedPreferences ?? await SharedPreferences.getInstance();
    int id = prefs.getInt('advanced_match_id')!;
    String _url = 'http://$_ip/games/$id/players';
    dio.options.headers['Content-Type'] = 'application/json';
    var response = await dio.get(_url);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data;

      List<Player> players =
          jsonResponse.map((json) => Player.fromJson(json['user'])).toList();

      return players;
    }

    throw Exception('ERROR Fallo carga de jugadores de un partido');
  }

  Future<bool> deleteMatch() async {
    final prefs = sharedPreferences ?? await SharedPreferences.getInstance();
    int id = prefs.getInt('advanced_match_id')!;
    String _url = 'http://$_ip/games/$id';

    //!Sin autorizacion por token
    Map<String, String> headers = {
      'Content.Type': 'application/json',
    };

    var response = await dio.delete(
      _url,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      var error = response.data;
      debugPrint("ERROR DE SOLICITUD $error");
      return false;
    }
  }

  Future<bool> leaveMatch() async {
    final prefs = sharedPreferences ?? await SharedPreferences.getInstance();
    final secure = secureStorage ?? await SecureStorage();

    String userId = await secure.readSecureDataId();
    int id = prefs.getInt('advanced_match_id')!;
    String _url = 'http://$_ip/games/$id/leave/$userId';

    //!Sin autorizacion por token
    Map<String, String> headers = {
      'Content.Type': 'application/json',
    };

    var response = await dio.delete(
      _url,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );
    print("POST POST");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      var error = response.data;
      debugPrint("ERROR DE SOLICITUD $error");
      return false;
    }
  }
}
