import 'package:flutter/material.dart';

Widget botonVerTodos({
  required bool verTodos,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18),
    child: Align(
      alignment: Alignment.centerLeft,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          verTodos ? Icons.calendar_today : Icons.list,
        ),
        label: Text(
          verTodos ? 'Ver día seleccionado' : 'Ver todos',
        ),
      ),
    ),
  );
}
