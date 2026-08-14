import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:falex/app.dart';

void main() {
  testWidgets('FalexApp arranca y muestra la pantalla de bienvenida',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: FalexApp()));

    expect(find.text('Falex'), findsWidgets);
    expect(find.text('Ruta Falex'), findsOneWidget);
  });
}
