import 'package:flutter/material.dart';

import 'package:rol_match/user/ui/widgets/buttons/live_button.dart';
import 'package:rol_match/authentification/ui/widgets/carousel_login.dart';

import 'package:rol_match/authentification/data/services/google_auth.dart';

//! Vista de Autentificación
class VistaAuthWeb extends StatefulWidget {
  const VistaAuthWeb({super.key});
  @override
  _VistaAuthWebState createState() => _VistaAuthWebState();
}

class _VistaAuthWebState extends State<VistaAuthWeb> {
  GoogleAuth googleAuth = new GoogleAuth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* Columna que organiza las partes de la vista carrusel
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            "ROL MATCH",
            style: TextStyle(fontSize: 50),
          ),
          Expanded(
            child: CarouselLogin(),
          ),
          LiveButton(
              text: "Ingresar",
              onTap: () {
                //Navigator.pushNamed(context, '/home');
                googleAuth.googleSignIn(context);
                //Navigator.pushNamed(context, '/authWeb');
              }),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  // void saveTestUser() {
  //   SecureStorage _secureStorage = new SecureStorage();

  //   _secureStorage.writeSecureData('authorization', token);
  //   _secureStorage.writeSecureData('name', name);
  //   _secureStorage.writeSecureData('picture', picture);
  //   _secureStorage.writeSecureData('user_sesion_id', id.toString());
  // }
}
