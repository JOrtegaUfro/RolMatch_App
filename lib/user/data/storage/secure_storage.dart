import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage storage;

  // Constructor que permite inyectar una instancia personalizada
  SecureStorage({FlutterSecureStorage? storage})
      : storage = storage ?? const FlutterSecureStorage();

  Future<void> writeSecureData(String key, String value) async {
    await storage.write(key: key, value: value);
    print('datos encriptados');
  }

  Future<String> readSecureData(String key) async {
    String value = await storage.read(key: key) ?? 'Dato no encontrado';
    return value;
  }

  Future<String> readSecureDataId() async {
    String valueId =
        await storage.read(key: 'user_sesion_id') ?? 'Dato no encontrado ID';
    return valueId;
  }

  Future<void> deleteSecureData(String key) async {
    await storage.delete(key: key);
  }
}
