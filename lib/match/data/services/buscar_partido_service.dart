import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:rol_match/match/domain/models/map_match.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

class BuscarPartidoService {
  String _ip = dotenv.env['APP_IP']!;
  Future<List<MapMatch>> findMatchs(String sport) async {
    //!Cambiar a id de usuario
    SecureStorage secure = new SecureStorage();
    String userId = await secure.readSecureDataId();

    String _url = 'http://$_ip/matches/userSearch/$userId';
    var dio = Dio();
    var userIdInt = int.parse(userId);
    //!Sin autorizacion por token
    Map<String, String> headers = {
      'Content.Type': 'application/json',
    };
    String body = json.encode({
      "id": userIdInt,
      "sport": sport.toString(),
    });

    print("Enviando $body");
    try {
      var response = await dio.get(
        _url,
        data: body,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      print("POST POST");
      print("$response");
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> jsonResponse = response.data;
        List<MapMatch> matches =
            jsonResponse.map((json) => MapMatch.fromJson(json)).toList();
        print("SE ENCONTRARON PARTIDAS");
        return matches;
      } else {
        var error = response.data;
        print("ERROR DE SOLICITUD $error");
      }
    } catch (e) {
      print("FALLO FALLO FALLO $e");
    }

    throw Exception('ERRROR Fallo carga de partidos');
  }

  Future<JoinedMatch> findNearestMatch(String sport) async {
    SecureStorage secure = new SecureStorage();
    String userId = await secure.readSecureDataId();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    double longitud = await prefs.getDouble('user_sesion_longitud')!;
    double latitud = await prefs.getDouble('user_sesion_latitud')!;
    String _url = 'http://$_ip/matches/nearestMatch/1';
    var dio = Dio();
    var userIdInt = int.parse(userId);

    Map<String, String> headers = {
      'Content.Type': 'application/json',
    };

    String body = json.encode({
      "id": userIdInt,
      "sport": sport.toString(),
      "longitude": longitud,
      "latitude": latitud
    });

    print("Enviando $body");

    final Duration retryInterval = Duration(seconds: 3);
    final Duration timeoutDuration = Duration(seconds: 30);
    DateTime startTime = DateTime.now();

    while (DateTime.now().difference(startTime) < timeoutDuration) {
      try {
        var response = await dio.get(
          _url,
          data: body,
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
        );
        print("POST POST");
        print("$response");
        if (response.statusCode == 200 || response.statusCode == 201) {
          var jsonResponse = response.data;
          JoinedMatch match = JoinedMatch.fromJson(jsonResponse);
          print("SE ENCONTRARON PARTIDAS");
          return match;
        } else {
          var error = response.data;
          print("ERROR DE SOLICITUD $error");
        }
      } catch (e) {
        print("FALLO FALLO FALLO $e");
      }

      await Future.delayed(retryInterval);
    }

    throw Exception('No se encontro ningun partido en base a las preferencias');
  }

  Future<Position> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("OBTENIENDO UBICACION");
    if (!serviceEnabled) {
      return Future.error('Servicios de ubicación deshabilitados');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(
            'Permisos de ubicación denegados de forma permanente');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Permisos de ubicación denegados de forma permanente');
    }
    return await Geolocator.getCurrentPosition();
  }
}
