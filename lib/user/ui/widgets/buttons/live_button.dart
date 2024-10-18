import 'package:flutter/material.dart';

//Live Button es un botoón que realiza llamadas a backend, el uso de este permite tener una mayor legibilidad
//ya que, significa que se realizara una acción que requerira de algun servicio
class LiveButton extends StatelessWidget {
  const LiveButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(onPressed: onTap, child: Text(text)),
    );
  }
}
