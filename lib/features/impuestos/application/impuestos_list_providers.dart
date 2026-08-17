import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../data/impuestos_repository.dart';

final impuestosProvider = StreamProvider.autoDispose<List<Impuesto>>((ref) {
  return ref.watch(impuestosRepositoryProvider).watchAll();
});
