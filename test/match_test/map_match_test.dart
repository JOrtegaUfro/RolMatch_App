import 'package:flutter_test/flutter_test.dart';
import 'package:rol_match/match/domain/models/map_match.dart';

void main() {
  setUp(() async {});
  testWidgets('Tests para modelo de mapMatch', (WidgetTester tester) async {
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

    MapMatch mapMatch = MapMatch.fromJson(match);

    expect(mapMatch.id, 1);
    expect(mapMatch.description, "Partido de fútbol 7v7");
    expect(mapMatch.latitud, 324342.43);
    expect(mapMatch.longitud, 234432.54);
    expect(mapMatch.date, "14-06-2024");
    expect(mapMatch.duration, "60 minutos");
    expect(mapMatch.hora, "20:30");
    expect(mapMatch.type, "Tipo 1");
    expect(mapMatch.totalSlots, 6);
    expect(mapMatch.totalPlayers, 14);
  });
}
