import 'package:flutter/material.dart';
import 'package:rol_match/match/domain/create/form_save.dart';
import 'package:rol_match/match/domain/util/time_format.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() {
    return _DateSelectorState();
  }
}

class _DateSelectorState extends State<DateSelector> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  FormSave _formSave = new FormSave();
  TimeFormat _timeFormat = new TimeFormat();
  //Se muestra el seelector de fecha
  void _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _formSave.saveDate(_selectedDate);
      });
    }
  }

  //Selecciona hora
  void _showTimePicker() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        _formSave.saveHour(_selectedTime);
      });
    }
  }

  //Selector de hora
  void _showTime() async {
    final TimeOfDay? timeOfDay =
        await showTimePicker(context: context, initialTime: _selectedTime);
  }

  //Selección de fecha y hora
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            child: Text("Fecha"),
            onPressed: _showDatePicker,
          ),
          ElevatedButton(onPressed: _showTimePicker, child: Text("Hora")),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            " D: ${_selectedDate.toLocal().day}- ${_selectedDate.toLocal().month}",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "H: ${_timeFormat.formatTimeOfDay(_selectedTime)}",
            style: TextStyle(fontSize: 16),
          ),
        ],
      )
    ]);
  }
}
