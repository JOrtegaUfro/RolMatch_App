import 'package:flutter/material.dart';
import 'package:rol_match/match/ui/widgets/agenda/owner_partido_list.dart';

class AgendaPartidoModel extends StatelessWidget {
  const AgendaPartidoModel({super.key});
  //Se contruye vista de agenda
  @override
  Widget build(BuildContext context) {
    return partido(context);
  }

  //Se obtiene la lista de widgets de partidos del ususario
  Widget partido(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    OwnerPartidoList ownerList = new OwnerPartidoList();
    return Column(
      children: [ownerList.build(context)],
    );
  }
}
