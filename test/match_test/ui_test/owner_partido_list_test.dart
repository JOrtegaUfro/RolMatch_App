import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';
import 'package:rol_match/match/ui/widgets/agenda/owner_partido_list.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });

  testWidgets('OwnerPartidoList JoinedMatches', (WidgetTester tester) async {
    final joinedMatch = JoinedMatch();
    joinedMatch.id = 1;
    joinedMatch.title = "Fútbol 7v7 user3";
    joinedMatch.latitud = 324342.43;
    joinedMatch.longitud = 234432.54;
    joinedMatch.date = "14-06-2024";
    joinedMatch.duration = "60 minutos";
    joinedMatch.hora = "20:30";
    joinedMatch.type = "DnD";
    joinedMatch.totalSlots = 6;
    joinedMatch.totalPlayer = 14;

    List<JoinedMatch> listJoinedMatches = [joinedMatch];
    OwnerPartidoList ownerPartidoList = new OwnerPartidoList();
    //OwnerMatches ownerMatches = new OwnerMatches();
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Column(
                children: ownerPartidoList.joinedMatches(
                    context, listJoinedMatches, true),
              ),
            );
          },
        ),
      ),
    );
    expect(find.byType(Container), findsWidgets);
  });
}
