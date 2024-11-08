import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:rol_match/match/data/services/join_service.dart';

import '../../secure_storage_init_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Dio dio;
  late DioAdapter dioAdapter;
  late JoinService joinService;
  setUp(() async {
    debugPrint("Secure Storage declaration");

    await dotenv.load(fileName: ".env");
  });

  test(
      'Utiliza joinService JOIN(), y solo se llama una vez al backend, ademas de no presentar un error al recibir respuesta 200',
      () async {
    const path = 'http://10.0.2.2:3000/matches/1/join/1';
    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);
    var mockSecureStorage = MockSecureStorage();
    joinService = JoinService(dio: dio, secureStorage: mockSecureStorage);
    Future<String> mockId() async {
      return "1";
    }

    when(mockSecureStorage.readSecureDataId()).thenAnswer((_) => mockId());
    int count = 0;
    dioAdapter.onPost(path, (server) {
      count++;
      server.reply(200, null);
    });

    bool response = await joinService.join(1);
    expect(count, 1);
    verify(mockSecureStorage.readSecureDataId()).called(1);
    expect(response, true);
  });

  test(
      'Utiliza joinService JOIN(), y solo se llama una vez al backend, se muestra error con retorno false ante respuesta 299',
      () async {
    const path = 'http://10.0.2.2:3000/matches/1/join/1';
    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);
    var mockSecureStorage = MockSecureStorage();
    joinService = JoinService(dio: dio, secureStorage: mockSecureStorage);
    Future<String> mockId() async {
      return "1";
    }

    when(mockSecureStorage.readSecureDataId()).thenAnswer((_) => mockId());

    dioAdapter.onPost(path, (server) {
      server.reply(299, null);
    });

    bool response = await joinService.join(1);
    verify(mockSecureStorage.readSecureDataId()).called(1);
    expect(response, false);
  });
}
