import 'package:flutter_test/flutter_test.dart';
import 'package:rol_match/match/domain/models/owner_match.dart';

void main() {
  setUp(() async {});
  testWidgets('Tests para modelo de ownerMatch', (WidgetTester tester) async {
    Map<String, dynamic> ownerMatchBody = {
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

    OwnerMatch ownerMatch = OwnerMatch.fromJson(ownerMatchBody);

    expect(ownerMatch.latitud, 324342.43);
    expect(ownerMatch.longitud, 234432.54);
    expect(ownerMatch.date, "14-06-2024");
    expect(ownerMatch.duration, "60 minutos");
    expect(ownerMatch.hora, "20:30");
    expect(ownerMatch.type, "Tipo 1");
    expect(ownerMatch.totalSlots, 6);
    expect(ownerMatch.totalPlayers, 14);
  });

  testWidgets('Tests para modelo de ownerMatch, setters',
      (WidgetTester tester) async {
    final ownerMatch = OwnerMatch();
    ownerMatch.id = 1;
    ownerMatch.latitud = 324342.43;
    ownerMatch.longitud = 234432.54;
    ownerMatch.date = "14-06-2024";
    ownerMatch.duration = "60 minutos";
    ownerMatch.hora = "20:30";
    ownerMatch.type = "Tipo 1";
    ownerMatch.totalSlots = 6;
    ownerMatch.totalPlayer = 14;

    expect(ownerMatch.id, 1);
    expect(ownerMatch.latitud, 324342.43);
    expect(ownerMatch.longitud, 234432.54);
    expect(ownerMatch.date, "14-06-2024");
    expect(ownerMatch.duration, "60 minutos");
    expect(ownerMatch.hora, "20:30");
    expect(ownerMatch.type, "Tipo 1");
    expect(ownerMatch.totalSlots, 6);
    expect(ownerMatch.totalPlayers, 14);
  });
}
