import 'package:flutter/material.dart';
import 'package:rol_match/match/data/services/advanced_service.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';
import 'package:rol_match/match/ui/views/agenda/vista_info_partido.dart';
import 'package:rol_match/match/ui/views/agenda/vista_jugador.dart';

//!Vista padre que controla las vistas con la hoja de informacion del partido
class VistaHojaInformacion extends StatefulWidget {
  const VistaHojaInformacion({super.key});

  @override
  State<VistaHojaInformacion> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<VistaHojaInformacion> {
  int _selectedIndex = 0;

  //!Placeholder se debe utilizar aqui apenas inicie la vista para que se muestre
  // _userService.allPlayersService(1);
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    VistaJugador(),
    VistaInfoPartido(),
  ];

  @override
  Widget build(BuildContext context) {
    return hoja();
  }

  Widget hoja() {
    AdvancedService advanced = new AdvancedService();
    return FutureBuilder(
      future: advanced.getMatch(),
      builder: (context, AsyncSnapshot<JoinedMatch> snapshot) {
        if (snapshot.hasData) {
          JoinedMatch joined = snapshot.data! as JoinedMatch;
          return vista(joined.totalPlayers!, joined.sport!);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget vista(int totalPlayers, String sport) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [Text('$totalPlayers Jugadores'), Spacer(), Text(sport)]),
        automaticallyImplyLeading: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Jugadores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_football),
            label: 'Partido',
          ),
        ],
      ),
    );
  }
}
