import 'package:flutter/material.dart';

// Tarjeta del balance principal.
Widget tarjetaBalancePrincipal({
  required double balance,
  required double ingresos,
  required double gastos,
}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(18, 12, 18, 10),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xff111827),
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Balance general',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Text(
          '\$$balance',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            resumenMini('Ingresos', ingresos, Colors.green),
            const SizedBox(width: 12),
            resumenMini('Gastos', gastos, Colors.redAccent),
          ],
        ),
      ],
    ),
  );
}

// Mini resumen.
Widget resumenMini(String titulo, double valor, Color color) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: const TextStyle(color: Colors.white60)),
          const SizedBox(height: 4),
          Text(
            '\$${valor.toStringAsFixed(2)}',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
