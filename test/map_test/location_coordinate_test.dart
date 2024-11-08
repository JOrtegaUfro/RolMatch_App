import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:rol_match/map/data/services/location_search.dart';
import 'package:rol_match/map/domain/location_coordinate.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared_preferences_test.mocks.dart';

void main() {
  late LocationSearch locationSearch;
  late DioAdapter dioAdapter;
  late Dio dio;
  setUp(() async {
    debugPrint("Mock de datos en shared preferences");

    SharedPreferences.setMockInitialValues({"longitud": 0.1, "latitud": 0.3});
  });

  testWidgets('Location Coordiante Test', (WidgetTester tester) async {
    LocationCoordinate coordinate = new LocationCoordinate();
    double longitud = await coordinate.getLongitude();
    expect(longitud, 0.1);

    double latitud = await coordinate.getLatitude();
    expect(latitud, 0.3);
  });

  testWidgets('Location Coordiante Test, setter test',
      (WidgetTester tester) async {
    var mockSharedPreferences = MockSharedPreferences();
    LocationCoordinate coordinate =
        new LocationCoordinate(sharedPreferences: mockSharedPreferences);
    when(mockSharedPreferences.setDouble("latitud", any))
        .thenAnswer((_) async => true);
    when(mockSharedPreferences.setDouble("longitud", any))
        .thenAnswer((_) async => true);

    await coordinate.setCoordinate(8.0, 4.0);
    verify(mockSharedPreferences.setDouble('longitud', 8.0)).called(1);
    verify(mockSharedPreferences.setDouble('latitud', 4.0)).called(1);
  });
}
