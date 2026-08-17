import 'package:flutter/material.dart';

import '../../../../core/database/enum_labels.dart';
import '../../../../core/database/enums.dart';
import '../../../../core/widgets/status_chip.dart';

class ViajeEstadoChip extends StatelessWidget {
  const ViajeEstadoChip({super.key, required this.estado});
  final ViajeEstado estado;

  @override
  Widget build(BuildContext context) {
    final tone = switch (estado) {
      ViajeEstado.programado => StatusTone.neutral,
      ViajeEstado.enCurso => StatusTone.warning,
      ViajeEstado.finalizado => StatusTone.success,
      ViajeEstado.cancelado => StatusTone.error,
    };
    return StatusChip(label: etiquetaViajeEstado(estado), tone: tone);
  }
}
