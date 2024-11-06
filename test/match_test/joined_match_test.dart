import 'package:flutter_test/flutter_test.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';

void main() {
  setUp(() async {});
  testWidgets('Tests para modelo de joinedMatch', (WidgetTester tester) async {
    Map<String, dynamic> match = {
      "id": 1,
      "title": "Fútbol 7v7 user3",
      "description": "Partido de fútbol 7v7",
      "duration": "60 minutos",
      "date": "14-06-2024",
      "hour": "20:30",
      "latitude": 324342.43,
      "longitude": 234432.54,
      "playerSlots": 6,
      "totalPlayers": 14,
      "type": "Tipo 1",
      "createdAt": "2024-11-04T16:25:41.168Z"
    };

    JoinedMatch joinedMatch = JoinedMatch.fromJson(match);

    expect(joinedMatch.id, 1);
    expect(joinedMatch.title, "Fútbol 7v7 user3");
    expect(joinedMatch.latitud, 324342.43);
    expect(joinedMatch.longitud, 234432.54);
    expect(joinedMatch.date, "14-06-2024");
    expect(joinedMatch.duration, "60 minutos");
    expect(joinedMatch.hora, "20:30");
    expect(joinedMatch.type, "Tipo 1");
    expect(joinedMatch.totalSlots, 6);
    expect(joinedMatch.totalPlayers, 14);
  });
}
