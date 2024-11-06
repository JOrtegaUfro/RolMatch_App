import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rol_match/main.dart';

void main() {
  testWidgets('CarouselLogin Test', (WidgetTester tester) async {
    // Construir el widget de prueba.
    await tester.pumpWidget(
      const MyApp(initialRoute: '/vistaAuth'),
    );

    expect(find.byType(PageView), findsOneWidget);
    expect(find.image(const AssetImage('assets/play.png')), findsOneWidget);

    await tester.drag(find.byType(PageView), const Offset(-300, 0));
    await tester.pumpAndSettle();

    expect(find.image(const AssetImage('assets/team.png')), findsOneWidget);

    await tester.drag(find.byType(PageView), const Offset(-300, 0));
    await tester.pumpAndSettle();

    expect(find.image(const AssetImage('assets/time.png')), findsOneWidget);

    await tester.drag(find.byType(PageView), const Offset(300, 0));
    await tester.pumpAndSettle();
  });
}
