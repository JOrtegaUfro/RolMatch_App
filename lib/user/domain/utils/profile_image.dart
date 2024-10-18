import 'package:flutter/material.dart';

//!Widget con la imagen de perfil del usuario

class ProfileImage extends StatelessWidget {
  final Future<String> futurePicture;

  const ProfileImage({super.key, required this.futurePicture});
  //Se contruye imagen de perfil
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: FutureBuilder<String>(
        future: futurePicture,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return defaultImage(context);
          } else {
            return CircleAvatar(
              radius: 70,
              backgroundColor: Colors.amber,
              backgroundImage: NetworkImage(snapshot.data!),
            );
          }
        },
      ),
    );
  }

  //Imagen default de udsuario
  Widget defaultImage(BuildContext context) {
    return const CircleAvatar(
      radius: 70,
      backgroundColor: Colors.amber,
      backgroundImage: NetworkImage(
          "https://media.4-paws.org/b/e/2/d/be2d88ceb9613ac5066bd11dd950faaf2671bef7/VIER%20PFOTEN_2019-03-15_001-1998x1999-600x600.jpg"),
    );
  }
}
