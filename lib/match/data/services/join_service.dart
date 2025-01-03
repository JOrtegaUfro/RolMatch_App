import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';

//Servicio para unirse a Partido
class JoinService {
  final Dio dio;
  final SecureStorage? secureStorage;
  String _ip = dotenv.env['APP_IP']!;
  JoinService({Dio? dio, this.secureStorage}) : dio = dio ?? Dio();
  Future<bool> join(int id) async {
    final secure = secureStorage ?? SecureStorage();
    String userId = await secure.readSecureDataId();
    //!Cambiar a id de usuario
    String _url = 'http://$_ip/games/$id/join/$userId';

    //!Sin autorizacion por token

    var response = await dio.post(
      _url,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );
    print("POST POST");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("SE HA UNIDO CORRECTAMENTE");
      return true;
    } else {
      var error = response.data;
      print("ERROR DE SOLICITUD $error");
      return false;
    }
  }
}
