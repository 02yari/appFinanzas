import 'package:flutter/material.dart';
import 'resumen_item.dart';

Widget resumenRapido({
  required bool verTodos,
  required double ingresosVisibles,
  required double gastosVisibles,
  required int cantidadMovimientos,
  required String categoriaMayor,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14),
    child: Row(
      children: [
        itemResumen(
          verTodos ? 'Disponible total' : 'Disponible día',
          '\$${(ingresosVisibles - gastosVisibles).toStringAsFixed(2)}',
          Icons.savings,
        ),
        itemResumen(
          verTodos ? 'Movimientos' : 'Mov. día',
          '$cantidadMovimientos',
          Icons.swap_vert,
        ),
        itemResumen(
          'Mayor gasto',
          categoriaMayor,
          Icons.pie_chart,
        ),
      ],
    ),
  );
}