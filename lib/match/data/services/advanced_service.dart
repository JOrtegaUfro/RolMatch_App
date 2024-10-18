import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';
import 'package:http/http.dart' as http;
import 'package:rol_match/match/domain/models/player.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

//Servicio d eobtencion de partido en vista avanzada
class AdvancedService {
  String _ip = dotenv.env['APP_IP']!;
  Future<JoinedMatch> getMatch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('advanced_match_id')!;
    String _url = 'http://$_ip/matches/$id';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(Uri.parse(_url), headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      JoinedMatch match = JoinedMatch.fromJson(jsonResponse);
      return match;
    }

    throw Exception('ERRROR Fallo carga de vista avanzada');
  }

  Future<List<Player>> getAllMatchPlayers() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('advanced_match_id')!;
    String _url = 'http://$_ip/matches/$id/players';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(Uri.parse(_url), headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      List<Player> players =
          jsonResponse.map((json) => Player.fromJson(json['user'])).toList();

      return players;
    }

    throw Exception('ERRROR Fallo carga de jugadores de un partido');
  }

  void deleteMatch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('advanced_match_id')!;
    String _url = 'http://$_ip/matches/$id';
    var dio = Dio();
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
      print("ELIMNADO CORRECTAMENTE");
    } else {
      var error = response.data;
      print("ERROR DE SOLICITUD $error");
    }
  }

  void leaveMatch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    SecureStorage secure = new SecureStorage();
    String userId = await secure.readSecureDataId();
    int id = prefs.getInt('advanced_match_id')!;
    String _url = 'http://$_ip/matches/$id/leave/$userId';
    var dio = Dio();
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
      print("ABANDONADO CORRECTAMENTE");
    } else {
      var error = response.data;
      print("ERROR DE SOLICITUD $error");
    }
  }
}
