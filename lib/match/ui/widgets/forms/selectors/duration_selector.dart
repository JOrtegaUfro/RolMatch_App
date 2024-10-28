import 'package:flutter/material.dart';
import 'package:rol_match/match/domain/create/form_save.dart';

class DurationSelector extends StatefulWidget {
  const DurationSelector({super.key});

  @override
  State<DurationSelector> createState() {
    return _DurationSelectorState();
  }
}

class _DurationSelectorState extends State<DurationSelector> {
  int? _dropDownValue;
  FormSave _formSave = new FormSave();
  //Se alamcena la opción
  void dropDownCallback(int? selectedValue) {
    if (selectedValue is int) {
      setState(() {
        _dropDownValue = selectedValue;
        if (_dropDownValue != null) {
          _formSave.saveDuration(_dropDownValue!);
        }
      });
    }
  }

  //Selector que selecciona la duración del partido
  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      hint: Text("Duración"),
      value: _dropDownValue,
      items: const [
        DropdownMenuItem(
          key: ValueKey("15min"),
          value: 15,
          child: Text("15 minutos"),
        ),
        DropdownMenuItem(
          value: 30,
          child: Text("30 minutos"),
        ),
        DropdownMenuItem(
          value: 45,
          child: Text("45 minutos"),
        ),
        DropdownMenuItem(
          value: 60,
          child: Text("60 minutos"),
        ),
      ],
      onChanged: dropDownCallback,
    );
  }
}
