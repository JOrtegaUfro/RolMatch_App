import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserService {
  String _ip = dotenv.env['APP_IP']!;
  //placeholder hasta tener endpoint de jugadores por partido

  void allPlayersService(int Id) async {
    try {
      String _url = 'http://$_ip/users';
      var response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = jsonDecode(response.body);

        print('Respuesta Backend: $jsonResponse');
      } else {
        print('ERROR DE LA SOLICITUD');
      }
    } catch (e) {
      print(' Error en solicitud: $e');
    }
  }
}
