/// Detracciones (SUNAT): de cada flete cobrado a KR, un porcentaje se va
/// directo a la cuenta de detracciones de la empresa — nunca llega a la
/// cuenta corriente aunque el flete se haya facturado por el total.
///
/// Se calcula y se guarda en el momento de registrar el ingreso (no se
/// recalcula después): si el porcentaje cambia más adelante, los
/// ingresos ya registrados deben mantener la detracción con la que
/// realmente se pagaron.
library;

const porcentajeDetraccionFlete = 0.04;

double calcularDetraccion(double montoFlete) => montoFlete * porcentajeDetraccionFlete;
