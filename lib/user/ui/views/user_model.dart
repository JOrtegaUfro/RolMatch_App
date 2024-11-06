import 'package:flutter/material.dart';
import 'package:rol_match/match/domain/models/player.dart';

import 'package:rol_match/user/data/player_service.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';
import 'package:rol_match/user/domain/utils/player_image.dart';
import 'package:rol_match/user/ui/widgets/buttons/live_button.dart';
import 'package:rol_match/user/domain/utils/profile_image.dart';

//! Vista de perfil de usuario (jugador del partido)
class UserModel {
  Widget build(BuildContext context, int userId) {
    SecureStorage secureStorage = new SecureStorage();
    PlayerService playerService = new PlayerService();
    return FutureBuilder(
      future: playerService.getPlayer(userId),
      builder: (context, AsyncSnapshot<Player> snapshot) {
        if (snapshot.hasData) {
          Player player = snapshot.data! as Player;

          return playerModel(
              context, player.id!, player.picture!, player.nombre!);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  //Modelo de jugador de partido
  Widget playerModel(
      BuildContext context, int id, String picture, String firstName) {
    PlayerImage playerImage = new PlayerImage();
    return Scaffold(
      appBar: AppBar(
        title: Text('Jugador del partido'),
        automaticallyImplyLeading: true,
      ),
      //* Columna que organiza las partes de la vista perfil
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          height: 30,
        ),
        playerImage.defaultImage(context, picture),
        SizedBox(height: 30),
        Text(
          firstName,
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(height: 30),
        Spacer()
      ]),
    );
  }
}
