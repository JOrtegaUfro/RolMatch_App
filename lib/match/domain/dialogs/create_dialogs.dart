import 'package:flutter/material.dart';

class CreateDialogs {
  //Dialog de problema de slots en creación de Partido
  void showSlotsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          true, // Para evitar que se cierre al tocar fuera del dialog
      builder: (BuildContext context) {
        return const AlertDialog(
            content: SizedBox(
          height: 150,
          width: 200,
          child: Row(
            children: [
              Icon(Icons.warning),
              SizedBox(width: 20),
              Flexible(
                  child: Text(
                      "El numero de cupos debe ser menor a el numero total de jugadores")),
            ],
          ),
        ));
      },
    );
  }
}
