import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:rol_match/map/data/services/location_search.dart';
import 'package:rol_match/match/data/services/buscar_partida_service.dart';
import 'package:rol_match/match/domain/models/map_match.dart';

import 'package:rol_match/match/domain/models/owner_match.dart';
import 'package:rol_match/match/ui/widgets/forms/selectors/game_selector.dart';

import '../../shared_preferences_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late GameSelector gameSelector;
  setUp(() async {
    await dotenv.load(fileName: ".env");
  });

  testWidgets('GameSelector llama correctamente a SharedPreferences',
      (WidgetTester tester) async {
    var mockSharedPreferences = MockSharedPreferences();
    gameSelector = GameSelector(sharedPreferences: mockSharedPreferences);

    when(mockSharedPreferences.setString('type', any))
        .thenAnswer((_) async => true);

    //

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return gameSelector;
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.tap(find.text("Juego"));
    await tester.pumpAndSettle();
    await tester.tap(find.text("Cthulhu"));
    verify(mockSharedPreferences.setString('type', 'Cthulhu')).called(1);
  });
}
