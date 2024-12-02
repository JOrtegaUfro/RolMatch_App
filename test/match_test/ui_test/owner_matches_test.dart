import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';
import 'package:rol_match/match/ui/widgets/agenda/scroll/owner_matches.dart';

void main() {
  setUpAll(() {});

  testWidgets('OwnerPartidoList JoinedMatches', (WidgetTester tester) async {
    final joinedMatch = JoinedMatch();
    joinedMatch.id = 1;
    joinedMatch.title = "Fútbol 7v7 user3";
    joinedMatch.latitud = 324342.43;
    joinedMatch.longitud = 234432.54;
    joinedMatch.date = "14-06-2024";
    joinedMatch.duration = "60 minutos";
    joinedMatch.hora = "20:30";
    joinedMatch.type = "Tipo 1";
    joinedMatch.totalSlots = 6;
    joinedMatch.totalPlayer = 14;
    OwnerMatches ownerMatches = new OwnerMatches();
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: ownerMatches.testableMatchMaker(
                  context,
                  joinedMatch.title!,
                  joinedMatch.hora!,
                  joinedMatch.duration!,
                  "14",
                  joinedMatch.id!,
                  joinedMatch.latitud!,
                  joinedMatch.longitud!,
                  testableContainer: Container()),
            );
          },
        ),
      ),
    );
    expect(find.text("Fútbol 7v7 user3"), findsWidgets);
  });
}
