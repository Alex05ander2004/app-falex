/// Excepciones de negocio, para que la UI muestre un mensaje útil en vez
/// de un error crudo de SQLite — ver Ruta Falex, "Validaciones y manejo
/// de errores".
library;

/// Una acción choca con una regla de negocio (p.ej. dar de baja a un
/// trabajador con viajes en curso).
class ValidacionNegocioException implements Exception {
  const ValidacionNegocioException(this.mensaje);
  final String mensaje;

  @override
  String toString() => mensaje;
}

/// Violación de una restricción de unicidad (DNI o placa repetidos).
class RegistroDuplicadoException implements Exception {
  const RegistroDuplicadoException(this.mensaje);
  final String mensaje;

  @override
  String toString() => mensaje;
}
