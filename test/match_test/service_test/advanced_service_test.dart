import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:rol_match/match/data/services/advanced_service.dart';
import 'package:rol_match/match/data/services/join_service.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

import '../../shared_preferences_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SecureStorage _secureStorage;
  late Dio dio;
  late DioAdapter dioAdapter;
  late AdvancedService advancedService;
  setUp(() async {
    debugPrint("Secure Storage declaration");

    _secureStorage = SecureStorage();

    await dotenv.load(fileName: ".env");

    debugPrint("Configurando Secure Storage con datos de prueba");
    try {
      await _secureStorage.writeSecureData('authorization', "None");
      await _secureStorage.writeSecureData('name', "Usuario");
      await _secureStorage.writeSecureData('picture',
          "https://media.4-paws.org/b/e/2/d/be2d88ceb9613ac5066bd11dd950faaf2671bef7/VIER%20PFOTEN_2019-03-15_001-1998x1999-600x600.jpg");
      await _secureStorage.writeSecureData('user_sesion_id', "1");
    } catch (e) {
      debugPrint("Error al configurar SecureStorage: $e");
    }
  });

  test(
      'Utiliza advancedService JOIN(), y solo se llama una vez al backend, ademas de no presentar un error al recibir respuesta 200 y retornar match',
      () async {
    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);
    var mockSharedPreferences = MockSharedPreferences();
    advancedService =
        AdvancedService(dio: dio, sharedPreferences: mockSharedPreferences);
    when(mockSharedPreferences.getInt('advanced_match_id')).thenReturn(1);
    const path = 'http://10.0.2.2:3000/games/1';

    int count = 0;

    dioAdapter.onGet(path, (server) {
      //debugPrint("Solicitud GET interceptada: ${server.toString()}");
      final match = {
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
      };
      server.reply(200, match);
    });

    JoinedMatch joinedMatch = await advancedService.getMatch();
    expect(joinedMatch.id, 1);
    expect(joinedMatch.title, "Fútbol 7v7 user3");
    expect(joinedMatch.latitud, 324342.43);
    expect(joinedMatch.longitud, 234432.54);
    expect(joinedMatch.date, "14-06-2024");
    expect(joinedMatch.duration, "60 minutos");
    expect(joinedMatch.hora, "20:30");
    expect(joinedMatch.type, "Tipo 1");
    expect(joinedMatch.totalSlots, 6);
    expect(joinedMatch.totalPlayers, 14);
    // expect(count, 1);
  });
}
