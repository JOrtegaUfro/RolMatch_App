import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:rol_match/admin/data/services/report_service.dart';

import 'package:rol_match/user/data/storage/secure_storage.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SecureStorage _secureStorage;
  late Dio dio;
  late DioAdapter dioAdapter;
  late ReportService reportService;
  setUp(() async {
    debugPrint("Secure Storage declaration");

    _secureStorage = SecureStorage();

    await dotenv.load(fileName: ".env");

    debugPrint("Configurando Secure Storage con datos de prueba");

    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);
    reportService = ReportService(dio: dio);
  });

  test('Utiliza ReportService clearUser, y solo se llama una vez al backend ',
      () async {
    final userData = {'name': 'John Doe', 'id': 1};
    const path = 'http://10.0.2.2:3000/admin/reports/reset/1';
    int count = 0;
    //RegExp(r'.*')
    dioAdapter.onPatch(path, (server) {
      count++;
      server.reply(200, null);
    });

    bool result = await reportService.clearUser(1);
    expect(count, 1);
    expect(result, true);
  });

  test('Utiliza ReportService clearUser, pero falla con un error', () async {
    const path = 'http://10.0.2.2:3000/admin/reports/reset/1';

    int count = 0;

    dioAdapter.onPatch(path, (server) {
      count++;
      server.reply(202, {'error': 'Bad request'});
    });

    bool result = await reportService.clearUser(1);
    expect(count, 1);
    expect(result, false);
  });

  test('Utiliza ReportService deleteUser, y solo se llama una vez al backend ',
      () async {
    final userData = {'name': 'John Doe', 'id': 1};
    const path = 'http://10.0.2.2:3000/admin/1';
    int count = 0;
    //RegExp(r'.*')
    dioAdapter.onDelete(path, (server) {
      count++;
      server.reply(200, null);
    });

    bool result = await reportService.deleteUser(1);
    expect(count, 1);
    expect(result, true);
  });

  test('Utiliza ReportService deleteUser, pero falla con un error', () async {
    const path = 'http://10.0.2.2:3000/admin/1';

    int count = 0;

    dioAdapter.onDelete(path, (server) {
      count++;
      server.reply(202, {'error': 'Bad request'});
    });

    bool result = await reportService.deleteUser(1);
    expect(count, 1);
    expect(result, false);
  });
}
