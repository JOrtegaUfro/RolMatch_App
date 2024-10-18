import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:rol_match/user/data/storage/secure_storage.dart';

//Servicio de ingreso de Google Oauth con backend
class LoginService {
  SecureStorage _secureStorage = new SecureStorage();

  //Esta funcion almacena tanto el authorization del usuario como la informacion de este, encriptado, en el almacenamiento interno
  void logInService(String token) async {
    String ip = dotenv.env['APP_IP']!;
    String _url = 'http://$ip/auth/google/callback';
    _secureStorage.deleteSecureData('authorization');
    //Información que se envia en el Header
    Map<String, String> headers = {
      'Authorization': '$token',
      'Content.Type': 'application/json',
    };
    print('Identificando con token $token');
    try {
      var response = await http.post(Uri.parse(_url), headers: headers);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var body = jsonDecode(response.body);
        print("HALLO HALLO ");
        var name = body["firstName"];
        var picture = body['picture'];
        var id = body['id'];
        //!Se almacena informacion del usuario
        _secureStorage.writeSecureData('authorization', token);
        _secureStorage.writeSecureData('name', name);
        _secureStorage.writeSecureData('picture', picture);
        _secureStorage.writeSecureData('user_sesion_id', id.toString());
        print('Almacenado en base de datos $id');
      } else {
        var errorBack = response.body;
        print("ERROR $errorBack");
      }
    } catch (e) {
      print(' Error login en solicitud: $e');
    }
  }
}
