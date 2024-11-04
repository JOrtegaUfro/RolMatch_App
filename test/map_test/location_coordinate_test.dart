import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:rol_match/map/domain/location_coordinate.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
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

  //?Test con http adapter dio para llamada a servicio
}
