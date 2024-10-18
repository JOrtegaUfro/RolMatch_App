import 'package:flutter/material.dart';
import 'package:rol_match/match/ui/widgets/agenda/avanzado_model.dart';

//!Vista avanzada para las opciones de un partido
class VistaAvanzada extends StatelessWidget {
  const VistaAvanzada({super.key});
  //Construcción de vista avanzada
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
                  children: [AvanzadoModel()],
                ))
              ],
            )));
  }
}
