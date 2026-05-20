import 'package:flutter/material.dart';
import '../models/transaccion.dart';

// Tarjeta de movimiento.
Widget tarjetaMovimiento(
  Transaccion t, {
  required Color Function(String) colorCategoria,
  required IconData Function(String) iconoCategoria,
  required String Function(DateTime) fechaCorta,
  required Function(int) eliminarTransaccion,
  bool permitirEliminar = true,
}) {
  final esIngreso = t.tipo == 'ingreso';

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.02),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      leading: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: colorCategoria(t.categoria),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(iconoCategoria(t.categoria), color: Colors.black87),
      ),
      title: Text(
        t.categoria,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      subtitle: Text(
        '${t.descripcion} • ${fechaCorta(t.fecha)}',
        style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
      ),
      trailing: SizedBox(
        width: permitirEliminar ? 105 : 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '${esIngreso ? '+' : '-'}\$${t.monto.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: esIngreso ? Colors.green : const Color(0xff4b2e2b),
              ),
            ),
            if (permitirEliminar)
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'eliminar' && t.id != null) {
                    eliminarTransaccion(t.id!);
                  }
                },
                itemBuilder: (context) {
                  return const [
                    PopupMenuItem(
                      value: 'eliminar',
                      child: Text('Eliminar'),
                    ),
                  ];
                },
              ),
          ],
        ),
      ),
    ),
  );
}
