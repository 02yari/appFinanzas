import 'package:flutter/material.dart';

// Define icono por categoría.
IconData iconoCategoria(String categoria) {
  if (categoria == 'Comida') return Icons.restaurant;
  if (categoria == 'Transporte') return Icons.local_taxi;
  if (categoria == 'Educación') return Icons.school;
  if (categoria == 'Ahorros') return Icons.savings;
  if (categoria == 'Salario') return Icons.payments;
  if (categoria == 'Reparación') return Icons.build;
  if (categoria == 'Venta') return Icons.storefront;
  if (categoria == 'Otro ingreso') return Icons.attach_money;
  return Icons.receipt_long;
}

// Define color por categoría.
Color colorCategoria(String categoria) {
  if (categoria == 'Comida') return Colors.green.shade100;
  if (categoria == 'Transporte') return Colors.purple.shade100;
  if (categoria == 'Educación') return Colors.blue.shade100;
  if (categoria == 'Ahorros') return Colors.orange.shade100;
  if (categoria == 'Salario') return Colors.teal.shade100;
  if (categoria == 'Reparación') return Colors.indigo.shade100;
  if (categoria == 'Venta') return Colors.amber.shade100;
  if (categoria == 'Otro ingreso') return Colors.cyan.shade100;
  return Colors.grey.shade200;
}

// Formatea fecha corta.
String fechaCorta(DateTime fecha) {
  return '${fecha.day}/${fecha.month}/${fecha.year}';
}

// Compara si dos fechas pertenecen al mismo día.
bool esMismoDia(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
