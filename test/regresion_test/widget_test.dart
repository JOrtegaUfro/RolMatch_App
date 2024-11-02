// Este es un Test para identificar los Widget de autentificación

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rol_match/user/ui/views/home_page.dart';
import 'package:rol_match/user/ui/views/profile/vista_perfil.dart';

void main() {
  setUp(() async {
    debugPrint("Enviorment declaration");

    await dotenv.load(fileName: ".env");
  });
  testWidgets('Second screen is homepage screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(
          testing: true,
        ),
      ),
    );
    await tester.runAsync(() async {
      try {
        expect(find.byKey(const ValueKey('Profile')), findsOneWidget);
        final profile = find.byKey(const ValueKey('Profile'));
      } catch (e) {
        debugPrint("ERROR HERE");
        debugPrint(e.toString());
      }
      debugPrint("Tapping 'Perfil' button");

      debugPrint("Wait");
      await tester.pump(Duration(seconds: 5));
      debugPrint("Test data perfil");
      expect(find.byType(VistaPerfil), findsNothing);
    });
  });
}
