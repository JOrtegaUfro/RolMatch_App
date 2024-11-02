import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rol_match/match/domain/create/form_save.dart';

class GameSelector extends StatefulWidget {
  const GameSelector({super.key});

  @override
  State<GameSelector> createState() {
    return _GameSelectorState();
  }
}

//Selección de deporte
class _GameSelectorState extends State<GameSelector> {
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
          prefs.setString('game_selector_map', _dropDownValue!);
          String sport = prefs.getString('game_selector_map')!;
          print("SET SET $sport");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text("Juego"),
      value: _dropDownValue,
      items: const [
        DropdownMenuItem(
          value: "DnD",
          child: Text("DnD"),
        ),
        DropdownMenuItem(
          value: "Cthulhu",
          child: Text("Cthulhu"),
        ),
        DropdownMenuItem(
          value: "Otro",
          child: Text("Otro"),
        ),
      ],
      onChanged: dropDownCallback,
    );
  }
}
