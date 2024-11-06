import 'package:flutter_test/flutter_test.dart';
import 'package:rol_match/match/domain/models/player.dart';

void main() {
  setUp(() async {});
  testWidgets('Tests para modelo de match', (WidgetTester tester) async {
    Map<String, dynamic> playerBody = {
      "id": 1,
      "firstName": "Juan",
      "picture": "https://picsum.photos/200/300"
    };

    Player player = Player.fromJson(playerBody);

    expect(player.id, 1);
    expect(player.nombre, "Juan");
    expect(player.picture, "https://picsum.photos/200/300");
  });
}
