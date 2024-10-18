import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rol_match/match/domain/models/create_match.dart';
import 'package:rol_match/match/domain/dialogs/create_dialogs.dart';
import 'package:rol_match/match/ui/widgets/forms/inputs/slot_model.dart';
import 'package:rol_match/match/ui/widgets/forms/selectors/date_selector.dart';
import 'package:rol_match/match/ui/widgets/forms/selectors/duration_selector.dart';
import 'package:rol_match/map/ui/widgets/form_map_container.dart';
import 'package:rol_match/user/ui/widgets/buttons/live_button.dart';
import 'package:rol_match/match/ui/widgets/forms/selectors/sport_selector.dart';

//! Vista para crear el partido
class VistaCrearPartida extends StatelessWidget {
  const VistaCrearPartida({super.key});

  @override
  Widget build(BuildContext context) {
    CreateMatch createMatch = new CreateMatch();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  FormMapContainer(),
                  SizedBox(height: 20),
                  DateSelector(),
                  SizedBox(height: 20),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [SportSelector(), DurationSelector()]),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 20,
                  ),
                  Center(child: SlotModel()),
                  SizedBox(height: 40),
                  Center(
                      child: LiveButton(
                          text: "Crear",
                          onTap: () async {
                            //Se llaman funciones para crear el partido
                            createMatch.build(context);
                          })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
