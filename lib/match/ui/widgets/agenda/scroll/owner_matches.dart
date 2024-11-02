import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rol_match/user/ui/widgets/buttons/live_button.dart';
import 'package:rol_match/map/ui/widgets/partido_map_container.dart';
import 'package:rol_match/match/ui/widgets/agenda/texts/text_model.dart';

class OwnerMatches {
  Widget Match(BuildContext context, String text, String hora, String duration,
      String totalPlayers, int id, double latitud, double longitud) {
    final ThemeData theme = Theme.of(context);
    return Container(
      height: 600.0,
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: theme.dialogBackgroundColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: Offset(4.0, 4.0),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-4.0, -4.0),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PartidoMapContainer(latitud: latitud, longitud: longitud),
          const SizedBox(height: 20),
          Body(context, text, hora, duration, totalPlayers, id),
        ],
      ),
    );
  }

  Widget JoinedMatch(
      BuildContext context,
      String text,
      String hora,
      String duration,
      String totalPlayers,
      int id,
      String title,
      double latitud,
      double longitud) {
    final ThemeData theme = Theme.of(context);
    return Container(
      height: 600.0,
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: theme.dialogBackgroundColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            offset: Offset(4.0, 4.0),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-4.0, -4.0),
            blurRadius: 15.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PartidoMapContainer(latitud: latitud, longitud: longitud),
          const SizedBox(height: 20),
          BodyJoined(context, title, text, hora, duration, totalPlayers, id),
        ],
      ),
    );
  }

//!Redirigir correctamente
  Widget Body(BuildContext context, String text, String hora, String duration,
      String totalPlayers, int id) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextModel(text: "Partido Propio", size: 20.0, color: Colors.white),
        TextModel(text: text, size: 15.0, color: Colors.white),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          TextModel(text: "H: $hora", size: 15.0, color: Colors.white),
          TextModel(
              text: "$totalPlayers jugadores", size: 15.0, color: Colors.white),
          Spacer(),
          TextModel(text: duration, size: 15.0, color: Colors.white),
        ]),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
          child: LiveButton(
              text: "Opciones avanzadas",
              onTap: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.setInt('advanced_match_id', id);
                Navigator.pushNamed(context, '/vistaAvanzadaPropio');
              }),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: LiveButton(
              text: "Hoja de información de la partida",
              onTap: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.setInt('advanced_match_id', id);
                Navigator.pushNamed(context, '/infoPartido');
              }),
        ),
      ],
    );
  }

  Widget BodyJoined(BuildContext context, String title, String text,
      String hora, String duration, String totalPlayers, int id) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextModel(text: title, size: 20.0, color: Colors.white),
        TextModel(text: text, size: 15.0, color: Colors.white),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          TextModel(text: "H: $hora", size: 15.0, color: Colors.white),
          TextModel(
              text: "$totalPlayers jugadores", size: 15.0, color: Colors.white),
          Spacer(),
          TextModel(text: duration, size: 15.0, color: Colors.white),
        ]),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
          child: LiveButton(
              text: "Opciones avanzadas",
              onTap: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.setInt('advanced_match_id', id);
                Navigator.pushNamed(context, '/vistaAvanzada');
              }),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: LiveButton(
              text: "Hoja de información del partido",
              onTap: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.setInt('advanced_match_id', id);
                Navigator.pushNamed(context, '/infoPartido');
              }),
        ),
      ],
    );
  }
}
