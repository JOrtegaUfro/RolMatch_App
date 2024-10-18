import 'package:flutter/material.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

class NameFutureBuilder extends StatelessWidget {
  final Future<String> future;

  NameFutureBuilder({required this.future});
  //Se construye nombre
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: future, // El Future
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Mostrar un indicador de carga
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Mostrar el error
        } else if (!snapshot.hasData) {
          return Text('No hay datos disponibles'); //No disponible
        } else {
          return Text(
            snapshot.data!, //Datos obtenidos (mostrar)
            style: TextStyle(fontSize: 30),
          );
        }
      },
    );
  }
}
