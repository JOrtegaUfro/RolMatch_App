import 'package:flutter/material.dart';

import 'package:rol_match/match/domain/hoja/get_players.dart';
import 'package:rol_match/match/domain/models/player.dart';

import 'package:rol_match/match/ui/widgets/agenda/players/jugador_model.dart';

//!Vista con jugadores
class VistaJugador extends StatelessWidget {
  const VistaJugador({super.key});
  //Se construye la vista de jugadores en un partido
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            child: CustomScrollView(
              slivers: <Widget>[SliverToBoxAdapter(child: playerList())],
            )));
  }

  //Listado de jugadores en un partido
  Widget playerList() {
    JugadorModel jugadorModel = new JugadorModel();
    GetPlayers getPlayers = new GetPlayers();
    return FutureBuilder(
      future: getPlayers.getPlayers(),
      builder: (context, AsyncSnapshot<List<Player>> snapshot) {
        if (snapshot.hasData) {
          List<Player> players = snapshot.data! as List<Player>;
          List<Widget> playersList = [];
          players.forEach((player) {
            playersList
                .add(jugadorModel.Jugador(context, player.nombre!, player.id!));
          });
          return Column(children: playersList);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
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
