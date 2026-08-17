import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

/// Recordatorio local de vencimiento de impuestos — Ruta Falex, Fase 5.
/// Avisa 3 días antes de la fecha de vencimiento, para que sobre margen
/// de pagar sin ser una alerta constante.
class NotificationService {
  static const _diasDeAviso = 3;

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _listo = false;

  Future<void> init() async {
    if (_listo) return;
    tz_data.initializeTimeZones();
    // Falex opera en Perú — se fija la zona horaria en vez de sumar una
    // dependencia solo para detectarla del dispositivo.
    tz.setLocalLocation(tz.getLocation('America/Lima'));

    await _plugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      ),
    );
    _listo = true;
  }

  Future<bool> solicitarPermiso() async {
    final concedido = await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    return concedido ?? false;
  }

  /// Si el vencimiento ya pasó, o falta menos de [_diasDeAviso] días, no
  /// se programa nada — avisar tarde sobre algo que ya venció no sirve.
  Future<void> programarRecordatorioImpuesto({
    required int impuestoId,
    required String tipoEtiqueta,
    required String periodo,
    required DateTime fechaVencimiento,
  }) async {
    await init();
    final fechaAviso = fechaVencimiento.subtract(const Duration(days: _diasDeAviso));
    if (fechaAviso.isBefore(DateTime.now())) return;

    await _plugin.zonedSchedule(
      impuestoId,
      'Impuesto por vencer: $tipoEtiqueta',
      '$tipoEtiqueta de $periodo vence el '
          '${fechaVencimiento.day}/${fechaVencimiento.month}/${fechaVencimiento.year}.',
      tz.TZDateTime.from(fechaAviso, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'impuestos_vencimientos',
          'Vencimiento de impuestos',
          channelDescription: 'Avisa unos días antes de que venza un impuesto.',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelarRecordatorio(int impuestoId) async {
    await init();
    await _plugin.cancel(impuestoId);
  }
}
