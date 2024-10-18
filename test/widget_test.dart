// Este es un Test para identificar los Widget de autentificación

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rol_match/authentification/ui/views/vista_auth_web.dart';
import 'package:rol_match/main.dart';

import 'package:rol_match/user/domain/utils/profile_image.dart';
import 'package:rol_match/user/ui/views/home_page.dart';
import 'package:rol_match/user/ui/views/profile/vista_perfil.dart';

void main() {
  testWidgets('Initial screen is authentication screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.runAsync(() async {
      expect(find.byType(VistaAuthWeb), findsOneWidget);
      expect(find.text('ROL MATCH'), findsOneWidget);
      expect(find.text('Ingresar'), findsOneWidget);
      // Realizar el clic en el botón de ingreso

      try {
        await tester.tap(find.text('Ingresar'));
        await tester.pumpAndSettle();
        await tester.pump(Duration(seconds: 10));
      } catch (e) {
        debugPrint("ERROR HERE");
        debugPrint(e.toString());
      }

      expect(find.byKey(const ValueKey('Profile')), findsOneWidget);
      final profile = find.byKey(const ValueKey('Profile'));
      print("Tapping 'Ingresar' button");
      await tester.tap(profile);
      print("Loading");
      //!Por probar con integración
      //await tester.pumpAndSettle();
      print("Wait");
      await tester.pump(Duration(seconds: 5));
      print("tree");
      expect(find.byType(VistaPerfil), findsNothing);
    });
  });

  testWidgets('Second screen is homepage screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(),
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


// final perfilWidget = tester.widget<VistaPerfil>(find.byType(VistaPerfil));
      // debugPrint(perfilWidget.toString());

      //expect(find.text('Dato no encontrado'), findsOneWidget);
      // expect(find.byType(SafeArea), findsOneWidget);
      // final safeAreaWidget = tester.widget<SafeArea>(find.byType(SafeArea));
      // debugPrint(safeAreaWidget.toString());
      // final childWidget = safeAreaWidget.child;

      // // Imprimir información sobre el child
      // debugPrint('Child of SafeArea: ${childWidget.toString()}');
      // final auth = tester.widget<VistaAuthWeb>(find.byType(VistaAuthWeb));
      // debugPrint(auth.toString());