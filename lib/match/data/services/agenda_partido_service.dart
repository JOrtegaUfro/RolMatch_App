import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rol_match/match/domain/models/joined_match.dart';
import 'package:rol_match/match/domain/models/owner_match.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

//!Servicio para obtener lista de partidos
class AgendaPartidoService {
  String _ip = dotenv.env['APP_IP']!;
  Future<List<OwnerMatch>> listAgenda() async {
    //!Cambiar Id a Id de usuario en sesión
    SecureStorage secure = new SecureStorage();
    String userId = await secure.readSecureDataId();
    String _url = 'http://$_ip/matches/user/$userId';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(Uri.parse(_url), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
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
    SecureStorage secure = new SecureStorage();
    String userId = await secure.readSecureDataId();
    String _url = 'http://$_ip/matches/joined/$userId';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    var response = await http.get(Uri.parse(_url), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<JoinedMatch> matches =
          jsonResponse.map((json) => JoinedMatch.fromJson(json)).toList();
      print("MATCHES: $matches");
      return matches;
    } else {
      throw Exception('ERRROR Fallo carga de partidos');
    }
  }
}
