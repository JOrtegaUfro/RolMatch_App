import 'package:flutter/material.dart';
import 'package:rol_match/match/ui/widgets/agenda/agenda_partido_model.dart';

//!Vista con agenda de un partido, contiene todos los aprtidos a los que se va a participar
class VistaAgendaPartido extends StatelessWidget {
  const VistaAgendaPartido({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Agenda de Partidos'),
          automaticallyImplyLeading: true,
        ),
        body: AgendaPartidoModel());
  }
}
