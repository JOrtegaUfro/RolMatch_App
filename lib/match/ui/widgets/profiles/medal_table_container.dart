import 'package:flutter/material.dart';
import 'package:rol_match/user/data/profile_service.dart';
import 'package:rol_match/user/domain/models/medal.dart';
import 'package:rol_match/user/ui/widgets/buttons/medal_button.dart';

class MedalTableContainer extends StatelessWidget {
  const MedalTableContainer({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileService medals = new ProfileService();
    medals.getMedals();
    return medalBoard();
  }
}

Widget medalBoard() {
  ProfileService profileService = new ProfileService();
  return FutureBuilder(
    future: profileService.getMedals(),
    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
      if (snapshot.hasData) {
        List<Medal> medals = snapshot.data! as List<Medal>;
        List<Widget> medalsWidget = [];
        medals.forEach((medal) {
          Widget medalWidget = MedalButton(
            onTap: () {
              _showMedalDialog(context, medal.description!, medal.level!);
            },
          );
          medalsWidget.add(medalWidget);
        });

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: medalsWidget,
        );
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        return const CircularProgressIndicator();
      }
    },
  );
}

Future _showMedalDialog(BuildContext context, String title, int level) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text("Esta es una medalla de nivel $level"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(
                context); // Cierra el AlertDialog al hacer clic en el botón
          },
          child: Text('Cerrar'),
        ),
      ],
    ),
  );
}
