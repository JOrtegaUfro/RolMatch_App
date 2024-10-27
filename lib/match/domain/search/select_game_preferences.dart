import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rol_match/match/ui/widgets/forms/selectors/game_selector.dart';

//Logica de seleccion de preferencia de desporte
class SelectSportPreferences {
  //Se guarda la seleccion del scroll selector para utilizarse en la búsqueda
  Widget botonConfig(context) {
    return Container(
      height: 50.0,
      width: 50.0,
      child: TextButton(
        child: Icon(Icons.settings_applications),
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Seleccionar categoria'),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('¿Qué juego deseas seleccionar?'),
                  SizedBox(
                    height: 20,
                  ),
                  GameSelector()
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancelar'),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String chosed = prefs.getString('game_selector_map')!;
                    prefs.setString('game_pref', chosed);
                    print("chosed");
                    Navigator.pop(context, 'Ok');
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
