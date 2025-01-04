import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rol_match/admin/ui/vista_admin.dart';

void main() {
  testWidgets('Muestra un mensaje cuando no hay usuarios reportados',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: VistaAdmin()));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
