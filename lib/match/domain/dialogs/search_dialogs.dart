import 'package:flutter/material.dart';
import 'package:rol_match/match/data/services/buscar_partido_service.dart';
import 'package:rol_match/match/data/services/join_service.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';
import 'package:rol_match/match/domain/create/notifications_services.dart';

class SearchDialogs {
  //!Colocar dialogos de Vista Buscar Partida aqui
  JoinService join = new JoinService();
  void search(BuildContext context, String sport) {
    final BuscarPartidoService partidoService = BuscarPartidoService();

    // Mostrar carga
    _showLoadingDialog(context);

    partidoService.findNearestMatch(sport).then((JoinedMatch match) {
      //Cerrar
      Navigator.of(context).pop();

      // Mostrar el diálogo
      _showSearchDialog(context, match.title!, match.id!);
      mostrarNotifications(sport);
    }).catchError((error) {
      // Cerrar el diálogo de carga
      Navigator.of(context).pop();
      negativeNotifications();
      // Mostrar un error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Tuvimos un problema'),
            content: Text('Parece que $error'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cerrar
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  //Dialog que muestra la busqueda d euna partida
  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Para evitar que se cierre al tocar fuera del dialog
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Cargando..."),
            ],
          ),
        );
      },
    );
  }

  //Dialog que muestra la partida encontrada y permite unirse a esta
  Future _showSearchDialog(BuildContext context, String title, int id) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Partida encontrada! "),
        //?Quiza un column para mas info
        content: Text("$title"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cerrar
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              join.join(id);
              Navigator.pop(context); //Cerrar
            },
            child: Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
