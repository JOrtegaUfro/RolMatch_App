import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rol_match/match/data/services/buscar_partida_service.dart';
import 'package:rol_match/match/domain/dialogs/search_dialogs.dart';
import 'package:rol_match/match/domain/maps/search_maps.dart';
import 'package:rol_match/match/domain/search/search_match.dart';
import 'package:rol_match/match/ui/widgets/maps/footer_mapa.dart';
import 'package:rol_match/user/ui/widgets/buttons/live_button.dart';

//!Vista para buscar un partido
class VistaBuscarPartida extends StatefulWidget {
  VistaBuscarPartida({super.key});

  @override
  VistaBuscarPartidaState createState() => VistaBuscarPartidaState();
}

class VistaBuscarPartidaState extends State<VistaBuscarPartida> {
  late String game;
  final BuscarPartidoService partidoService = new BuscarPartidoService();
  late Future<List<dynamic>> futureMatches = Future.value([]);

  Future<void> _loadgame() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("WAS SET 2");

    setState(() {
      game = prefs.getString('game_pref')!;
      futureMatches = partidoService.findMatchs(game);
    });
  }

  Future<void> _default() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("WAS SET 1");
    String? storedgame = prefs.getString('game_pref');
    if (storedgame == null) {
      prefs.setString('game_pref', 'Fútbol');
    } else {}
    setState(() {
      game = prefs.getString('game_pref')!;
      futureMatches = partidoService.findMatchs(game);
    });
  }

  @override
  void initState() {
    super.initState();
    _default();
  }

  //dialogs mostrara los dialogos que se muestren al usuario (popup)
  SearchDialogs dialogs = new SearchDialogs();

  /// La función `_reloadView` recupera el juego preferido del usuario de SharedPreferences y actualiza
  /// la vista en consecuencia debido al uso de setState.
  Future<void> _reloadView() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      game = prefs.getString('game_pref')!;
      print("USING $game");
      futureMatches = partidoService.findMatchs(game);
      _loadgame();
    });
  }

  //funcion que declara la ubicacion actual del usuario
  void _declareLocation(double longitud, double latitud) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('user_sesion_longitud', longitud);
    prefs.setDouble('user_sesion_latitud', latitud);
    print("COORDENADAS $latitud $longitud");
  }

  //Se construye la vista de Buscar partida
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _showMap(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              LiveButton(
                text: "Iniciar",
                onTap: () async {
                  await partidoService.getLocation().then((value) {
                    _declareLocation(value.longitude, value.latitude);
                  });
                  await _reloadView();
                  dialogs.search(context, game);

                  // _showSearchDialog(context);
                },
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: FooterMapa(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //Esta funcion se encuntra con la vista ya que debe realizarse un Future
  //Se encarga de la vista del mapa y gestiona el estado de la vista si se encuentran partidos
  Widget _showMap() {
    SearchMaps maps = new SearchMaps();
    return FutureBuilder<List<dynamic>>(
      future: futureMatches,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          SearchMatch searchMatch = new SearchMatch();
          List<Marker> marcadores =
              searchMatch.OwnerMatches(context, snapshot.data!);

          return maps.VistaMapa(context, marcadores);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return maps.VistaMapaDefault(context);
        }
      },
    );
  }
}
