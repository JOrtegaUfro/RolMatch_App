import 'package:rol_match/match/data/services/advanced_service.dart';
import 'package:rol_match/match/domain/models/player.dart';

class GetPlayers {
  //Obtiene el listado de jugadores
  Future<List<Player>> getPlayers() async {
    AdvancedService service = new AdvancedService();

    return service.getAllMatchPlayers();
  }
}
