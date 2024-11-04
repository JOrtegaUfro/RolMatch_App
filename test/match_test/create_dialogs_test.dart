import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:rol_match/match/domain/dialogs/create_dialogs.dart';

void main() {
  setUp(() async {});

  testWidgets('Create dialogs test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                CreateDialogs().showSlotsDialog(context);
              },
              child: const Text('Dialog'),
            );
          },
        ),
      ),
    );
    await tester.tap(find.text('Dialog'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
        find.text(
            'El numero de cupos debe ser menor a el numero total de jugadores'),
        findsOneWidget);
    expect(find.byIcon(Icons.warning), findsOneWidget);
  });
}
