import 'package:flutter/material.dart';
import 'package:rol_match/admin/domain/hoja/get_reported_players.dart';
import 'package:rol_match/admin/domain/widgets/reported_user.dart';

import 'package:rol_match/match/domain/hoja/get_players.dart';
import 'package:rol_match/match/domain/models/player.dart';

//!Vista con jugadores
class VistaAdmin extends StatelessWidget {
  const VistaAdmin({super.key});
  //Se construye la vista de jugadores en un partido
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Usuarios reportados'),
          automaticallyImplyLeading: true,
        ),
        body: Container(
            color: Colors.white,
            child: CustomScrollView(
              slivers: <Widget>[SliverToBoxAdapter(child: reportedList())],
            )));
  }

  //Listado de jugadores en un partido
  Widget reportedList() {
    ReportedUser jugadorModel = new ReportedUser();
    GetReportedPlayers getPlayers = new GetReportedPlayers();
    return FutureBuilder(
      future: getPlayers.getPlayers(),
      builder: (context, AsyncSnapshot<List<Player>> snapshot) {
        if (snapshot.hasData) {
          List<Player> players = snapshot.data! as List<Player>;
          if (players.isEmpty) {
            return Center(
              child: Text('sin usuarios reportados'),
            );
          }
          List<Widget> playersList = [];
          players.forEach((player) {
            playersList
                .add(jugadorModel.Jugador(context, player.nombre!, player.id!));
          });
          return Column(children: playersList);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot == null) {
          return Text('sin usuarios reportados');
        } else {
          return Center(
            child: Container(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
