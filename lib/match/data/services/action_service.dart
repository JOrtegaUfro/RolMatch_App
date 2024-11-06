import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ActionService {
  final Dio dio;
  String _ip = dotenv.env['APP_IP']!;
  ActionService({Dio? dio}) : dio = dio ?? Dio();
  void reportUser(int id) async {
    String _url = 'http://$_ip/users/report/$id';

    Map<String, String> headers = {
      'Content.Type': 'application/json',
    };

    var response = await dio.patch(
      _url,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );
    print("POST POST");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("REPORTADO CORRECTAMENTE");
    } else {
      var error = response.data;
      print("ERROR DE SOLICITUD $error");
    }
  }
}
