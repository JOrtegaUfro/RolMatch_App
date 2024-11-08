import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rol_match/config/theme.dart';
import 'package:rol_match/config/util.dart';
import 'package:rol_match/match/ui/widgets/agenda/time/hour_style.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  MockBuildContext _mockContext;

  testWidgets('HourStyle test de renderizado', (WidgetTester tester) async {
    _mockContext = MockBuildContext();
    // Configuración del widget
    final hourStyle = HourStyle();
    TextTheme textTheme = createTextTheme(_mockContext, "Anton", "Anton");
    MaterialTheme theme = MaterialTheme(textTheme);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: hourStyle.hourWidget(
            _mockContext,
            '12:30',
          ),
        ),
      ),
    );

    expect(find.text('12'), findsOneWidget);
    expect(find.text(':'), findsOneWidget);
    expect(find.text('30'), findsOneWidget);

    final textWidgets = tester.widgetList<Text>(find.byType(Text));
    expect(textWidgets.elementAt(0).style?.fontSize, 30);

    final containers = tester.widgetList<Container>(find.byType(Container));
    expect(containers.length, 2);

    final boxDecoration1 = containers.elementAt(0).decoration as BoxDecoration?;
    final boxDecoration2 = containers.elementAt(1).decoration as BoxDecoration?;

    expect(boxDecoration1?.color, ThemeData().primaryColor);
    expect(boxDecoration2?.color, ThemeData().primaryColor);
    expect(boxDecoration1?.borderRadius, BorderRadius.circular(8.0));
    expect(boxDecoration2?.borderRadius, BorderRadius.circular(8.0));
  });
}
