import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:rol_match/match/data/services/buscar_partida_service.dart';
import 'package:rol_match/match/data/services/join_service.dart';

import 'package:rol_match/match/domain/dialogs/search_dialogs.dart';

import '../secure_storage_init_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Dio dio;
  late DioAdapter dioAdapter;
  late JoinService joinService;
  late BuscarPartidaService buscarPartidoService;
  setUp(() async {
    debugPrint("Enviorment");

    await dotenv.load(fileName: ".env");
  });
  testWidgets(
      'search() muestra el diálogo de carga y maneja la respuesta incluye funciones privadas',
      (WidgetTester tester) async {
    SearchDialogs searchDialogs = SearchDialogs();

    final dio = Dio(BaseOptions());
    final dioAdapter = DioAdapter(dio: dio);

    const path = 'http://10.0.2.2/matches/nearestMatch/1';

    String body = json.encode({
      "id": 123,
      "game": "Tipo 1",
      "longitude": -58.3816,
      "latitude": -34.6037,
    });
    dioAdapter.onPost(
      path,
      data: body,
      (server) => server.reply(
        200,
        {
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
          }
        },
        delay: const Duration(seconds: 1),
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                searchDialogs.search(context, 'Tipo 1');
              },
              child: const Text('Iniciar búsqueda'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Iniciar búsqueda'));
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Cargando...'), findsOneWidget);
  });

  testWidgets(
      'El diálogo de carga y maneja la respuesta incluye diálogos privados, presiona Aceptar',
      (WidgetTester tester) async {
    SearchDialogs searchDialogs = SearchDialogs();

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                searchDialogs.testShowSearchDialog(context, "TitleTest", 1);
              },
              child: const Text('Iniciar búsqueda'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Iniciar búsqueda'));
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('TitleTest'), findsOneWidget);

    await tester.tap(find.text('Aceptar'));
  });

  testWidgets(
      'El diálogo de carga y maneja la respuesta incluye diálogos privados, Presiona Cancelar',
      (WidgetTester tester) async {
    SearchDialogs searchDialogs = SearchDialogs();

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                searchDialogs.testShowSearchDialog(context, "TitleTest", 1);
              },
              child: const Text('Iniciar búsqueda'),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Iniciar búsqueda'));
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('TitleTest'), findsOneWidget);

    await tester.tap(find.text('Cancelar'));
  });
}
