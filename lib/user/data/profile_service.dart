import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rol_match/user/data/storage/secure_storage.dart';
import 'package:rol_match/user/domain/models/medal.dart';

class ProfileService {
  String _ip = dotenv.env['APP_IP']!;

  //Servicio que obtiene medallas de usuario
  Future<List<Medal>> getMedals() async {
    SecureStorage secure = SecureStorage();
    String userId = await secure.readSecureDataId();
    String _url = 'http://$_ip/users/$userId';
    try {
      var response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);

        var medals = jsonResponse['medals'];
        List<Medal> medalsFinal = (medals as List<dynamic>)
            .map((json) => Medal.fromJson(json))
            .toList();
        return medalsFinal;
      } else {
        print('ERROR DE LA SOLICITUD: ${response.statusCode}');
        throw Exception('ERRROR Fallo carga de medallas');
      }
    } catch (e) {
      print('Error en solicitud: $e');
      throw Exception('ERRROR Fallo carga de medallas');
    }
  }
}
