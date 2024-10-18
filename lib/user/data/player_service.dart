import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rol_match/match/domain/models/player.dart';
import 'package:rol_match/user/domain/models/medal.dart';

class PlayerService {
  String _ip = dotenv.env['APP_IP']!;
  //Servicio que obteiene medallas de jugador
  Future<List<Medal>> getMedals(int userId) async {
    String _url = 'http://$_ip/users/$userId';
    print("BUSCANDO MEDALLAS");
    try {
      var response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);

        var medals = jsonResponse['medals'];
        List<Medal> medalsFinal = (medals as List<dynamic>)
            .map((json) => Medal.fromJson(json))
            .toList();
        print(medalsFinal);
        return medalsFinal;
      } else {
        print('ERROR DE LA SOLICITUD: ${response.statusCode}');
        throw Exception('ERRROR Fallo carga de medallas');
      }
    } catch (e) {
      print('Error en solicitud: $e');
      throw Exception('ERRROR Fallo carga de medallas');
    }
  }

  //Servicio que obtiene jugador por id
  Future<Player> getPlayer(int userId) async {
    String _url = 'http://$_ip/users/$userId';
    try {
      var response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);

        var playerResponse = jsonResponse;
        if (playerResponse['picture'] != null) {
          Player player = Player.fromJson(playerResponse);
          return player;
        } else {
          Player player = Player.fromJson(playerResponse);
          player.picture =
              'https://media.4-paws.org/b/e/2/d/be2d88ceb9613ac5066bd11dd950faaf2671bef7/VIER%20PFOTEN_2019-03-15_001-1998x1999-600x600.jpg';
          return player;
        }
      } else {
        print('ERROR DE LA SOLICITUD: ${response.statusCode}');
        throw Exception('ERROR: Fallo carga de player');
      }
    } catch (e) {
      print('Error en solicitud: $e');
      throw Exception('ERROR: Fallo carga de player');
    }
  }
}
