import 'package:flutter/material.dart';

// Calendario semanal funcional.
Widget calendarioSuperior({
  required DateTime fechaSeleccionada,
  required bool verTodos,
  required Function(DateTime) onSeleccionarFecha,
  required bool Function(DateTime, DateTime) esMismoDia,
}) {
  final inicioSemana = fechaSeleccionada.subtract(
    Duration(days: fechaSeleccionada.weekday - 1),
  );

  final dias = List.generate(7, (index) {
    return inicioSemana.add(Duration(days: index));
  });

  const letras = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];

  return Container(
    padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(dias.length, (index) {
        final dia = dias[index];
        final seleccionado = esMismoDia(dia, fechaSeleccionada);

        return GestureDetector(
          onTap: () {
            onSeleccionarFecha(dia);
          },
          child: Container(
            width: 42,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: seleccionado && !verTodos
                  ? const Color(0xffd6f4e5)
                  : Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: seleccionado && !verTodos
                    ? const Color(0xff00a884)
                    : Colors.transparent,
              ),
            ),
            child: Column(
              children: [
                Text(
                  letras[index],
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${dia.day}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    ),
  );
}
