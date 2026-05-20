import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// Pantalla de estadísticas.
Widget pantallaEstadisticas({
  required double balance,
  required double ingresos,
  required double gastosTotales,
  required Map<String, double> gastos,
}) {
  return SingleChildScrollView(
    child: Column(
      children: [
        const SizedBox(height: 20),
        Card(
          margin: const EdgeInsets.all(18),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const Text('Balance general'),
                const SizedBox(height: 8),
                Text(
                  '\$${balance.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: balance >= 0 ? Colors.green : Colors.red,
                  ),
                ),
                const SizedBox(height: 10),
                Text('Ingresos: \$${ingresos.toStringAsFixed(2)}'),
                Text('Gastos: \$${gastosTotales.toStringAsFixed(2)}'),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 220,
          child: gastos.isEmpty
              ? const Center(child: Text('Aún no hay gastos para mostrar'))
              : PieChart(
                  PieChartData(
                    sections: gastos.entries.map((entry) {
                      return PieChartSectionData(
                        value: entry.value,
                        title: entry.key,
                        radius: 60,
                      );
                    }).toList(),
                  ),
                ),
        ),
      ],
    ),
  );
}
