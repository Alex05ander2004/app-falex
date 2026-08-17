import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../data/ingresos_repository.dart';

final ingresosGeneralesProvider = StreamProvider.autoDispose<List<Ingreso>>((ref) {
  return ref.watch(ingresosRepositoryProvider).watchAll();
});
