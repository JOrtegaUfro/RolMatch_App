import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rol_match/match/data/services/advanced_service.dart';
import 'package:rol_match/match/ui/widgets/agenda/avanzado_model.dart';

import '../../mock/advanced_service_init.mocks.dart';

void main() {
  setUpAll(() {});

  testWidgets('AvanzadoModel test', (WidgetTester tester) async {
    AvanzadoModel avanzadoModel = new AvanzadoModel();
    AdvancedService mockAdvancedService = new MockAdvancedService();
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
                child: OutlinedButton(
                    onPressed: () async {
                      avanzadoModel.testShowLeaveDialog(
                          context, mockAdvancedService);
                    },
                    child: Text("Test")));
          },
        ),
      ),
    );
    await tester.tap(find.text('Test'));
    await tester.pump();
    expect(find.byType(AlertDialog), findsWidgets);
  });

  testWidgets('AvanzadoModel test, presionar cancelar',
      (WidgetTester tester) async {
    AvanzadoModel avanzadoModel = new AvanzadoModel();
    AdvancedService mockAdvancedService = new MockAdvancedService();
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
                child: OutlinedButton(
                    onPressed: () async {
                      avanzadoModel.testShowLeaveDialog(
                          context, mockAdvancedService);
                    },
                    child: Text("Test")));
          },
        ),
        routes: <String, WidgetBuilder>{
          '/agendaPartido': (context) => Text('Correct test'),
        },
      ),
    );
    await tester.tap(find.text('Test'));
    await tester.pump();
    expect(find.byType(AlertDialog), findsWidgets);
    await tester.tap(find.text('Cancelar'));
    await tester.pump();
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('AvanzadoModel test, presionar aceptar',
      (WidgetTester tester) async {
    AvanzadoModel avanzadoModel = new AvanzadoModel();
    AdvancedService mockAdvancedService = new MockAdvancedService();
    Future<bool> responseTrue() async {
      return true;
    }

    when(mockAdvancedService.leaveMatch()).thenAnswer((_) => responseTrue());

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
                child: OutlinedButton(
                    onPressed: () async {
                      avanzadoModel.testShowLeaveDialog(
                          context, mockAdvancedService);
                    },
                    child: Text("Test")));
          },
        ),
        routes: <String, WidgetBuilder>{
          '/agendaPartido': (context) => Text('Correct test'),
        },
      ),
    );
    await tester.tap(find.text('Test'));
    await tester.pump();
    expect(find.byType(AlertDialog), findsWidgets);
    await tester.tap(find.text('Aceptar'));
    await tester.pump();
    verify(mockAdvancedService.leaveMatch()).called(1);
  });

  testWidgets('AvanzadoModel test, optionSelector',
      (WidgetTester tester) async {
    AvanzadoModel avanzadoModel = new AvanzadoModel();
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
                child: avanzadoModel.testOptionSelector(context));
          },
        ),
        routes: <String, WidgetBuilder>{
          '/agendaPartido': (context) => Text('Correct test'),
        },
      ),
    );
    await tester.pump();
    expect(find.text('Acepte por error la partida'), findsWidgets);
    expect(find.text("No puedo ir a la partida"), findsWidgets);
    expect(find.text("No quiero ir a la partida"), findsWidgets);

    await tester.pump();
  });

  testWidgets('AvanzadoModel test, partidoContainer',
      (WidgetTester tester) async {
    AvanzadoModel avanzadoModel = new AvanzadoModel();
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return SingleChildScrollView(
                child: avanzadoModel.testPartidoContainer(
                    context, "Test", "Tipo 1", "6:00", 15));
          },
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Partida de Tipo 1'), findsWidgets);
    expect(find.text("15 jugadores"), findsWidgets);

    await tester.pump();
  });
}
