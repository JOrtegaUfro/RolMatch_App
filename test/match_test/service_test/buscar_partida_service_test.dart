import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:rol_match/match/data/services/buscar_partida_service.dart';
import 'package:rol_match/match/domain/models/map_match.dart';

import 'package:rol_match/match/domain/models/owner_match.dart';

import '../../secure_storage_init_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Dio dio;
  late DioAdapter dioAdapter;
  late BuscarPartidaService buscarPartidoService;
  setUp(() async {
    await dotenv.load(fileName: ".env");
  });

  test('Utiliza BuscarPartidaService, retorna la lista de mapMatch', () async {
    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);
    var mockSecureStorage = MockSecureStorage();
    buscarPartidoService =
        BuscarPartidaService(dio: dio, secureStorage: mockSecureStorage);
    const path = 'http://10.0.2.2:3000/games/userSearch/1';
    Future<String> mockId() async {
      return "1";
    }

    when(mockSecureStorage.readSecureDataId()).thenAnswer((_) => mockId());

    dioAdapter.onGet(path, (server) {
      //debugPrint("Solicitud GET interceptada: ${server.toString()}");
      final matchList = [
        {
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
        },
        {
          "id": 2,
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
      ];
      server.reply(200, matchList);
    }, data: Matchers.any);

    // String mapMatchList =
    //     await buscarPartidoService.findMatchs("Test").toString();
    // print(mapMatchList);
    List<MapMatch> mapMatchList = await buscarPartidoService.findMatchs("Test");
    // print(mapMatchList.toString());
    // debugPrint(mapMatch.toString());
    expect(mapMatchList[0].latitud, 324342.43);
    expect(mapMatchList[0].longitud, 234432.54);
    expect(mapMatchList[0].date, "14-06-2024");
    expect(mapMatchList[0].duration, "60 minutos");
    expect(mapMatchList[0].hora, "20:30");
    expect(mapMatchList[0].type, "Tipo 1");
    expect(mapMatchList[0].totalSlots, 6);
    expect(mapMatchList[0].totalPlayers, 14);
  });

  test('Utiliza BuscarPartidaService, retorna excepción', () async {
    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);
    var mockSecureStorage = MockSecureStorage();
    buscarPartidoService =
        BuscarPartidaService(dio: dio, secureStorage: mockSecureStorage);
    const path = 'http://10.0.2.2:3000/games/userSearch/1';
    Future<String> mockId() async {
      return "1";
    }

    when(mockSecureStorage.readSecureDataId()).thenAnswer((_) => mockId());

    dioAdapter.onGet(path, (server) {
      server.reply(299, null);
    }, data: Matchers.any);

    expect(
      () async => await buscarPartidoService.findMatchs("Test"),
      throwsA(isA<Exception>().having((e) => e.toString(), 'message',
          contains('ERRROR Fallo carga de partidos'))),
    );
  });
  test('Utiliza BuscarPartidaService, retorna listado vacio', () async {
    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);
    var mockSecureStorage = MockSecureStorage();
    buscarPartidoService =
        BuscarPartidaService(dio: dio, secureStorage: mockSecureStorage);
    const path = 'http://10.0.2.2:3000/games/userSearch/1';
    Future<String> mockId() async {
      return "1";
    }

    when(mockSecureStorage.readSecureDataId()).thenAnswer((_) => mockId());

    dioAdapter.onGet(path, (server) {
      server.reply(200, null);
    });

    List<MapMatch> mapMatchList = await buscarPartidoService.findMatchs("Test");
    expect(mapMatchList, <MapMatch>[]);
  });
}
