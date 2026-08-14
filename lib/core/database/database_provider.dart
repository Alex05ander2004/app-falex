import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_database.dart';

/// Instancia única de la base local para toda la app. Los repositorios
/// de cada feature (Fase 2+) dependen de este provider, nunca crean su
/// propia [AppDatabase].
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});
