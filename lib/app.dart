import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/widgets/app_shell.dart';

class FalexApp extends StatelessWidget {
  const FalexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Falex',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const AppShell(),
    );
  }
}
