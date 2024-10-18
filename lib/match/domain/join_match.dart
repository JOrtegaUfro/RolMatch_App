import 'package:rol_match/match/data/services/join_service.dart';

class JoinMatch {
  void join(int id) {
    JoinService joinService = new JoinService();
    joinService.join(id);
  }
}
