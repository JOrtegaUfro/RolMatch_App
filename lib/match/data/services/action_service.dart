import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

class ActionService {
  final Dio dio;
  String _ip = dotenv.env['APP_IP']!;
  ActionService({Dio? dio}) : dio = dio ?? Dio();
  Future<bool> reportUser(int id) async {
    String _url = 'http://$_ip/users/report/$id';

    Map<String, String> headers = {
      'Content.Type': 'application/json',
    };

    var response = await dio.patch(
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
}
