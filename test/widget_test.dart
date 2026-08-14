import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:falex/app.dart';
import 'package:falex/core/database/app_database.dart';
import 'package:falex/core/database/database_provider.dart';

void main() {
  testWidgets('FalexApp arranca y muestra la pestaña de Trabajadores',
      (WidgetTester tester) async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const FalexApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Trabajadores'), findsWidgets);
    expect(find.text('Aún no hay trabajadores aquí'), findsOneWidget);

    // Los streams de Drift agendan un timer al cerrarse; se desmonta el
    // árbol aquí (en vez de dejar que lo haga el framework al terminar
    // el test) para poder purgarlo con un pump antes de que termine.
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 50));
  });
}
