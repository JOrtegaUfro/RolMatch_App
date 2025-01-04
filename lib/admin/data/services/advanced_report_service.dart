import 'package:dio/dio.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:rol_match/match/domain/models/player.dart';

//Servicio d eobtencion de partido en vista avanzada
class AdvancedReportService {
  final Dio dio;

  String _ip = dotenv.env['APP_IP']!;
  AdvancedReportService({Dio? dio}) : dio = dio ?? Dio();
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
  }
}
