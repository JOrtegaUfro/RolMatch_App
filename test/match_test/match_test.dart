import 'package:flutter_test/flutter_test.dart';
import 'package:rol_match/match/domain/models/match.dart';

void main() {
  setUp(() async {});
  testWidgets('Tests para modelo de match', (WidgetTester tester) async {
    Map<String, dynamic> matchBody = {
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

    Match match = Match.fromJson(matchBody);

    expect(match.latitud, 324342.43);
    expect(match.longitud, 234432.54);
    expect(match.date, "14-06-2024");
    expect(match.duration, "60 minutos");
    expect(match.hora, "20:30");
    expect(match.type, "Tipo 1");
    expect(match.totalSlots, 6);
    expect(match.totalPlayers, 14);

    Match matchToJson = Match(
        latitud: 304342.43,
        longitud: 274432.54,
        date: "18-06-2024",
        duration: "30 minutos",
        hora: "22:30",
        type: "Tipo 2",
        totalSlots: 5,
        totalPlayers: 20);

    Map<String, dynamic> matchJson = matchToJson.toJson();

    expect(matchJson['latitude']?.toDouble(), 304342.43);
    expect(matchJson['longitude']?.toDouble(), 274432.54);
    expect(matchJson['date'], "18-06-2024");
    expect(matchJson['duration'], "30 minutos");
    expect(matchJson['hour'], "22:30");
    expect(matchJson['type'], "Tipo 2");
    expect(matchJson['playerSlots'], 5);
    expect(matchJson['totalPlayers'], 20);
  });

  testWidgets('Tests para modelo de match, setters',
      (WidgetTester tester) async {
    final match = Match();
    match.latitud = 324342.43;
    match.longitud = 234432.54;
    match.date = "14-06-2024";
    match.duration = "60 minutos";
    match.hora = "20:30";
    match.type = "Tipo 1";
    match.totalSlots = 6;
    match.totalPlayer = 14;

    expect(match.latitud, 324342.43);
    expect(match.longitud, 234432.54);
    expect(match.date, "14-06-2024");
    expect(match.duration, "60 minutos");
    expect(match.hora, "20:30");
    expect(match.type, "Tipo 1");
    expect(match.totalSlots, 6);
    expect(match.totalPlayers, 14);
  });
}
