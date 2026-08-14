import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum StatusTone { success, warning, error, neutral }

/// Chip "subtle filled" — fondo tenue del color semántico, texto del
/// mismo tono con más contraste (design/stitch/DESIGN.md, Chips & Badges).
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.label, required this.tone});

  final String label;
  final StatusTone tone;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (tone) {
      StatusTone.success => (AppColors.successContainer, AppColors.onSuccessContainer),
      StatusTone.warning => (AppColors.warningContainer, AppColors.onWarningContainer),
      StatusTone.error => (AppColors.errorContainer, AppColors.onErrorContainer),
      StatusTone.neutral => (AppColors.surfaceContainerHigh, AppColors.onSurfaceVariant),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: fg,
              letterSpacing: 0,
            ),
      ),
    );
  }
}
