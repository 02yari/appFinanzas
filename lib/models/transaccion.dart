// Modelo para ingresos y gastos.
class Transaccion {
  int? id;
  String tipo;
  double monto;
  String descripcion;
  String categoria;
  DateTime fecha;

  Transaccion({
    this.id,
    required this.tipo,
    required this.monto,
    required this.descripcion,
    required this.categoria,
    required this.fecha,
  });
}
