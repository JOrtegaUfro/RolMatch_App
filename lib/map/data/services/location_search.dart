import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class LocationSearch {
  final Dio dio;
  final SharedPreferences? sharedPreferences;

  LocationSearch({Dio? dio, this.sharedPreferences}) : dio = dio ?? Dio();
  Future<void> location(String location) async {
    final prefs = sharedPreferences ?? await SharedPreferences.getInstance();
    String searchLocation = replaceLocation(location);
    String endpoint =
        "https://nominatim.openstreetmap.org/search?format=json&limit=1&q=$searchLocation";

    try {
      var response = await dio.get(endpoint);
      var body = jsonDecode(response.data);
      if (body is List && body.isNotEmpty) {
        var firstResult = body[0];
        var latitude = double.parse(firstResult["lat"]);
        var longitud = double.parse(firstResult["lon"]);
        print("COORDENADAS: $latitude $longitud");
        prefs.setDouble("latitud", latitude);
        prefs.setDouble("longitud", longitud);
      } else {
        print("No se encontraron resultados para la ubicación.");
      }
    } catch (e) {
      print("ERROR DE LOCATION SEARCH: $e");
    }
  }

  String replaceLocation(String location) {
    String replaced = location.replaceAll(" ", "+");
    return replaced;
  }
}
