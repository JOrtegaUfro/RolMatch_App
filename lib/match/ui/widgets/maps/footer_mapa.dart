import 'package:flutter/material.dart';
import 'package:rol_match/match/domain/search/select_sport_preferences.dart';

class FooterMapa extends StatelessWidget {
  const FooterMapa({super.key});

  //Footer de configuracion de la app
  @override
  Widget build(BuildContext context) {
    SelectSportPreferences preferences = new SelectSportPreferences();
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.dialogBackgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              print("Conectado");
            },
            child: const Text(
              "Configuración",
            ),
          ),
          Spacer(),
          preferences.botonConfig(context),
        ],
      ),
    );
  }
}
