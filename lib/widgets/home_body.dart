import 'package:flutter/material.dart';
import '../models/transaccion.dart';
import '../controllers/transaccion_controller.dart';
import '../utils/transaccion_utils.dart';
import 'balance_card.dart';
import 'resumen_rapido.dart';
import 'calendario_widget.dart';
import 'boton_ver_todos.dart';
import 'encabezado_movimientos.dart';
import 'movimiento_card.dart';

Widget homeBody({
  required List<Transaccion> movimientos,
  required bool verTodos,
  required DateTime fechaSeleccionada,
  required TransaccionController controller,
  required void Function(DateTime) onSeleccionarFecha,
  required VoidCallback onToggleVerTodos,
  required Future<void> Function(int) eliminarTransaccion,
}) {
  return Container(
    color: const Color(0xfffbf7f2),
    child: Column(
      children: [
        tarjetaBalancePrincipal(
          balance: controller.calcularBalance(),
          ingresos: controller.totalIngresos(),
          gastos: controller.totalGastos(),
        ),
        resumenRapido(
          verTodos: verTodos,
          ingresosVisibles: controller.ingresosVisibles(),
          gastosVisibles: controller.gastosVisibles(),
          cantidadMovimientos: movimientos.length,
          categoriaMayor: controller.categoriaMayorGasto(),
        ),
        calendarioSuperior(
          fechaSeleccionada: fechaSeleccionada,
          verTodos: verTodos,
          esMismoDia: esMismoDia,
          onSeleccionarFecha: onSeleccionarFecha,
        ),
        botonVerTodos(
          verTodos: verTodos,
          onPressed: onToggleVerTodos,
        ),
        encabezadoMovimientos(
          verTodos: verTodos,
          fechaSeleccionada: fechaSeleccionada,
          esMismoDia: esMismoDia,
          fechaCorta: fechaCorta,
          gastosVisibles: controller.gastosVisibles(),
        ),
        Expanded(
          child: movimientos.isEmpty
              ? const Center(
                  child: Text(
                    'No hay movimientos para mostrar',
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: movimientos.length,
                  itemBuilder: (context, index) {
                    return tarjetaMovimiento(
                      movimientos[index],
                      colorCategoria: colorCategoria,
                      iconoCategoria: iconoCategoria,
                      fechaCorta: fechaCorta,
                      eliminarTransaccion: eliminarTransaccion,
                    );
                  },
                ),
        ),
      ],
    ),
  );
}
