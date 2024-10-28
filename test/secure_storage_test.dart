import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

import 'secure_storage_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  final mockFlutterSecureStorage = MockFlutterSecureStorage();
  final secureStorage = SecureStorage(storage: mockFlutterSecureStorage);

  group('SecureStorage Tests', () {
    test('Guarda un valor en SecureStorage', () async {
      when(mockFlutterSecureStorage.write(key: 'token', value: '12345'))
          .thenAnswer((_) async => null);

      await secureStorage.writeSecureData('token', '12345');

      verify(mockFlutterSecureStorage.write(key: 'token', value: '12345'))
          .called(1);
    });

    test('Obtiene un valor de SecureStorage', () async {
      when(mockFlutterSecureStorage.read(key: 'token'))
          .thenAnswer((_) async => '12345');

      final value = await secureStorage.readSecureData('token');

      expect(value, '12345');
      verify(mockFlutterSecureStorage.read(key: 'token')).called(1);
    });

    test('Elimina un valor en SecureStorage', () async {
      when(mockFlutterSecureStorage.delete(key: 'token'))
          .thenAnswer((_) async => null);

      await secureStorage.deleteSecureData('token');

      verify(mockFlutterSecureStorage.delete(key: 'token')).called(1);
    });
  });
}
