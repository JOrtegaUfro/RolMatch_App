import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rol_match/user/domain/utils/player_image.dart';
import 'package:rol_match/user/ui/views/user_model.dart';

import '../mock/player_image_init.mocks.dart';

void main() {
  setUpAll(() {});

  testWidgets('UserModel test', (WidgetTester tester) async {
    PlayerImage playerImage = new MockPlayerImage();
    UserModel userModel = new UserModel();
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        home: Builder(
          builder: (BuildContext context) {
            when(playerImage.defaultImage(context, "none"))
                .thenAnswer((_) => Container());
            return Container(
                child: userModel.testPlayerModel(
                    context, 1, "none", "test", playerImage));
          },
        ),
      ),
    );

    expect(find.text('test'), findsOneWidget);
  });
}
