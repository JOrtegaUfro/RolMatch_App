import 'package:flutter/material.dart';
import 'package:rol_match/user/ui/widgets/buttons/live_button.dart';

class AdminButton extends StatelessWidget {
  final Future<String> future;

  AdminButton({required this.future});
  //Se construye nombre
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: future, // El Future
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Mostrar un indicador de carga
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}'); // Mostrar el error
        } else if (!snapshot.hasData) {
          return Text('No hay datos disponibles'); //No disponible
        } else if (snapshot.data! == "user") {
          return SizedBox(
            height: 0,
          );
        } else if (snapshot.data! == "admin") {
          return LiveButton(
              text: "Administrar usuarios",
              onTap: () {
                Navigator.pushNamed(context, '/adminHome');
              });
        } else {
          return SizedBox(
            height: 0,
          );
        }
      },
    );
  }
}
