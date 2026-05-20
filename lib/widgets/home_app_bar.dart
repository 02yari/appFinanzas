import 'package:flutter/material.dart';

PreferredSizeWidget homeAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: const Color(0xfffbf7f2),
    foregroundColor: Colors.black87,
    title: const Text(
      'Finanzas Personales',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}