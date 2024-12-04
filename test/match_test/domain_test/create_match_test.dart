import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rol_match/match/data/services/create_match_service.dart';
import 'package:rol_match/match/domain/models/create_match.dart';
import 'package:rol_match/user/data/storage/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rol_match/match/domain/models/match.dart';
import '../../mock/create_match_service_init.mocks.dart';
import '../../secure_storage_init_test.mocks.dart';
import '../../shared_preferences_test.mocks.dart';

void main() {
  setUpAll(() {});

  testWidgets('Create match test, test de función privada create()',
      (WidgetTester tester) async {
    Future<bool> responseTrue() async {
      return true;
    }

    Future<String> responseTestString() async {
      return "Test";
    }

    SharedPreferences mockSharedPrefrences = new MockSharedPreferences();
    SecureStorage mockSecureStorage = new MockSecureStorage();
    CreateMatchService mockCreateMatchService = new MockCreateMatchService();
    CreateMatch createMatch = new CreateMatch();
    when(mockSharedPrefrences.getDouble("latitud")).thenReturn(20.0);
    when(mockSharedPrefrences.getDouble("longitud")).thenReturn(20.0);
    when(mockSharedPrefrences.getString("date")).thenReturn("15-5");
    when(mockSharedPrefrences.getString("duration")).thenReturn("15 minutos");
    when(mockSharedPrefrences.getString("hora")).thenReturn("15:30");
    when(mockSharedPrefrences.getString("type")).thenReturn("DnD");
    when(mockSharedPrefrences.getInt("totalSlots")).thenReturn(20);
    when(mockSharedPrefrences.getInt("totalPlayers")).thenReturn(20);
    when(mockSecureStorage.readSecureData("name"))
        .thenAnswer((_) => responseTestString());

    Match match = Match(
        latitud: 20.0,
        longitud: 20.0,
        date: "15-5",
        duration: "15 minutos",
        hora: "15:30",
        type: "DnD",
        totalSlots: 20,
        totalPlayers: 20,
        userName: "Test");

    when(mockCreateMatchService.createMatch(match))
        .thenAnswer((_) => responseTrue());
    createMatch.testCreate(
        mockSharedPrefrences, mockSecureStorage, mockCreateMatchService, match);
    verify(mockSharedPrefrences.getDouble("latitud")).called(1);
    verify(mockSharedPrefrences.getDouble("longitud")).called(1);
    verify(mockSharedPrefrences.getString("date")).called(1);
    verify(mockSharedPrefrences.getString("duration")).called(1);
    verify(mockSharedPrefrences.getString("hora")).called(1);
    verify(mockSharedPrefrences.getString("type")).called(1);
    verify(mockSharedPrefrences.getInt("totalSlots")).called(1);
    verify(mockSharedPrefrences.getInt("totalPlayers")).called(1);
    verify(mockSecureStorage.readSecureData("name")).called(1);
  });
}
