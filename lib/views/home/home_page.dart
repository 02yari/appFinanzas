import 'package:flutter/material.dart';
import '../../models/transaccion.dart';
import '../stats/stats_page.dart';
import '../search/search_page.dart';
import '../user/user_page.dart';
import '../../controllers/transaccion_controller.dart';
import '../../utils/transaccion_utils.dart';
import '../../services/transaccion_service.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../../widgets/home_app_bar.dart';
import '../../widgets/opciones_agregar_modal.dart';
import '../../widgets/home_body.dart';

// Pantalla principal.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Estado principal.
class _HomePageState extends State<HomePage> {
  int currentIndex = 1;
  String textoBusqueda = '';
  bool verTodos = false;

  DateTime fechaSeleccionada = DateTime.now();

  List<Transaccion> transacciones = [];

  late TransaccionController controller;

  @override
  void initState() {
    super.initState();
    cargarTransacciones();
  }

  // Obtiene movimientos del día seleccionado.
  List<Transaccion> movimientosDelDia() {
    return transacciones.where((t) {
      return esMismoDia(t.fecha, fechaSeleccionada);
    }).toList();
  }

  // Obtiene movimientos según el modo actual.
  List<Transaccion> movimientosVisibles() {
    if (verTodos) return transacciones;
    return movimientosDelDia();
  }

// Cargar transacciones.
  Future<void> cargarTransacciones() async {
    final data = await TransaccionService.instance.cargarTransacciones();

    setState(() {
      transacciones = data;
    });
  }

// Agregar transacción.
  Future<void> agregarTransaccion(
    String tipo,
    double monto,
    String descripcion,
    String categoria,
    DateTime fecha,
  ) async {
    await TransaccionService.instance.agregarTransaccion(
      tipo: tipo,
      monto: monto,
      descripcion: descripcion,
      categoria: categoria,
      fecha: fecha,
    );

    await cargarTransacciones();

    setState(() {
      fechaSeleccionada = fecha;
      verTodos = false;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Movimiento guardado correctamente'),
        duration: Duration(seconds: 2),
      ),
    );
  }

// Eliminar transacción.
  Future<void> eliminarTransaccion(int id) async {
    await TransaccionService.instance.eliminarTransaccion(id);

    await cargarTransacciones();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Movimiento eliminado'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Decide qué pantalla mostrar.
  Widget obtenerPantallaActual() {
    if (currentIndex == 0) {
      return pantallaEstadisticas(
        balance: controller.calcularBalance(),
        ingresos: controller.totalIngresos(),
        gastosTotales: controller.totalGastos(),
        gastos: controller.gastosPorCategoria(),
      );
    }

    if (currentIndex == 1) {
      return homeBody(
        movimientos: movimientosVisibles(),
        verTodos: verTodos,
        fechaSeleccionada: fechaSeleccionada,
        controller: controller,
        onSeleccionarFecha: (dia) {
          setState(() {
            fechaSeleccionada = dia;
            verTodos = false;
          });
        },
        onToggleVerTodos: () {
          setState(() {
            verTodos = !verTodos;
          });
        },
        eliminarTransaccion: eliminarTransaccion,
      );
    }

    if (currentIndex == 3) {
      return pantallaBuscar(
        transacciones: transacciones,
        textoBusqueda: textoBusqueda,
        onBuscar: (value) {
          setState(() {
            textoBusqueda = value;
          });
        },
        colorCategoria: colorCategoria,
        iconoCategoria: iconoCategoria,
        fechaCorta: fechaCorta,
        eliminarTransaccion: eliminarTransaccion,
      );
    }

    if (currentIndex == 4) {
      return pantallaUsuario();
    }

    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    controller = TransaccionController(
      transacciones: transacciones,
      movimientosVisibles: movimientosVisibles(),
    );

    return Scaffold(
      backgroundColor: const Color(0xfffbf7f2),
      appBar: homeAppBar(),
      body: obtenerPantallaActual(),
      bottomNavigationBar: customBottomNav(
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == 2) {
            mostrarOpcionesAgregar(
              context: context,
              fechaSeleccionada: fechaSeleccionada,
              agregarTransaccion: agregarTransaccion,
              fechaCorta: fechaCorta,
            );
            return;
          }

          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
