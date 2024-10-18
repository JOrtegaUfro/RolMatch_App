import 'package:flutter/material.dart';
import 'package:rol_match/match/ui/widgets/agenda/texts/text_model.dart';

//Se encarga de gestionar el estilo de la hora del partido para la vista de partido en hoja de información del partido
class HourStyle {
  Widget hourWidget(context, String hour) {
    final ThemeData theme = Theme.of(context);
    List<String> time = splitString(hour);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 20,
        ),
        Container(
            decoration: BoxDecoration(
              color: theme.primaryColor,
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
                  spreadRadius: 5.0,
                ),
              ],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextModel(text: time[0], size: 30.0, color: Colors.white)),
        Text(
          ":",
          style: TextStyle(fontSize: 40),
        ),
        Container(
            decoration: BoxDecoration(
              color: theme.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  offset: Offset(4.0, 4.0),
                  blurRadius: 15.0,
                  spreadRadius: 5.0,
                ),
                BoxShadow(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 15.0,
                  spreadRadius: 1.0,
                ),
              ],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextModel(text: time[1], size: 30.0, color: Colors.white)),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  List<String> splitString(String input) {
    return input.split(':');
  }
}
