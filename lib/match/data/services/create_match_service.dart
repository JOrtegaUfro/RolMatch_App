import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rol_match/match/domain/models/match.dart';
import 'package:dio/dio.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

//Servicio de cración de partidos
class CreateMatchService {
  final Dio dio;
  final SecureStorage? secureStorage;
  CreateMatchService({Dio? dio, this.secureStorage}) : dio = dio ?? Dio();
  String _ip = dotenv.env['APP_IP']!;
  Future<bool> createMatch(Match match) async {
    //!Cambiar a id de usuario

    final secure = secureStorage ?? await SecureStorage();
    String userId = await secure.readSecureDataId();
    String _url = 'http://$_ip/games/$userId';

    //!Sin autorizacion por token
    Map<String, String> headers = {
      'Content.Type': 'application/json',
    };
    String body = json.encode(match.toJson());

    var response = await dio.post(
      _url,
      data: body,
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
}
