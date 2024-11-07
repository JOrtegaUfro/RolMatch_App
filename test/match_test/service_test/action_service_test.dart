import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:rol_match/match/data/services/action_service.dart';

import 'package:rol_match/user/data/storage/secure_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SecureStorage _secureStorage;
  late Dio dio;
  late DioAdapter dioAdapter;
  late ActionService actionService;
  setUp(() async {
    debugPrint("Secure Storage declaration");

    _secureStorage = SecureStorage();

    await dotenv.load(fileName: ".env");

    debugPrint("Configurando Secure Storage con datos de prueba");

    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);
    actionService = ActionService(dio: dio);
  });

  test('Utiliza actionService reportUser, y solo se llama una vez al backend ',
      () async {
    final userData = {'name': 'John Doe', 'id': 1};
    const path = 'https://10.0.2.2:3000/users/report/1';
    int count = 0;

    dioAdapter.onPost(path, data: userData, (server) {
      count++;
      server.reply(200, null);
    });

    actionService.reportUser(1);
    expect(count, 1);
  });
}
