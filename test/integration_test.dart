import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rol_match/match/ui/views/create/vista_crear_partida.dart';
import 'package:rol_match/match/ui/widgets/forms/selectors/duration_selector.dart';
import 'package:rol_match/match/ui/widgets/forms/selectors/game_selector.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';
import 'package:rol_match/user/domain/utils/profile_image.dart';
import 'package:rol_match/user/ui/views/home_page.dart';
import 'package:rol_match/user/ui/widgets/future/name_future_builder.dart';

void main() {
  late SecureStorage _secureStorage;

  setUp(() async {
    debugPrint("Secure Storage declaration");

    _secureStorage = SecureStorage();

    await dotenv.load(fileName: ".env");

    debugPrint("Configurando Secure Storage con datos de prueba");
    try {
      await _secureStorage.writeSecureData('authorization', "None");
      await _secureStorage.writeSecureData('name', "Usuario");
      await _secureStorage.writeSecureData('picture',
          "https://media.4-paws.org/b/e/2/d/be2d88ceb9613ac5066bd11dd950faaf2671bef7/VIER%20PFOTEN_2019-03-15_001-1998x1999-600x600.jpg");
      await _secureStorage.writeSecureData('user_sesion_id', "1");
    } catch (e) {
      debugPrint("Error al configurar SecureStorage: $e");
    }
  });

  testWidgets('From homepage screen to Profile Screen ',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(
          testing: true,
        ),
      ),
    );

    debugPrint("Tapping 'Perfil' button");
    try {
      expect(find.byKey(const ValueKey('Profile')), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('Profile')));
    } catch (e) {
      debugPrint("ERROR HERE");
      debugPrint(e.toString());
    }
    debugPrint("Wait");
    await tester.pump(Duration(seconds: 5));

    debugPrint("After");

    await tester.pump(Duration(seconds: 5));

    //Se comprueba que efectivamente se este renderizando la Vista de Perfil,
    //en caso de no tener datos de usuario no se renderiza y por lo tanto falla

    expect(find.byType(ProfileImage), findsOneWidget);
    expect(find.byType(NameFutureBuilder), findsOneWidget);
  });

  testWidgets('From homepage screen to Create Game Screen ',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(
          testing: true,
        ),
      ),
    );

    debugPrint("Tapping 'Perfil' button");
    try {
      expect(find.byKey(const ValueKey('CreateGame')), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('CreateGame')));
    } catch (e) {
      debugPrint("ERROR HERE");
      debugPrint(e.toString());
    }
    debugPrint("Wait");
    await tester.pump(Duration(seconds: 5));

    debugPrint("After");

    await tester.pump(Duration(seconds: 5));

    //Se comprueba que efectivamente se este renderizando la Vista de Crear partida,
    //en caso de no tener datos de usuario no se renderiza y por lo tanto falla
    expect(find.byType(VistaCrearPartida), findsOneWidget);
    debugPrint("After");

    await tester.pump(Duration(seconds: 5));
    expect(find.byType(GameSelector), findsOneWidget);
    expect(find.byType(DurationSelector), findsOneWidget);
  });
}
