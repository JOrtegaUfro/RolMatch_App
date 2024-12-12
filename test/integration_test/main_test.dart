import 'package:convenient_test/convenient_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:convenient_test_dev/convenient_test_dev.dart';
import 'package:rol_match/main.dart';
import 'package:rol_match/main.dart' as app;
import 'package:rol_match/user/ui/views/home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

void main() {
  EditableText.debugDeterministicCursor = true;
  convenientTestMain(MyConvenientTestSlot(), () {
    late SecureStorage _secureStorage;

    setUp(() async {
      debugPrint("Secure Storage declaration");

      _secureStorage = SecureStorage();

      await dotenv.load(fileName: ".env");

      debugPrint("Configurando Secure Storage con datos de prueba");
      try {
        await _secureStorage.writeSecureData('authorization', "None");
        await _secureStorage.writeSecureData('name', "Usuario");
        await _secureStorage.writeSecureData(
            'picture', "https://picsum.photos/600/600");
        await _secureStorage.writeSecureData('user_sesion_id', "1");
      } catch (e) {
        debugPrint("Error al configurar SecureStorage: $e");
      }
    });
    tTestWidgets('test that starts from HomePage to advanced Game view',
        (t) async {
      // Verifica que estés en la vista correcta
      //await t.pumpAndSettle();
      await find.text('Buscar Partida').should(findsOneWidget);
      await t.pump(Duration(seconds: 10));
      await t.get(find.text('Perfil')).tap();

      await find.text('Usuario').should(findsOneWidget);

      await t.get(find.text('Ver agenda de partidas')).tap();
      await t.pump(Duration(seconds: 10));
      await t.get(find.text('Opciones avanzadas').first).tap();
      await find.text('14 jugadores').should(findsOneWidget);
      await find.text('60 minutos').should(findsOneWidget);
      await find.text('Eliminar la partida').should(findsOneWidget);
      await find.text('No puedo ir a la partida').should(findsOneWidget);
      await find.text('No quiero ir a la partida').should(findsOneWidget);
      await t.pageBack();
      await t.get(find.text('Hoja de información de la partida')).tap();
      await find.text('Daniel').should(findsOneWidget);
      await t.get(find.text('Partida').first).tap();
      await find.text('20').should(findsOneWidget);
      await find.text('30').should(findsOneWidget);
      await find.text('60 minutos').should(findsOneWidget);
      await t.pageBack();
      await t.pageBack();
      await t.get(find.text('Buscar Partida')).tap();
      await t.get(find.byIcon(Icons.settings_applications)).tap();
      await t.get(find.text('Juego')).tap();
      await t.get(find.text('Otro')).tap();
      await t.get(find.text('OK')).tap();
      // await t.get(find.text('Iniciar').first).tap();
    });
  });
}

class MyConvenientTestSlot extends ConvenientTestSlot {
  @override
  Future<void> appMain(AppMainExecuteMode mode) async {
    runApp(
      const ConvenientTestWrapperWidget(
        child: MyApp(initialRoute: '/home'),
      ),
    );
  }

  @override
  BuildContext? getNavContext(ConvenientTest t) =>
      MyApp.navigatorKey.currentContext;
}
