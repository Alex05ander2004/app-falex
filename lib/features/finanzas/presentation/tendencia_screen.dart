import 'package:flutter/material.dart';

import 'widgets/tendencia_mensual_chart.dart';

/// Pantalla dedicada a la tendencia mensual — separada de [FinanzasScreen]
/// para no competir por espacio con las listas de ingresos/egresos/impuestos
/// (Ruta Falex, Fase 6).
class TendenciaScreen extends StatelessWidget {
  const TendenciaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tendencia mensual')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: TendenciaMensualChart(),
      ),
    );
  }
}
