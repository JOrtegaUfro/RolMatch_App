import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rol_match/match/domain/join_match.dart';

class SearchMatch {
  JoinMatch joinMatch = new JoinMatch();
  List<Marker> OwnerMatches(BuildContext context, List<dynamic> matches) {
    List<Marker> marcadores = [];
    matches.forEach((match) {
      String type = match.type;
      String typeMatch = "partida de $type";
      final tempMatch = Marker(
        point: LatLng(match.latitud, match.longitud),
        height: 40,
        width: 40,
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(match.description),
                content: Text(match.type),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Cierra el AlertDialog al hacer clic en el botón
                    },
                    child: Text('Cerrar'),
                  ),
                  TextButton(
                    onPressed: () {
                      joinMatch.join(match.id);
                      Navigator.pop(
                          context); // Cierra el AlertDialog al hacer clic en el botón
                    },
                    child: Text('Unirse'),
                  )
                ],
              ),
            );
          },
          child: Icon(Icons.sports_score, color: Colors.purple),
        ),
      );
      marcadores.add(tempMatch);
    });

    return marcadores;
  }
}
