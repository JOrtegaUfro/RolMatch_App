import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rol_match/admin/domain/widgets/reported_user.dart';

import '../../mock/report_service_init.mocks.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  MockBuildContext _mockContext;

  setUp(() async {
    await dotenv.load(fileName: ".env");
  });

  testWidgets('ReportedUser test de renderizado', (WidgetTester tester) async {
    _mockContext = MockBuildContext();
    // Configuración del widget
    var mockReportService = MockReportService();

    when(mockReportService.clearUser(1)).thenAnswer((_) async => true);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ReportedUser(
                reportService: mockReportService,
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

  testWidgets('ReportedUser test de quitar reporte',
      (WidgetTester tester) async {
    _mockContext = MockBuildContext();
    // Configuración del widget
    var mockReportService = MockReportService();

    when(mockReportService.deleteUser(1)).thenAnswer((_) async => true);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ReportedUser(
                reportService: mockReportService,
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
    await tester.tap(find.text('Quitar reporte'));
    await tester.pumpAndSettle();

    expect(find.text('Confirmar acción'), findsOneWidget);
    expect(find.text('¿Estás seguro de que deseas Quitar reporte?'),
        findsOneWidget);
    await tester.tap(find.text('Cancelar'));
  });

  testWidgets('ReportedUser test de ver usuario', (WidgetTester tester) async {
    _mockContext = MockBuildContext();
    // Configuración del widget
    var mockReportService = MockReportService();

    when(mockReportService.clearUser(1)).thenAnswer((_) async => true);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ReportedUser(
                reportService: mockReportService,
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

  testWidgets('ReportedUser test de eliminación', (WidgetTester tester) async {
    _mockContext = MockBuildContext();
    // Configuración del widget
    var mockReportService = MockReportService();

    when(mockReportService.deleteUser(1)).thenAnswer((_) async => true);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ReportedUser(
                reportService: mockReportService,
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
    await tester.tap(find.text('Eliminar'));
    await tester.pumpAndSettle();

    expect(find.text('Confirmar acción'), findsOneWidget);
    expect(find.text('¿Estás seguro de que deseas Eliminar?'), findsOneWidget);
    await tester.tap(find.text('Cancelar'));
  });
}
