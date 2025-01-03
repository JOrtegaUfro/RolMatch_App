import 'package:rol_match/admin/data/services/advanced_report_service.dart';

import 'package:rol_match/match/domain/models/player.dart';

class GetReportedPlayers {
  //Obtiene el listado de jugadores
  Future<List<Player>> getPlayers() async {
    AdvancedReportService service = new AdvancedReportService();

    return service.getAllReportedPlayers();
  }
}
