import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rol_match/user/domain/utils/player_image.dart';

void main() {
  setUp(() async {});

  testWidgets('Player image test, profileImage', (WidgetTester tester) async {
    PlayerImage playerImage = new PlayerImage();
    ImageProvider provider = AssetImage("assets/ic_launcher.png");
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return Container(
              child: playerImage.testableProfileImage(
                  "assets/ic_launcher.png", provider),
            );
          },
        ),
      ),
    );
    expect(find.byType(CircleAvatar), findsOneWidget);
  });

  testWidgets('Player image test, standarImage', (WidgetTester tester) async {
    PlayerImage playerImage = new PlayerImage();
    ImageProvider provider = AssetImage("assets/ic_launcher.png");
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return Container(
              child: playerImage.testableStandarImage(
                  context, "assets/ic_launcher.png", provider),
            );
          },
        ),
      ),
    );
    expect(find.byType(CircleAvatar), findsOneWidget);
  });

  testWidgets('Player image test, profileImage, excepción de ruta null',
      (WidgetTester tester) async {
    PlayerImage playerImage = new PlayerImage();
    ImageProvider provider = AssetImage("assets/ic_launcher.png");
    String voidVariable = '';
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return Container(
              child: playerImage.testableProfileImage(voidVariable, provider),
            );
          },
        ),
      ),
    );
    expect(find.byType(CircleAvatar), findsOneWidget);
  });
}
