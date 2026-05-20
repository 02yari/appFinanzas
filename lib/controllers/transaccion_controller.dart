import '../models/transaccion.dart';

class TransaccionController {
  final List<Transaccion> transacciones;
  final List<Transaccion> movimientosVisibles;

  TransaccionController({
    required this.transacciones,
    required this.movimientosVisibles,
  });

  // Calcula ingresos visibles.
  double ingresosVisibles() {
    double total = 0;

    for (var t in movimientosVisibles) {
      if (t.tipo == 'ingreso') total += t.monto;
    }

    return total;
  }

  // Calcula gastos visibles.
  double gastosVisibles() {
    double total = 0;

    for (var t in movimientosVisibles) {
      if (t.tipo == 'gasto') total += t.monto;
    }

    return total;
  }

  // Calcula todos los ingresos.
  double totalIngresos() {
    double total = 0;

    for (var t in transacciones) {
      if (t.tipo == 'ingreso') total += t.monto;
    }

    return total;
  }

  // Calcula todos los gastos.
  double totalGastos() {
    double total = 0;

    for (var t in transacciones) {
      if (t.tipo == 'gasto') total += t.monto;
    }

    return total;
  }

  // Calcula balance general.
  double calcularBalance() {
    return totalIngresos() - totalGastos();
  }

  // Agrupa gastos por categoría.
  Map<String, double> gastosPorCategoria() {
    Map<String, double> data = {};

    for (var t in transacciones) {
      if (t.tipo == 'gasto') {
        data[t.categoria] = (data[t.categoria] ?? 0) + t.monto;
      }
    }
    return data;
  }

  // Devuelve la categoría con mayor gasto.
  String categoriaMayorGasto() {
    final data = gastosPorCategoria();

    if (data.isEmpty) return 'Sin datos';

    String categoria = data.keys.first;
    double mayor = data.values.first;

    data.forEach((key, value) {
      if (value > mayor) {
        mayor = value;
        categoria = key;
      }
    });

    return categoria;
  }
}
