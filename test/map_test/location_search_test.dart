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

import '../shared_preferences_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Dio dio;
  late DioAdapter dioAdapter;
  late LocationSearch locationSearch;
  setUp(() async {
    await dotenv.load(fileName: ".env");
  });

  test('Utiliza BuscarPartidaService, retorna la lista de mapMatch', () async {
    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);
    var mockSharedPreferences = MockSharedPreferences();
    locationSearch =
        LocationSearch(dio: dio, sharedPreferences: mockSharedPreferences);
    const path =
        'https://nominatim.openstreetmap.org/search?format=json&limit=1&q=test';

    when(mockSharedPreferences.setDouble("latitud", any))
        .thenAnswer((_) async => true);
    when(mockSharedPreferences.setDouble("longitud", any))
        .thenAnswer((_) async => true);
    //
    Future<String> mockId() async {
      return "1";
    }

    dioAdapter.onGet(path, (server) {
      //debugPrint("Solicitud GET interceptada: ${server.toString()}");
      final locationList = [
        {
          "lat": "8.0",
          "lon": "4.0",
        },
        {
          "lat": "9.0",
          "lon": "5.0",
        }
      ];
      server.reply(200, jsonEncode(locationList).toString());
    }, data: Matchers.any);

    await locationSearch.location("test");
    verify(mockSharedPreferences.setDouble('latitud', 8.0)).called(1);
    verify(mockSharedPreferences.setDouble('longitud', 4.0)).called(1);
  });

  test('Reemplaza espacios con signos de más', () {
    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);
    var mockSharedPreferences = MockSharedPreferences();
    locationSearch =
        LocationSearch(dio: dio, sharedPreferences: mockSharedPreferences);

    const location = "San Francisco";
    const expected = "San+Francisco";

    final result = locationSearch.replaceLocation(location);

    expect(result, expected);
  });
}
