import 'package:rol_match/match/data/services/join_service.dart';

class JoinMatch {
  final JoinService joinService;
  JoinMatch({JoinService? joinService})
      : joinService = joinService ?? JoinService();

  void join(int id) {
    joinService.join(id);
  }
}
