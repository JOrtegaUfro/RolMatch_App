import 'package:dio/dio.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';

import 'package:rol_match/match/data/services/agenda_partido_service.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';

import 'package:rol_match/match/domain/models/owner_match.dart';

import '../../secure_storage_init_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Dio dio;
  late DioAdapter dioAdapter;
  late AgendaPartidoService agendaPartidoService;
  setUp(() async {
    await dotenv.load(fileName: ".env");
  });

  test(
      'Utiliza agendPartidoService listAgenda(), y solo se llama una vez al backend, ademas de no presentar un error al recibir respuesta 200 y retornar la lista de OwnerMatch',
      () async {
    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);
    var mockSecureStorage = MockSecureStorage();
    agendaPartidoService =
        AgendaPartidoService(dio: dio, secureStorage: mockSecureStorage);
    const path = 'http://10.0.2.2:3000/games/user/1';
    Future<String> mockId() async {
      return "1";
    }

    when(mockSecureStorage.readSecureDataId()).thenAnswer((_) => mockId());

    dioAdapter.onGet(path, (server) {
      //debugPrint("Solicitud GET interceptada: ${server.toString()}");
      final matchList = [
        {
          "id": 1,
          "title": "Fútbol 7v7 user3",
          "description": "Partido de fútbol 7v7",
          "duration": "60 minutos",
          "date": "14-06-2024",
          "hour": "20:30",
          "latitude": 324342.43,
          "longitude": 234432.54,
          "playerSlots": 6,
          "totalPlayers": 14,
          "type": "Tipo 1",
          "createdAt": "2024-11-04T16:25:41.168Z"
        },
        {
          "id": 1,
          "title": "Fútbol 7v7 user3",
          "description": "Partido de fútbol 7v7",
          "duration": "60 minutos",
          "date": "14-06-2024",
          "hour": "20:30",
          "latitude": 324342.43,
          "longitude": 234432.54,
          "playerSlots": 6,
          "totalPlayers": 14,
          "type": "Tipo 1",
          "createdAt": "2024-11-04T16:25:41.168Z"
        }
      ];
      server.reply(200, matchList);
    });

    List<OwnerMatch> ownerMatch = await agendaPartidoService.listAgenda();
    expect(ownerMatch[0].latitud, 324342.43);
    expect(ownerMatch[0].longitud, 234432.54);
    expect(ownerMatch[0].date, "14-06-2024");
    expect(ownerMatch[0].duration, "60 minutos");
    expect(ownerMatch[0].hora, "20:30");
    expect(ownerMatch[0].type, "Tipo 1");
    expect(ownerMatch[0].totalSlots, 6);
    expect(ownerMatch[0].totalPlayers, 14);
  });

  test(
      'Utiliza agendPartidoService listAgenda(), y solo se llama una vez al backend, ademas de presentar un error al recibir respuesta 299 y retornar una excepción',
      () async {
    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);
    var mockSecureStorage = MockSecureStorage();
    agendaPartidoService =
        AgendaPartidoService(dio: dio, secureStorage: mockSecureStorage);
    const path = 'http://10.0.2.2:3000/games/user/1';
    Future<String> mockId() async {
      return "1";
    }

    when(mockSecureStorage.readSecureDataId()).thenAnswer((_) => mockId());

    dioAdapter.onGet(path, (server) {
      server.reply(299, null);
    });

    expect(
      () async => await agendaPartidoService.listAgenda(),
      throwsA(isA<Exception>().having((e) => e.toString(), 'message',
          contains('ERRROR Fallo carga de partidos'))),
    );
  });

  test(
      'Utiliza agendPartidoService listAgendaJoined(), y solo se llama una vez al backend, ademas de no presentar un error al recibir respuesta 200 y retornar la lista de JoinedMatch',
      () async {
    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);
    var mockSecureStorage = MockSecureStorage();
    agendaPartidoService =
        AgendaPartidoService(dio: dio, secureStorage: mockSecureStorage);
    const path = 'http://10.0.2.2:3000/games/joined/1';
    Future<String> mockId() async {
      return "1";
    }

    when(mockSecureStorage.readSecureDataId()).thenAnswer((_) => mockId());

    dioAdapter.onGet(path, (server) {
      //debugPrint("Solicitud GET interceptada: ${server.toString()}");
      final matchList = [
        {
          "id": 1,
          "title": "Fútbol 7v7 user3",
          "description": "Partido de fútbol 7v7",
          "duration": "60 minutos",
          "date": "14-06-2024",
          "hour": "20:30",
          "latitude": 324342.43,
          "longitude": 234432.54,
          "playerSlots": 6,
          "totalPlayers": 14,
          "type": "Tipo 1",
          "createdAt": "2024-11-04T16:25:41.168Z"
        },
        {
          "id": 1,
          "title": "Fútbol 7v7 user3",
          "description": "Partido de fútbol 7v7",
          "duration": "60 minutos",
          "date": "14-06-2024",
          "hour": "20:30",
          "latitude": 324342.43,
          "longitude": 234432.54,
          "playerSlots": 6,
          "totalPlayers": 14,
          "type": "Tipo 1",
          "createdAt": "2024-11-04T16:25:41.168Z"
        }
      ];
      server.reply(200, matchList);
    });

    List<JoinedMatch> ownerMatch =
        await agendaPartidoService.listAgendaJoined();
    expect(ownerMatch[0].latitud, 324342.43);
    expect(ownerMatch[0].longitud, 234432.54);
    expect(ownerMatch[0].date, "14-06-2024");
    expect(ownerMatch[0].duration, "60 minutos");
    expect(ownerMatch[0].hora, "20:30");
    expect(ownerMatch[0].type, "Tipo 1");
    expect(ownerMatch[0].totalSlots, 6);
    expect(ownerMatch[0].totalPlayers, 14);
  });

  test(
      'Utiliza agendPartidoService listAgendaJoined(), y solo se llama una vez al backend, ademas de presentar un error al recibir respuesta 299 y retornar una excepción',
      () async {
    dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
    dioAdapter = DioAdapter(dio: dio);
    var mockSecureStorage = MockSecureStorage();
    agendaPartidoService =
        AgendaPartidoService(dio: dio, secureStorage: mockSecureStorage);
    const path = 'http://10.0.2.2:3000/games/joined/1';
    Future<String> mockId() async {
      return "1";
    }

    when(mockSecureStorage.readSecureDataId()).thenAnswer((_) => mockId());

    dioAdapter.onGet(path, (server) {
      server.reply(299, null);
    });

    expect(
      () async => await agendaPartidoService.listAgendaJoined(),
      throwsA(isA<Exception>().having((e) => e.toString(), 'message',
          contains('ERRROR Fallo carga de partidos'))),
    );
  });
}
