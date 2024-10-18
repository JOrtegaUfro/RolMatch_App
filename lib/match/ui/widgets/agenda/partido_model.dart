import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rol_match/map/domain/hoja_map.dart';
import 'package:rol_match/match/ui/widgets/agenda/texts/text_model.dart';
import 'package:rol_match/match/ui/widgets/agenda/time/hour_style.dart';

class PartidoModel {
  //Widget que muestra la información del aprtido en la vista de partido en Hoja de información del partido
  Widget partidoContainer(BuildContext context, String description, String hour,
      String duration, double latitud, double longitud) {
    final ThemeData theme = Theme.of(context);
    HojaMap hojaMap = new HojaMap();
    HourStyle hourStyle = new HourStyle();
    return Container(
      height: 500.0,
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: theme.dialogBackgroundColor,
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
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextModel(text: description, size: 20.0, color: Colors.white),
          hojaMap.map(context, latitud, longitud),
          const SizedBox(height: 20),
          hourStyle.hourWidget(context, hour),
          TextModel(text: duration, size: 15.0, color: Colors.white),
        ],
      ),
    );
  }
}
