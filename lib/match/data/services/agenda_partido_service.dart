import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rol_match/match/domain/models/joined_match.dart';
import 'package:rol_match/match/domain/models/owner_match.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

//!Servicio para obtener lista de partidos
class AgendaPartidoService {
  final Dio dio;
  String _ip = dotenv.env['APP_IP']!;
  final SecureStorage? secureStorage;
  AgendaPartidoService({Dio? dio, this.secureStorage}) : dio = dio ?? Dio();
  Future<List<OwnerMatch>> listAgenda() async {
    //!Cambiar Id a Id de usuario en sesión
    final secure = secureStorage ?? await SecureStorage();
    String userId = await secure.readSecureDataId();
    String _url = 'http://$_ip/games/user/$userId';

    var response = await dio.get(_url);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data;
      List<OwnerMatch> matches =
          jsonResponse.map((json) => OwnerMatch.fromJson(json)).toList();
      print("MATCHES: $matches");
      return matches;
    } else {
      throw Exception('ERRROR Fallo carga de partidos');
    }
  }

  Future<List<JoinedMatch>> listAgendaJoined() async {
    //!Cambiar Id a Id de usuario en sesión
    final secure = secureStorage ?? await SecureStorage();
    String userId = await secure.readSecureDataId();
    String _url = 'http://$_ip/games/joined/$userId';

    var response = await dio.get(_url);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = response.data;
      List<JoinedMatch> matches =
          jsonResponse.map((json) => JoinedMatch.fromJson(json)).toList();
      print("MATCHES: $matches");
      return matches;
    } else {
      throw Exception('ERRROR Fallo carga de partidos');
    }
  }
}
