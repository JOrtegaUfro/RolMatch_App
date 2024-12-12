import 'package:dio/dio.dart';
import "package:flutter/material.dart";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:rol_match/match/domain/models/map_match.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

class BuscarPartidaService {
  String _ip = dotenv.env['APP_IP']!;

  final Dio dio;
  final SharedPreferences? sharedPreferences;
  final SecureStorage? secureStorage;

  BuscarPartidaService({Dio? dio, this.sharedPreferences, this.secureStorage})
      : dio = dio ?? Dio();
  Future<List<MapMatch>> findMatchs(String game) async {
    final secure = secureStorage ?? await SecureStorage();
    print("APP_IP is $_ip");
    //!Cambiar a id de usuario
    //
    String userId = await secure.readSecureDataId();
    var userIdInt = int.parse(userId);
    String _url = 'http://$_ip/games/userSearch/$userId';
    //
    //
    //--
    //!Sin autorizacion por token
    Map<String, String> headers = {
      'Content.Type': 'application/json',
    };
    String body = json.encode({
      "id": userIdInt,
      "game": game.toString(),
    });
    //
    //
    //---
    var response;
    try {
      response = await dio.get(
        _url,
        data: body,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
      return <MapMatch>[];
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> jsonResponse = response.data;
      List<MapMatch> matches =
          jsonResponse.map((json) => MapMatch.fromJson(json)).toList();

      return matches;
    } else {
      var error = response.data;
      debugPrint(error.toString());
      throw Exception('ERRROR Fallo carga de partidos');
    }
  }

  Future<JoinedMatch> findNearestMatch(String game) async {
    final secure = secureStorage ?? await SecureStorage();
    String userId = await secure.readSecureDataId();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    double longitud = await prefs.getDouble('user_sesion_longitud')!;
    double latitud = await prefs.getDouble('user_sesion_latitud')!;
    String _url = 'http://$_ip/matches/nearest-game/1';

    var userIdInt = int.parse(userId);

    Map<String, String> headers = {
      'Content.Type': 'application/json',
    };

    String body = json.encode({
      "id": userIdInt,
      "game": game.toString(),
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
