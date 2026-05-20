import 'package:flutter/material.dart';

import '../../models/transaccion.dart';
import '../../widgets/movimiento_card.dart';

// Pantalla de búsqueda.
Widget pantallaBuscar({
  required List<Transaccion> transacciones,
  required String textoBusqueda,
  required Function(String) onBuscar,
  required Color Function(String) colorCategoria,
  required IconData Function(String) iconoCategoria,
  required String Function(DateTime) fechaCorta,
  required Function(int) eliminarTransaccion,
}) {
  final resultados = transacciones.where((t) {
    final texto = textoBusqueda.toLowerCase();

    return t.descripcion.toLowerCase().contains(texto) ||
        t.categoria.toLowerCase().contains(texto) ||
        t.tipo.toLowerCase().contains(texto) ||
        t.monto.toString().contains(texto) ||
        fechaCorta(t.fecha).contains(texto);
  }).toList();

  return Container(
    color: const Color(0xfffbf7f2),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar movimiento...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              onBuscar(value);
            },
          ),
        ),
        Expanded(
          child: resultados.isEmpty
              ? const Center(child: Text('No se encontraron movimientos'))
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: resultados.length,
                  itemBuilder: (context, index) {
                    return tarjetaMovimiento(
                      resultados[index],
                      colorCategoria: colorCategoria,
                      iconoCategoria: iconoCategoria,
                      fechaCorta: fechaCorta,
                      eliminarTransaccion: eliminarTransaccion,
                      permitirEliminar: false,
                    );
                  },
                ),
        ),
      ],
    ),
  );
}
