import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:rol_match/admin/data/services/advanced_report_service.dart';
import 'package:rol_match/match/domain/models/player.dart';

import '../../secure_storage_init_test.mocks.dart';
import '../../shared_preferences_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Dio dio;
  late DioAdapter dioAdapter;
  late AdvancedReportService advancedService;
  setUp(() async {
    await dotenv.load(fileName: ".env");
  });

  test(
      'Utiliza advancedReportService getAllReportedPlayers(), y solo se llama una vez al backend, ademas de no presentar un error al recibir respuesta 200 y retornar lista de estos',
      () async {
    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);

    advancedService = AdvancedReportService(dio: dio);

    const path = 'http://10.0.2.2:3000/admin/reported/1';

    int count = 0;

    dioAdapter.onGet(path, (server) {
      final player = [
        {
          "id": 1,
          "firstName": "Juan",
          "picture": "https://picsum.photos/200/300"
        },
        {
          "id": 2,
          "firstName": "Pedrito",
          "picture": "https://picsum.photos/200/300"
        }
      ];
      server.reply(200, player);
    });

    List<Player> playerList = await advancedService.getAllReportedPlayers();

    expect(playerList[0].id, 1);
    expect(playerList[0].nombre, "Juan");
    expect(playerList[0].picture, "https://picsum.photos/200/300");
    expect(playerList[1].id, 2);
    expect(playerList[1].nombre, "Pedrito");
    expect(playerList[1].picture, "https://picsum.photos/200/300");
  });

  test(
      'Utiliza advancedService getAllMatchPlayers(), y solo se llama una vez al backend, ademas de presentar un error al recibir respuesta 299 y retornar una excepción',
      () async {
    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);

    advancedService = AdvancedReportService(dio: dio);

    const path = 'http://10.0.2.2:3000/admin/reported/1';

    int count = 0;

    dioAdapter.onGet(path, (server) {
      final player = [
        {
          "user": {
            "id": 1,
            "firstName": "Juan",
            "picture": "https://picsum.photos/200/300"
          }
        },
        {
          "user": {
            "id": 2,
            "firstName": "Pedrito",
            "picture": "https://picsum.photos/200/300"
          }
        }
      ];
      server.reply(299, player);
    });

    expect(advancedService.getAllReportedPlayers(), completion(isEmpty));
  });
}
