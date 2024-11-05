import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import 'package:rol_match/match/domain/dialogs/create_dialogs.dart';
import 'package:rol_match/match/domain/hoja/get_players.dart';
import 'package:rol_match/match/domain/models/player.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

void main() {
  late SecureStorage _secureStorage;
  setUp(() async {
    debugPrint("Secure Storage declaration");

    _secureStorage = SecureStorage();

    await dotenv.load(fileName: ".env");

    debugPrint("Configurando Secure Storage con datos de prueba");
    try {
      await _secureStorage.writeSecureData('authorization', "None");
      await _secureStorage.writeSecureData('name', "Usuario");
      await _secureStorage.writeSecureData('picture', "photo");
      await _secureStorage.writeSecureData('user_sesion_id', "1");
    } catch (e) {
      debugPrint("Error al configurar SecureStorage: $e");
    }
  });
  //!Este test no esta funcionando, problema con async
  testWidgets('Test obtención de todos los jugadores de un partido',
      (WidgetTester tester) async {
    GetPlayers getPlayers = new GetPlayers();
    final dio = Dio(BaseOptions());
    final dioAdapter = DioAdapter(dio: dio);

    const path = 'http://10.0.2.2/games/1/players';

    String body = json.encode({
      "id": 123,
      "game": "Tipo 1",
      "longitude": -58.3816,
      "latitude": -34.6037,
    });
    dioAdapter.onGet(
      path,
      (server) => server.reply(
        200,
        {
          [
            {
              "id": 1,
              "user": {
                "id": 1,
                "firstName": "Daniel",
                "lastName": "Ruiz",
                "email": "d.ruiz03@ufromail.cl",
                "picture": null,
                "role": "user",
                "reports": 0,
                "createdAt": "2024-11-04T16:25:16.339Z"
              },
              "game": {
                "id": 1,
                "title": "Fútbol 7v7 user3",
                "description": "Partido de fútbol 7v7",
                "duration": "60 minutos",
                "date": "14-06-2024",
                "hour": "20:30",
                "latitude": 324342.43,
                "longitude": 234432.54,
                "playerSlots": 6,
                "totalPlayers": 14,
                "type": "Tipo 1",
                "createdAt": "2024-11-04T16:25:41.168Z"
              }
            }
          ]
        },
        delay: const Duration(seconds: 1),
      ),
    );
    Future<List<Player>> playersFuture = getPlayers.getPlayers();
    List<Player> players = await playersFuture;

    expect(players.isNotEmpty, true);
    var nombre = players[0].nombre;

    print(nombre);
    expect(nombre, "Daniel");
//
  });
}
