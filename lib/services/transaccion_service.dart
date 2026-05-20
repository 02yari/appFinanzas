import '../models/transaccion.dart';
import '../core/database/database_helper.dart';

class TransaccionService {
  static final instance = TransaccionService();

  // Cargar transacciones
  Future<List<Transaccion>> cargarTransacciones() async {
    final data = await DatabaseHelper.instance.obtenerTransacciones();

    return data.map((e) {
      final fechaGuardada = e['fecha'];

      return Transaccion(
        id: e['id'],
        tipo: e['tipo'] ?? 'gasto',
        monto: (e['monto'] as num).toDouble(),
        descripcion: e['descripcion'] ?? 'Sin descripción',
        categoria: e['categoria'] ?? 'Otros gastos',
        fecha: fechaGuardada == null || fechaGuardada == ''
            ? DateTime.now()
            : DateTime.parse(fechaGuardada),
      );
    }).toList();
  }

  // Insertar transacción
  Future<void> agregarTransaccion({
    required String tipo,
    required double monto,
    required String descripcion,
    required String categoria,
    required DateTime fecha,
  }) async {
    await DatabaseHelper.instance.insertarTransaccion({
      'tipo': tipo,
      'monto': monto,
      'descripcion': descripcion,
      'categoria': categoria,
      'fecha': fecha.toIso8601String(),
    });
  }

  // Eliminar transacción
  Future<void> eliminarTransaccion(int id) async {
    await DatabaseHelper.instance.eliminarTransaccion(id);
  }
}
