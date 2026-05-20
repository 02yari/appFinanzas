import 'package:flutter/material.dart';

Widget customBottomNav({
  required int currentIndex,
  required Function(int) onTap,
}) {
  return BottomNavigationBar(
    currentIndex: currentIndex,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: const Color(0xff00a884),
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
    onTap: onTap,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.bar_chart),
        label: 'Stats',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month),
        label: 'Inicio',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_circle, size: 38),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        label: 'Buscar',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Usuario',
      ),
    ],
  );
}
