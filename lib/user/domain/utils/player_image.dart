import 'package:flutter/material.dart';

class PlayerImage {
  //Imagen default de jugador
  Widget defaultImage(BuildContext context, String picture) {
    return CircleAvatar(
      radius: 70,
      backgroundColor: Colors.amber,
      backgroundImage: NetworkImage(picture),
    );
  }

  //Imagen de perfil de jugador
  Widget profileImage(String picture) {
    if (picture != null) {
      return CircleAvatar(
        radius: 70,
        backgroundColor: Colors.amber,
        backgroundImage: NetworkImage(picture),
      );
    } else {
      return CircleAvatar(
        radius: 70,
        backgroundColor: Colors.amber,
        backgroundImage: NetworkImage(
            "https://media.4-paws.org/b/e/2/d/be2d88ceb9613ac5066bd11dd950faaf2671bef7/VIER%20PFOTEN_2019-03-15_001-1998x1999-600x600.jpg"),
      );
    }
  }
}
