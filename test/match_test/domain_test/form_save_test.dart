import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rol_match/match/domain/create/form_save.dart';

import '../../shared_preferences_test.mocks.dart';

void main() {
  setUp(() async {});

  testWidgets('test form save, save game', (WidgetTester tester) async {
    //FormSave formSave = new FormSave();

    var mockSharedPreferences = MockSharedPreferences();
    when(mockSharedPreferences.setString(any, any))
        .thenAnswer((_) async => true);
    FormSave formSave = FormSave(sharedPreferences: mockSharedPreferences);
    formSave.saveGame("Test");
    verify(mockSharedPreferences.setString("game", "Test")).called(1);
  });

  testWidgets('test form save, save Duration', (WidgetTester tester) async {
    //FormSave formSave = new FormSave();

    var mockSharedPreferences = MockSharedPreferences();
    when(mockSharedPreferences.setString(any, any))
        .thenAnswer((_) async => true);
    FormSave formSave = FormSave(sharedPreferences: mockSharedPreferences);
    formSave.saveDuration(15);
    verify(mockSharedPreferences.setString("duration", "15 minutos")).called(1);
  });

  testWidgets('test form save, save Hour', (WidgetTester tester) async {
    //FormSave formSave = new FormSave();

    var mockSharedPreferences = MockSharedPreferences();
    when(mockSharedPreferences.setString(any, any))
        .thenAnswer((_) async => true);
    FormSave formSave = FormSave(sharedPreferences: mockSharedPreferences);
    TimeOfDay time = TimeOfDay(hour: 14, minute: 30);
    formSave.saveHour(time);
    //Debido a que depende de la configuración del dispositivo como se mostrara el String
    //formato 24h o 12h, se espera que se guarde cualquier String, considerando la clave "hora"
    verify(mockSharedPreferences.setString("hora", any)).called(1);
  });

  testWidgets('test form save, save Date', (WidgetTester tester) async {
    //FormSave formSave = new FormSave();

    var mockSharedPreferences = MockSharedPreferences();
    when(mockSharedPreferences.setString(any, any))
        .thenAnswer((_) async => true);
    FormSave formSave = FormSave(sharedPreferences: mockSharedPreferences);
    DateTime dateTime = DateTime(2024, 12, 2, 12, 30);
    formSave.saveDate(dateTime);
    verify(mockSharedPreferences.setString("date", "2- 12")).called(1);
  });
}
