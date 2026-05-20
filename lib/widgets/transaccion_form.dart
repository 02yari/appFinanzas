import 'package:flutter/material.dart';

// Formulario para agregar movimiento.
void mostrarFormularioTransaccion({
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
  String tipo = 'gasto';
  String categoria = 'Comida';
  DateTime fechaMovimiento = fechaSeleccionada;

  final montoController = TextEditingController();
  final descController = TextEditingController();

  showDialog(
    context: context,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text('Nuevo movimiento'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: tipo,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'ingreso',
                        child: Text('Ingreso'),
                      ),
                      DropdownMenuItem(
                        value: 'gasto',
                        child: Text('Gasto'),
                      ),
                    ],
                    onChanged: (value) {
                      setStateDialog(() {
                        tipo = value!;

                        if (tipo == 'ingreso') {
                          categoria = 'Salario';
                        } else {
                          categoria = 'Comida';
                        }
                      });
                    },
                  ),
                  DropdownButton<String>(
                    value: categoria,
                    isExpanded: true,
                    items: tipo == 'ingreso'
                        ? const [
                            DropdownMenuItem(
                              value: 'Salario',
                              child: Text('Salario'),
                            ),
                            DropdownMenuItem(
                              value: 'Reparación',
                              child: Text('Reparación'),
                            ),
                            DropdownMenuItem(
                              value: 'Venta',
                              child: Text('Venta'),
                            ),
                            DropdownMenuItem(
                              value: 'Otro ingreso',
                              child: Text('Otro ingreso'),
                            ),
                          ]
                        : const [
                            DropdownMenuItem(
                              value: 'Comida',
                              child: Text('Comida'),
                            ),
                            DropdownMenuItem(
                              value: 'Transporte',
                              child: Text('Transporte'),
                            ),
                            DropdownMenuItem(
                              value: 'Educación',
                              child: Text('Educación'),
                            ),
                            DropdownMenuItem(
                              value: 'Ahorros',
                              child: Text('Ahorros'),
                            ),
                            DropdownMenuItem(
                              value: 'Otros gastos',
                              child: Text('Otros gastos'),
                            ),
                          ],
                    onChanged: (value) {
                      setStateDialog(() {
                        categoria = value!;
                      });
                    },
                  ),
                  TextField(
                    controller: montoController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Monto'),
                  ),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.calendar_month),
                    title: Text('Fecha: ${fechaCorta(fechaMovimiento)}'),
                    trailing: const Icon(Icons.edit),
                    onTap: () async {
                      final nuevaFecha = await showDatePicker(
                        context: context,
                        initialDate: fechaMovimiento,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2035),
                      );

                      if (nuevaFecha != null) {
                        setStateDialog(() {
                          fechaMovimiento = nuevaFecha;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  final monto = double.tryParse(montoController.text);

                  if (monto == null || monto <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Ingrese un monto válido'),
                      ),
                    );
                    return;
                  }

                  agregarTransaccion(
                    tipo,
                    monto,
                    descController.text.isEmpty
                        ? 'Sin descripción'
                        : descController.text,
                    categoria,
                    fechaMovimiento,
                  );

                  Navigator.pop(context);
                },
                child: const Text('Guardar'),
              ),
            ],
          );
        },
      );
    },
  );
}
