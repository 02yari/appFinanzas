import 'package:flutter/material.dart';

Widget encabezadoMovimientos({
  required bool verTodos,
  required DateTime fechaSeleccionada,
  required bool Function(DateTime, DateTime) esMismoDia,
  required String Function(DateTime) fechaCorta,
  required double gastosVisibles,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(18, 14, 18, 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              verTodos
                  ? 'Todos los registros'
                  : esMismoDia(fechaSeleccionada, DateTime.now())
                      ? 'Hoy'
                      : fechaCorta(fechaSeleccionada),
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            const Text(
              'Movimientos',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          '-\$${gastosVisibles.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Color(0xff4b2e2b),
          ),
        ),
      ],
    ),
  );
}
