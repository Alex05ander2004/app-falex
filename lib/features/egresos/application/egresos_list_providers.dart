import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../data/egresos_repository.dart';

final egresosGeneralesProvider = StreamProvider.autoDispose<List<Egreso>>((ref) {
  return ref.watch(egresosRepositoryProvider).watchAll();
});
