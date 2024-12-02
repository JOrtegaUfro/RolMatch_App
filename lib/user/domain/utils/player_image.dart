import 'package:flutter/material.dart';

class PlayerImage {
  //Imagen default de jugador
  Widget _standarImage(BuildContext context, String picture,
      {ImageProvider? testableImage}) {
    return CircleAvatar(
      radius: 70,
      backgroundColor: Colors.amber,
      backgroundImage: testableImage ?? NetworkImage(picture),
    );
  }

  Widget defaultImage(BuildContext context, String picture) {
    return _standarImage(context, picture);
  }

  //Imagen de perfil de jugador
  Widget _profileImage(String picture, ImageProvider? testableImage) {
    if (picture != null) {
      return CircleAvatar(
        radius: 70,
        backgroundColor: Colors.amber,
        backgroundImage: testableImage ?? NetworkImage(picture),
      );
    } else {
      return CircleAvatar(
        radius: 70,
        backgroundColor: Colors.amber,
        backgroundImage:
            testableImage ?? NetworkImage("https://picsum.photos/600/600"),
      );
    }
  }

  @visibleForTesting
  Widget testableProfileImage(String picture, ImageProvider? testableImage) =>
      _profileImage(picture, testableImage);

  @visibleForTesting
  Widget testableStandarImage(
          BuildContext context, String picture, ImageProvider? testableImage) =>
      _standarImage(context, picture, testableImage: testableImage);
}
