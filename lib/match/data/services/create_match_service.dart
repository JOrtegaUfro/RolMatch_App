import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rol_match/match/domain/models/match.dart';
import 'package:dio/dio.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

//Servicio de cración de partidos
class CreateMatchService {
  String _ip = dotenv.env['APP_IP']!;
  void createMatch(Match match) async {
    //!Cambiar a id de usuario
    SecureStorage secure = new SecureStorage();
    String userId = await secure.readSecureDataId();
    String _url = 'http://$_ip/matches/$userId';
    var dio = Dio();
    //!Sin autorizacion por token
    Map<String, String> headers = {
      'Content.Type': 'application/json',
    };
    String body = json.encode(match.toJson());

    print("Enviando $body");

    var response = await dio.post(
      _url,
      data: body,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );
    print("POST POST");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("CREADO CORRECTAMENTE");
    } else {
      var error = response.data;
      print("ERROR DE SOLICITUD $error");
    }
  }
}
