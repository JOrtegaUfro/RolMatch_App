import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

//Servicio para unirse a Partido
class JoinService {
  String _ip = dotenv.env['APP_IP']!;
  void join(int id) async {
    SecureStorage secure = new SecureStorage();
    String userId = await secure.readSecureDataId();
    //!Cambiar a id de usuario
    String _url = 'http://$_ip/matches/$id/join/$userId';
    var dio = Dio();
    //!Sin autorizacion por token
    Map<String, String> headers = {
      'Content.Type': 'application/json',
    };

    var response = await dio.post(
      _url,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );
    print("POST POST");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("SE HA UNIDO CORRECTAMENTE");
    } else {
      var error = response.data;
      print("ERROR DE SOLICITUD $error");
    }
  }
}
