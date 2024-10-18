import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';
import 'package:http/http.dart' as http;
import 'package:rol_match/match/domain/models/player.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

class ActionService {
  String _ip = dotenv.env['APP_IP']!;
  void reportUser(int id) async {
    String _url = 'http://$_ip:3000/users/report/$id';
    var dio = Dio();
    Map<String, String> headers = {
      'Content.Type': 'application/json',
    };

    var response = await dio.patch(
      _url,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );
    print("POST POST");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("REPORTADO CORRECTAMENTE");
    } else {
      var error = response.data;
      print("ERROR DE SOLICITUD $error");
    }
  }

  void recommendUser(int id) async {
    String _url = 'http://$_ip/users/recommend/$id';
    var dio = Dio();
    Map<String, String> headers = {
      'Content.Type': 'application/json',
    };

    var response = await dio.patch(
      _url,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );
    print("POST POST");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("RECOMENDADO CORRECTAMENTE");
    } else {
      var error = response.data;
      print("ERROR DE SOLICITUD $error");
    }
  }
}
