import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rol_match/authentification/ui/views/vista_auth_web.dart';
import 'package:rol_match/match/domain/create/notifications_services.dart';
import 'package:rol_match/match/ui/views/agenda/vista_agenda_partido.dart';
import 'package:rol_match/user/ui/views/vista_avanzada.dart';
import 'package:rol_match/user/ui/views/vista_avanzada_personal.dart';
import 'package:rol_match/match/ui/views/agenda/vista_hoja_informacion.dart';
import 'user/ui/views/home_page.dart';
import 'config/util.dart';
import 'config/theme.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

//! funcion Main para iniciar la aplicacion
void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
  var _secureStorage = SecureStorage();

  // await _secureStorage.writeSecureData('authorization', "None");
  // await _secureStorage.writeSecureData('name', "Daniel Ruiz");
  // await _secureStorage.writeSecureData('picture',
  //     "https://media.4-paws.org/b/e/2/d/be2d88ceb9613ac5066bd11dd950faaf2671bef7/VIER%20PFOTEN_2019-03-15_001-1998x1999-600x600.jpg");
  // await _secureStorage.writeSecureData('user_sesion_id', "1");

  runApp(const MyApp());
}

//!Clase MyApp es una clase pre-identificada para obtener los Widgets de la aplicacion
class MyApp extends StatelessWidget {
  const MyApp({super.key, this.initialRoute = '/vistaAuth'});

  final String initialRoute;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    //!Se incia nuevo tema para la aplicación y se declara el tipo de tipografia
    TextTheme textTheme = createTextTheme(context, "Anton", "Anton");
    String ipServer = "192.168.1.24";
    String urlServer = "https://$ipServer:3000/auth/google";
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      //?declaración de uso del tema oscuro
      theme: theme.light(),
      initialRoute: initialRoute,
      routes: {
        //!Rutas de vistas que inician un nuevo arbol de Widgets
        '/vistaAuth': (context) => const SafeArea(child: VistaAuthWeb()),
        '/home': (context) => const SafeArea(
                child: HomePage(
              testing: false,
            )),
        '/agendaPartido': (context) =>
            const SafeArea(child: VistaAgendaPartido()),
        '/infoPartido': (context) =>
            const SafeArea(child: VistaHojaInformacion()),
        '/vistaAvanzada': (context) => const SafeArea(child: VistaAvanzada()),
        '/vistaAvanzadaPropio': (context) =>
            const SafeArea(child: VistaAvanzadaPersonal()),
      },
    );
  }
}
