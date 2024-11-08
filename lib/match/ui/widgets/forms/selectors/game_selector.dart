import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rol_match/match/domain/create/form_save.dart';

class GameSelector extends StatefulWidget {
  const GameSelector({super.key, this.sharedPreferences});
  final SharedPreferences? sharedPreferences;
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
    final prefs =
        widget.sharedPreferences ?? await SharedPreferences.getInstance();
    if (selectedValue is String) {
      setState(() {
        _dropDownValue = selectedValue;
        if (_dropDownValue != null) {
          _formSave.saveGame(_dropDownValue!);
          prefs.setString('game_selector_map', _dropDownValue!);
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
