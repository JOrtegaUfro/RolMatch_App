import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../match/ui/views/create/vista_crear_partida.dart';
import 'profile/vista_perfil.dart';
import '../../../match/ui/views/search/vista_buscar_partida.dart';

//!Vista donde se recibe al usuario inicialmente
class HomePage extends StatefulWidget {
  const HomePage({super.key, this.storage});

  final FlutterSecureStorage? storage;

  @override
  State<HomePage> createState() {
    return _HomePageState(storage);
  }
}

class _HomePageState extends State<HomePage> {
  _HomePageState(FlutterSecureStorage? storage);

  final List<Widget> _pages = [
    VistaBuscarPartida(),
    VistaCrearPartida(),
    VistaPerfil(),
  ];

  // VistaBuscarPartida(),
  //   ,
  //
  //HomePage se gestiona el cambio entre vistas
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _pages.length,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Sport Time'),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    key: const ValueKey('SearchGame'),
                    icon: Icon(Icons.search),
                    text: 'Buscar Partida',
                  ),
                  Tab(
                    key: const ValueKey('CreateGame'),
                    icon: Icon(Icons.sports),
                    text: 'Crear Partida',
                  ),
                  Tab(
                    key: const ValueKey('Profile'),
                    icon: Icon(Icons.person),
                    text: 'Perfil',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: _pages,
            )),
      ),
    );
  }
}
