import 'package:flutter/material.dart';
import 'package:rol_match/match/data/services/advanced_service.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';
import 'package:rol_match/match/ui/widgets/agenda/partido_model.dart';

//!Vista de infromaciond del partido
class VistaInfoPartido extends StatelessWidget {
  const VistaInfoPartido({super.key});
  //Se contruye vista de partido en hoja de infromación
  @override
  Widget build(BuildContext context) {
    // PartidoModel partidoContainer = new PartidoModel();
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: CustomScrollView(
              slivers: <Widget>[SliverToBoxAdapter(child: buildPartido())],
            )));
  }

  //Constucción asinconica de Partido
  Widget buildPartido() {
    AdvancedService advanced = new AdvancedService();
    PartidoModel partidoModel = new PartidoModel();
    return FutureBuilder(
      future: advanced.getMatch(),
      builder: (context, AsyncSnapshot<JoinedMatch> snapshot) {
        if (snapshot.hasData) {
          JoinedMatch joined = snapshot.data! as JoinedMatch;

          return partidoModel.partidoContainer(
              context,
              joined.title!,
              joined.hora!,
              joined.duration!,
              joined.latitud!,
              joined.longitud!);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
