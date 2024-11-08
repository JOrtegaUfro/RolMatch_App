import 'package:dio/dio.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';

import 'package:rol_match/match/data/services/create_match_service.dart';

import 'package:rol_match/match/domain/models/match.dart';
import '../../secure_storage_init_test.mocks.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late CreateMatchService createMatchService;
  setUp(() async {
    await dotenv.load(fileName: ".env");
  });

  test('Utiliza createMatchService createMatch() respuesta 200 con return true',
      () async {
    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);
    var mockSecureStorage = MockSecureStorage();
    createMatchService =
        CreateMatchService(dio: dio, secureStorage: mockSecureStorage);
    Future<String> mockId() async {
      return "1";
    }

    when(mockSecureStorage.readSecureDataId()).thenAnswer((_) => mockId());
    const path = 'http://10.0.2.2:3000/games/1';

    Match match = Match(
        latitud: 304342.43,
        longitud: 274432.54,
        date: "18-06-2024",
        duration: "30 minutos",
        hora: "22:30",
        type: "Tipo 2",
        totalSlots: 5,
        totalPlayers: 20);

    dioAdapter.onPost(path, (server) {
      server.reply(200, null);
    }, data: Matchers.any);

    bool response = await createMatchService.createMatch(match);
    expect(response, true);
  });

  test(
      'Utiliza createMatchService createMatch(), y solo se llama una vez al backend',
      () async {
    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);
    var mockSecureStorage = MockSecureStorage();
    createMatchService =
        CreateMatchService(dio: dio, secureStorage: mockSecureStorage);
    Future<String> mockId() async {
      return "1";
    }

    when(mockSecureStorage.readSecureDataId()).thenAnswer((_) => mockId());
    const path = 'http://10.0.2.2:3000/games/1';

    Match match = Match(
        latitud: 304342.43,
        longitud: 274432.54,
        date: "18-06-2024",
        duration: "30 minutos",
        hora: "22:30",
        type: "Tipo 2",
        totalSlots: 5,
        totalPlayers: 20);

    dioAdapter.onPost(path, (server) {
      server.reply(200, null);
    }, data: Matchers.any);

    await createMatchService.createMatch(match);

    verify(mockSecureStorage.readSecureDataId()).called(1);
  });
}
