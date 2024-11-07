import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_test.mocks.dart';

// Agregar la anotación para generar el mock
@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
  });
  //  Shared preferences es un servicio externo por lo que se crea un mock y se realizan pruebas sobre este
  test('Mock SharedPreferences test', () async {
    when(mockSharedPreferences.getString('game')).thenReturn('mocked_value');
    when(mockSharedPreferences.setString('game', 'mocked_value'))
        .thenAnswer((_) async => true);

    final result = await mockSharedPreferences.getString('game');
    expect(result, 'mocked_value');

    verify(mockSharedPreferences.getString('game')).called(1);
  });
}
