import 'package:flutter/material.dart';
import 'package:rol_match/match/data/services/advanced_service.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';
import 'package:rol_match/user/ui/widgets/buttons/live_button.dart';
import 'package:rol_match/map/ui/widgets/form_map_container.dart';
import 'package:rol_match/map/ui/widgets/partido_map_container.dart';
import 'package:rol_match/match/ui/widgets/agenda/texts/text_model.dart';

class AvanzadoModel extends StatelessWidget {
  const AvanzadoModel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return options(context);
  }

  @visibleForTesting
  Future testShowLeaveDialog(BuildContext context, AdvancedService service) =>
      _showLeaveDialog(context, service: service);

  @visibleForTesting
  Widget testOptionSelector(BuildContext context) => _optionSelector(context);
  @visibleForTesting
  Widget testPartidoContainer(BuildContext context, String title, String type,
          String duration, int totalPlayers) =>
      _partidoContainer(context, title, type, duration, totalPlayers);
}

//Opciones de vista avanzada
Widget options(BuildContext context) {
  AdvancedService advancedService = new AdvancedService();
  return FutureBuilder(
    future: advancedService.getMatch(),
    builder: (context, AsyncSnapshot<JoinedMatch> snapshot) {
      if (snapshot.hasData) {
        JoinedMatch match = snapshot.data!;

        return Column(children: [
          _partidoContainer(context, match.title!, match.type!, match.duration!,
              match.totalPlayers!),
          _optionSelector(context)
        ]);
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return const CircularProgressIndicator();
      }
    },
  );
}

//Mini resumen del partido
Widget _partidoContainer(
    context, String title, String type, String duration, int totalPlayers) {
  final ThemeData theme = Theme.of(context);
  return Container(
    height: 250.0,
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
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextModel(
                text: "Partida de $type", size: 20.0, color: Colors.white),
            TextModel(text: title, size: 15.0, color: Colors.white),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              TextModel(
                  text: "$totalPlayers jugadores",
                  size: 15.0,
                  color: Colors.white),
              Spacer(),
              TextModel(text: duration, size: 15.0, color: Colors.white),
            ]),
          ],
        ),
      ],
    ),
  );
}

//Selector de opción, (tipo de abandono)
Widget _optionSelector(context) {
  final ThemeData theme = Theme.of(context);
  return Container(
    height: 250.0,
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
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
          child: LiveButton(
              text: "Acepte por error la partida",
              onTap: () {
                _showLeaveDialog(context);
              }),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: LiveButton(
              text: "No puedo ir a la partida",
              onTap: () {
                _showLeaveDialog(context);
              }),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: LiveButton(
              text: "No quiero ir a la partida",
              onTap: () {
                _showLeaveDialog(context);
              }),
        ),
      ],
    ),
  );
}

//Dialog de abandonar partida
Future _showLeaveDialog(BuildContext context, {AdvancedService? service}) {
  final advancedService = service ?? new AdvancedService();
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Abandonaras la partida ¿estas seguro?"),
      content: Text("Abandonaras la partida ¿Estas seguro?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(
                context); // Cierra el AlertDialog al hacer clic en el botón
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            advancedService.leaveMatch();
            Navigator.pop(context);
            Navigator.pushNamed(context, '/agendaPartido');

            // Cierra el AlertDialog al hacer clic en el botón
          },
          child: Text('Aceptar'),
        ),
      ],
    ),
  );
}
