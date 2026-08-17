import 'package:flutter/material.dart';

import '../../features/finanzas/presentation/finanzas_screen.dart';
import '../../features/trabajadores/presentation/trabajadores_list_screen.dart';
import '../../features/vehiculos/presentation/vehiculos_list_screen.dart';
import '../../features/viajes/presentation/viajes_list_screen.dart';

/// Navegación principal — 4 pestañas, igual que el borrador de Stitch
/// (Finance / Trips / Fleet / Workers).
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 1;

  static const _tabs = [
    FinanzasScreen(),
    ViajesListScreen(),
    VehiculosListScreen(),
    TrabajadoresListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _tabs),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_outlined),
            label: 'Finanzas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping_outlined),
            label: 'Viajes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warehouse_outlined),
            label: 'Flota',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.badge_outlined),
            label: 'Trabajadores',
          ),
        ],
      ),
    );
  }
}
