import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rol_match/match/domain/create/form_save.dart';

class SportSelector extends StatefulWidget {
  const SportSelector({super.key});

  @override
  State<SportSelector> createState() {
    return _SportSelectorState();
  }
}

//Selección de deporte
class _SportSelectorState extends State<SportSelector> {
  String? _dropDownValue;
  FormSave _formSave = new FormSave();

  void dropDownCallback(String? selectedValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (selectedValue is String) {
      setState(() {
        _dropDownValue = selectedValue;
        if (_dropDownValue != null) {
          _formSave.saveSport(_dropDownValue!);
          print("INTENTO INTENTO");
          prefs.setString('sport_selector_map', _dropDownValue!);
          String sport = prefs.getString('sport_selector_map')!;
          print("SET SET $sport");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text("Deporte"),
      value: _dropDownValue,
      items: const [
        DropdownMenuItem(
          value: "Básquetbol",
          child: Text("Básquetbol"),
        ),
        DropdownMenuItem(
          value: "Fútbol",
          child: Text("Futbol"),
        ),
        DropdownMenuItem(
          value: "Vóleibol",
          child: Text("Volleyball"),
        ),
      ],
      onChanged: dropDownCallback,
    );
  }
}
