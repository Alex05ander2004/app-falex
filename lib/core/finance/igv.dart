/// IGV (Impuesto General a las Ventas, Perú): 18%.
///
/// Débito fiscal: 18% de cada flete facturado — se acumula como IGV por
/// pagar. Crédito fiscal: 18% de los gastos que sí tienen factura con el
/// RUC de Falex — reduce ese acumulado. El neto (débito − crédito) es lo
/// que la empresa debe a SUNAT por este concepto.
///
/// Igual que la detracción (ver detraccion.dart): se calcula y se guarda
/// al momento de registrar el movimiento, no se recalcula después.
library;

const porcentajeIgv = 0.18;

double calcularIgv(double monto) => monto * porcentajeIgv;
