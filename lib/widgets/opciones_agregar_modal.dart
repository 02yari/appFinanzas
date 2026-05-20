import 'package:flutter/material.dart';
import 'transaccion_form.dart';

void mostrarOpcionesAgregar({
  required BuildContext context,
  required DateTime fechaSeleccionada,
  required Future<void> Function(
    String,
    double,
    String,
    String,
    DateTime,
  ) agregarTransaccion,
  required String Function(DateTime) fechaCorta,
}) {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.swap_vert),
              title: const Text('Agregar movimiento'),
              onTap: () {
                Navigator.pop(context);

                mostrarFormularioTransaccion(
                  context: context,
                  fechaSeleccionada: fechaSeleccionada,
                  agregarTransaccion: agregarTransaccion,
                  fechaCorta: fechaCorta,
                );
              },
            ),
          ],
        ),
      );
    },
  );
}
