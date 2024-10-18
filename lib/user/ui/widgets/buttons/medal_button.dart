import 'package:flutter/material.dart';

//Medallas
class MedalButton extends StatelessWidget {
  const MedalButton({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;
  //Se construye medalla como un botón para poder realizar acciones con este
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        width: 50,
        height: 50,
        child: TextButton(
            onPressed: onTap,
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.white)),
            child: Icon(Icons.badge)),
      ),
    );
  }
}
