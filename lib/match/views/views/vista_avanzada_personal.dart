import 'package:flutter/material.dart';
import 'package:rol_match/match/ui/widgets/agenda/agenda_partido_model.dart';
import 'package:rol_match/match/ui/widgets/agenda/avanzado_model.dart';
import 'package:rol_match/user/ui/widgets/buttons/live_button.dart';
import 'package:rol_match/match/ui/widgets/agenda/avanzado_personal_model.dart';

//!Vista avanzada para las opciones de un partido
class VistaAvanzadaPersonal extends StatelessWidget {
  const VistaAvanzadaPersonal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Opciones Avanzadas'),
          automaticallyImplyLeading: true,
        ),
        body: Container(
            color: Colors.white,
            child: const CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                    child: Column(
                  children: [AvanzadoPersonalModel()],
                ))
              ],
            )));
  }
}
