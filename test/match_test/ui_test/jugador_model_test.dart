import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rol_match/match/ui/widgets/agenda/players/jugador_model.dart';

import '../../mock/action_service_init.mocks.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  MockBuildContext _mockContext;

  setUp(() async {
    await dotenv.load(fileName: ".env");
  });

  testWidgets('JugadorModel test de renderizado', (WidgetTester tester) async {
    _mockContext = MockBuildContext();
    // Configuración del widget
    var mockActionService = MockActionService();

    when(mockActionService.reportUser(1)).thenAnswer((_) async => true);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return JugadorModel(
                actionService: mockActionService,
              ).Jugador(context, "Juan", 1);
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text("Juan"), findsOneWidget);
    await tester.pumpAndSettle();
  });

  testWidgets('JugadorModel test de reporte', (WidgetTester tester) async {
    _mockContext = MockBuildContext();
    // Configuración del widget
    var mockActionService = MockActionService();

    when(mockActionService.reportUser(1)).thenAnswer((_) async => true);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return JugadorModel(
                actionService: mockActionService,
              ).Jugador(context, "Juan", 1);
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text("Juan"), findsOneWidget);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.view_timeline));
    await tester.pumpAndSettle();
    expect(find.text("Seleccionar opción"), findsOneWidget);
    await tester.tap(find.text('Reportar'));
    await tester.pumpAndSettle();

    expect(find.text('Confirmar acción'), findsOneWidget);
    expect(find.text('¿Estás seguro de que deseas Reportar?'), findsOneWidget);
    await tester.tap(find.text('Cancelar'));
  });

  testWidgets('JugadorModel test de ver usuario', (WidgetTester tester) async {
    _mockContext = MockBuildContext();
    // Configuración del widget
    var mockActionService = MockActionService();

    when(mockActionService.reportUser(1)).thenAnswer((_) async => true);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return JugadorModel(
                actionService: mockActionService,
              ).Jugador(context, "Juan", 1);
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text("Juan"), findsOneWidget);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.view_timeline));
    await tester.pumpAndSettle();

    expect(find.text("Seleccionar opción"), findsOneWidget);
    await tester.tap(find.text('Ver usuario'));
    await tester.pumpAndSettle();

    expect(find.text('Confirmar acción'), findsOneWidget);
    expect(find.text('¿Estás seguro de que deseas ver el Perfil?'),
        findsOneWidget);
    await tester.tap(find.text('Cancelar'));
  });
}
