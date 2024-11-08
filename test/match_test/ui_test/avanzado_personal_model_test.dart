import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rol_match/config/theme.dart';
import 'package:rol_match/config/util.dart';
import 'package:rol_match/match/domain/models/joined_match.dart';
import 'package:rol_match/match/ui/widgets/agenda/avanzado_personal_model.dart';

import '../../mock/advanced_service_init.mocks.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  MockBuildContext _mockContext;

  setUp(() async {
    await dotenv.load(fileName: ".env");
  });

  testWidgets('AvanzadoPersonalModel test de renderizado',
      (WidgetTester tester) async {
    _mockContext = MockBuildContext();
    // Configuración del widget
    var mockAdvancedService = MockAdvancedService();
    final joinedMatch = JoinedMatch();
    joinedMatch.id = 1;
    joinedMatch.title = "Test";
    joinedMatch.latitud = 324342.43;
    joinedMatch.longitud = 234432.54;
    joinedMatch.date = "14-06-2024";
    joinedMatch.duration = "60 minutos";
    joinedMatch.hora = "20:30";
    joinedMatch.type = "Tipo 1";
    joinedMatch.totalSlots = 6;
    joinedMatch.totalPlayer = 14;

    when(mockAdvancedService.getMatch()).thenAnswer((_) async => joinedMatch);
    // TextTheme textTheme = createTextTheme(_mockContext, "Anton", "Anton");
    // MaterialTheme theme = MaterialTheme(textTheme);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AvanzadoPersonalModel(
            advancedService: mockAdvancedService,
          ),
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text("Partido de Tipo 1"), findsOneWidget);
    expect(find.text("Test"), findsOneWidget);

    expect(find.text("60 minutos"), findsOneWidget);
    expect(find.text("Eliminar la partida"), findsOneWidget);
    expect(find.text("No puedo ir a la partida"), findsOneWidget);
    expect(find.text("No quiero ir a la partida"), findsOneWidget);
  });
  testWidgets('AvanzadoPersonalModel test de renderizado, eliminar partida',
      (WidgetTester tester) async {
    _mockContext = MockBuildContext();
    // Configuración del widget
    var mockAdvancedService = MockAdvancedService();
    final joinedMatch = JoinedMatch();
    joinedMatch.id = 1;
    joinedMatch.title = "Test";
    joinedMatch.latitud = 324342.43;
    joinedMatch.longitud = 234432.54;
    joinedMatch.date = "14-06-2024";
    joinedMatch.duration = "60 minutos";
    joinedMatch.hora = "20:30";
    joinedMatch.type = "Tipo 1";
    joinedMatch.totalSlots = 6;
    joinedMatch.totalPlayer = 14;

    when(mockAdvancedService.getMatch()).thenAnswer((_) async => joinedMatch);
    // TextTheme textTheme = createTextTheme(_mockContext, "Anton", "Anton");
    // MaterialTheme theme = MaterialTheme(textTheme);
    when(mockAdvancedService.getMatch()).thenAnswer((_) async => joinedMatch);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AvanzadoPersonalModel(
            advancedService: mockAdvancedService,
          ),
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.tap(find.text("Eliminar la partida"));
    await tester.pumpAndSettle();

    expect(find.text("Eliminaras la partida ¿estas seguro?"), findsOneWidget);

    await tester.tap(find.text('Cancelar'));
  });

  testWidgets('AvanzadoPersonalModel test de renderizado, abandonar partida',
      (WidgetTester tester) async {
    _mockContext = MockBuildContext();
    // Configuración del widget
    var mockAdvancedService = MockAdvancedService();
    final joinedMatch = JoinedMatch();
    joinedMatch.id = 1;
    joinedMatch.title = "Test";
    joinedMatch.latitud = 324342.43;
    joinedMatch.longitud = 234432.54;
    joinedMatch.date = "14-06-2024";
    joinedMatch.duration = "60 minutos";
    joinedMatch.hora = "20:30";
    joinedMatch.type = "Tipo 1";
    joinedMatch.totalSlots = 6;
    joinedMatch.totalPlayer = 14;

    when(mockAdvancedService.getMatch()).thenAnswer((_) async => joinedMatch);
    // TextTheme textTheme = createTextTheme(_mockContext, "Anton", "Anton");
    // MaterialTheme theme = MaterialTheme(textTheme);
    when(mockAdvancedService.getMatch()).thenAnswer((_) async => joinedMatch);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AvanzadoPersonalModel(
            advancedService: mockAdvancedService,
          ),
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.tap(find.text("No puedo ir a la partida"));
    await tester.pumpAndSettle();
    expect(find.text("Abandonaras la partida ¿estas seguro?"), findsOneWidget);

    await tester.tap(find.text('Cancelar'));
  });

  testWidgets(
      'AvanzadoPersonalModel test de renderizado, abandonar partida, no desea participar',
      (WidgetTester tester) async {
    _mockContext = MockBuildContext();
    // Configuración del widget
    var mockAdvancedService = MockAdvancedService();
    final joinedMatch = JoinedMatch();
    joinedMatch.id = 1;
    joinedMatch.title = "Test";
    joinedMatch.latitud = 324342.43;
    joinedMatch.longitud = 234432.54;
    joinedMatch.date = "14-06-2024";
    joinedMatch.duration = "60 minutos";
    joinedMatch.hora = "20:30";
    joinedMatch.type = "Tipo 1";
    joinedMatch.totalSlots = 6;
    joinedMatch.totalPlayer = 14;

    when(mockAdvancedService.getMatch()).thenAnswer((_) async => joinedMatch);
    // TextTheme textTheme = createTextTheme(_mockContext, "Anton", "Anton");
    // MaterialTheme theme = MaterialTheme(textTheme);
    when(mockAdvancedService.getMatch()).thenAnswer((_) async => joinedMatch);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AvanzadoPersonalModel(
            advancedService: mockAdvancedService,
          ),
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.tap(find.text("No quiero ir a la partida"));
    await tester.pumpAndSettle();

    expect(find.text("Abandonaras la partida ¿estas seguro?"), findsOneWidget);

    await tester.tap(find.text('Cancelar'));
  });
}
