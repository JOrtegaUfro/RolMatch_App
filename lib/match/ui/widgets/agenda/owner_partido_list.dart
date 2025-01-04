import 'package:flutter/material.dart';
import 'package:rol_match/match/data/services/agenda_partido_service.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';
import 'package:rol_match/match/domain/models/owner_match.dart';
import 'package:rol_match/match/ui/widgets/agenda/scroll/owner_matches.dart';

class OwnerPartidoList {
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(child: _showCards()),
        ],
      ),
    );
  }

  Widget _showCards() {
    return FutureBuilder(
      future: Agenda(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          List<Widget> matches = snapshot.data! as List<Widget>;

          return Column(
            children: matches,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<Widget>> Agenda() async {
    List<Widget> agenda = [_showCardsA(), _showCardsB()];
    return agenda;
  }

  Widget _showCardsA() {
    return FutureBuilder(
      future: getMatches(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          List<Widget> products = OwnerMatchesList(context, snapshot.data!);

          return Column(
            children: products,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _showCardsB() {
    return FutureBuilder(
      future: getJoinedMatches(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          List<Widget> products =
              _joinedMatches(context, snapshot.data!, false);

          return Column(
            children: products,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<OwnerMatch>> getMatches() async {
    AgendaPartidoService agendaService = AgendaPartidoService();
    List<OwnerMatch> matches = await agendaService.listAgenda();
    return matches;
  }

  Future<List<JoinedMatch>> getJoinedMatches() async {
    AgendaPartidoService agendaService = AgendaPartidoService();
    List<JoinedMatch> matches = await agendaService.listAgendaJoined();
    return matches;
  }

  List<Widget> OwnerMatchesList(BuildContext context, List<dynamic> matches) {
    List<Widget> results = [];
    OwnerMatches owner = new OwnerMatches();
    matches.forEach((match) {
      String type = match.type;
      String typeMatch = "partido de $type";
      final tempMatch = owner.match(
          context,
          typeMatch,
          match.hora,
          match.duration,
          match.totalPlayers.toString(),
          match.id,
          match.latitud,
          match.longitud);
      results.add(tempMatch);
    });

    return results;
  }

  List<Widget> _joinedMatches(
      BuildContext context, List<dynamic> matches, bool test) {
    List<Widget> results = [];
    OwnerMatches owner = new OwnerMatches();
    matches.forEach((match) {
      String type = match.type;
      String typeMatch = "partido de $type";
      final tempMatch = owner.joinedMatch(
          context,
          typeMatch,
          match.hora,
          match.duration,
          match.totalPlayers.toString(),
          match.id,
          match.title,
          match.latitud,
          match.longitud,
          test);
      results.add(tempMatch);
    });

    return results;
  }

  @visibleForTesting
  List<Widget> joinedMatches(
          BuildContext context, List<dynamic> matches, bool test) =>
      _joinedMatches(context, matches, test);
}
