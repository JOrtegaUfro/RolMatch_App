import 'package:flutter/material.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';
import 'package:rol_match/user/ui/widgets/buttons/live_button.dart';
import 'package:rol_match/match/ui/widgets/profiles/medal_table_container.dart';
import 'package:rol_match/user/domain/utils/profile_image.dart';
import 'package:rol_match/user/ui/widgets/future/name_future_builder.dart';

//! Vista de perfil
class VistaPerfil extends StatelessWidget {
  const VistaPerfil({super.key});
  //Se contruye vista de perfil
  @override
  Widget build(BuildContext context) {
    SecureStorage secureStorage = new SecureStorage();
    return Scaffold(
      //* Columna que organiza las partes de la vista perfil
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          ProfileImage(futurePicture: secureStorage.readSecureData('picture')),
          SizedBox(height: 30),
          NameFutureBuilder(future: secureStorage.readSecureData('name')),
          SizedBox(height: 30),
          Spacer(),
          LiveButton(
              text: "Ver agenda de partidos",
              onTap: () {
                Navigator.pushNamed(context, '/agendaPartido');
              }),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
