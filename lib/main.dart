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

//! funcion Main para iniciar la aplicacion
void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();

  runApp(const MyApp());
}

//!Clase MyApp es una clase pre-identificada para obtener los Widgets de la aplicacion
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //!Se incia nuevo tema para la aplicación y se declara el tipo de tipografia
    TextTheme textTheme = createTextTheme(context, "Anton", "Anton");
    String ipServer = "192.168.1.24";
    String urlServer = "https://$ipServer:3000/auth/google";
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //?declaración de uso del tema oscuro
      theme: theme.light(),
      routes: {
        //!Rutas de vistas que inician un nuevo arbol de Widgets
        '/home': (context) => const SafeArea(child: HomePage()),
        '/agendaPartido': (context) =>
            const SafeArea(child: VistaAgendaPartido()),
        '/infoPartido': (context) =>
            const SafeArea(child: VistaHojaInformacion()),
        '/vistaAvanzada': (context) => const SafeArea(child: VistaAvanzada()),
        '/vistaAvanzadaPropio': (context) =>
            const SafeArea(child: VistaAvanzadaPersonal()),
      },
      home: Scaffold(
        body: SafeArea(child: VistaAuthWeb()),
      ),
    );
  }
}
