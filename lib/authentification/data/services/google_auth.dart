import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:rol_match/authentification/data/services/login_service.dart';

//Google Oauth se encarga de ocnseguir el Authorization (Access token) de un correo
class GoogleAuth {
  LoginService loginService = new LoginService();
  //Esta funcion utiliza Google Sign in para autorizar a un usuario con Google OAuth y obtener su accestoken
  void googleSignIn(context) async {
    // Google Sign in
    print("----------------");
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
      ],
    );

    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      //autentificación y obtencion de accesstoken
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      String? accessToken = googleAuth.accessToken;

      //uso de servicio de Log in
      loginService.logInService(accessToken!);
    }
    //redireccionamiento si esta autorizado

    Navigator.pushNamed(context, '/home');
  }
}
