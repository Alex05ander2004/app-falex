const _meses = [
  'enero',
  'febrero',
  'marzo',
  'abril',
  'mayo',
  'junio',
  'julio',
  'agosto',
  'septiembre',
  'octubre',
  'noviembre',
  'diciembre',
];

/// "agosto 2026" a partir de cualquier [DateTime] — solo importan año y
/// mes.
String etiquetaMes(DateTime mes) => '${_meses[mes.month - 1]} ${mes.year}';

/// "ago 2026" — para espacios angostos como chips o ejes de gráfico.
String etiquetaMesCorta(DateTime mes) =>
    '${_meses[mes.month - 1].substring(0, 3)} ${mes.year}';
