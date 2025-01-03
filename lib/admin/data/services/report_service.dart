import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

class ReportService {
  final Dio dio;
  String _ip = dotenv.env['APP_IP']!;
  ReportService({Dio? dio}) : dio = dio ?? Dio();
  Future<bool> deleteUser(int id) async {
    String _url = 'http://$_ip/admin/$id';

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

  Future<bool> clearUser(int id) async {
    String _url = 'http://$_ip/admin/reports/reset/$id';

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
