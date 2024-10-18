import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlotModel extends StatefulWidget {
  @override
  _SlotModelState createState() => _SlotModelState();
}

class _SlotModelState extends State<SlotModel> {
  late PlaceConstraint _placesModel;
  final TextEditingController _totalPlayersController = TextEditingController();
  final TextEditingController _slotsController = TextEditingController();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _placesModel = PlaceConstraint(totalPlayers: 1, slots: 0);
    _totalPlayersController.text = "1";
    _slotsController.text = "0";
  }

  void _updateTotalPlayers(String value) {
    setState(() {
      try {
        int totalPlayers = int.parse(value);
        _placesModel.totalPlayers = totalPlayers;
        _errorMessage = null;
        if (_errorMessage == null) {
          _savePlayer(totalPlayers);
        }
      } catch (e) {
        _errorMessage = e.toString();
      }
    });
  }

  void _updateSlots(String value) {
    setState(() {
      try {
        int slots = int.parse(value);
        _placesModel.slots = slots;
        _errorMessage = null;
        if (_errorMessage == null) {
          _saveSlot(slots);
        }
      } catch (e) {
        _errorMessage = e.toString();
      }
    });
  }

  void _savePlayer(int players) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('totalPlayers', players);
  }

  void _saveSlot(int slots) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('totalSlots', slots);
  }

  @override
  void dispose() {
    _totalPlayersController.dispose();
    _slotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 120,
              child: TextField(
                maxLength: 2,
                controller: _slotsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Número de cupos'),
                onChanged: _updateSlots,
              ),
            ),
            SizedBox(
              width: 120,
              child: TextField(
                maxLength: 2,
                controller: _totalPlayersController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Jugadores totales'),
                onChanged: _updateTotalPlayers,
              ),
            ),
          ],
        ),
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _errorMessage!,
              style: TextStyle(color: Colors.red),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Cupos: ${_placesModel.slots}'),
            SizedBox(
              width: 20,
            ),
            Text('Total Jugadores: ${_placesModel.totalPlayers}'),
          ],
        )
      ],
    );
  }
}

class PlaceConstraint {
  int _totalPlayers;
  int _slots;

  PlaceConstraint({required int totalPlayers, required int slots})
      : _totalPlayers = totalPlayers,
        _slots = slots {
    if (slots > totalPlayers) {
      throw ArgumentError(
          "El número de cupos no puede superar el número de jugadores totales");
    }
  }

  int get totalPlayers => _totalPlayers;
  int get slots => _slots;

  set totalPlayers(int value) {
    if (value < _slots) {
      throw ArgumentError(
          "El número de jugadores totales no puede ser menor que el número de cupos");
    }
    _totalPlayers = value;
  }

  set slots(int value) {
    if (value > _totalPlayers) {
      throw ArgumentError(
          "El número de cupos no puede superar el número de jugadores totales");
    }
    _slots = value;
  }

  @override
  String toString() {
    return 'PlaceConstraint(totalPlayers: $_totalPlayers, slots: $_slots)';
  }
}
