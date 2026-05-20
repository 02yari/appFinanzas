
# Finanzas App

Aplicación desarrollada en Flutter utilizando arquitectura MVC.

## Estructura del proyecto

- models → estructuras de datos
- views → pantallas
- controllers → lógica de negocio
- services → acceso a datos
- widgets → componentes reutilizables
- utils → funciones auxiliares

## Tecnologías usadas

- Flutter
- SQLite
- fl_chart
- MVC

## Funcionalidades

- Agregar ingresos y gastos
- Ver estadísticas
- Buscar movimientos
- Balance general
- Calendario de movimientos

## Integrantes

- YARIELSY GONZÁLEZ
- JOSÉ MONTERO
- JESÚS QUINTERO
- ALVIN LEZCANO

## Organización de carpetas

lib/
│
├── app/                      → Configuración principal de la aplicación.
│                               Aquí normalmente se inicializa MaterialApp,
│                               rutas, temas y configuraciones globales.
│
├── controllers/              → Controladores de la lógica de negocio.
│                               Conectan las vistas con los datos y cálculos.
│
├── core/                     → Funciones centrales del proyecto.
│   │                           Aquí va la configuración base del sistema.
│   │
│   └── database/             → Manejo de SQLite y base de datos.
│                               Conexiones, tablas y operaciones CRUD.
│
├── models/                   → Modelos de datos.
│                               Representan las estructuras principales
│                               de la aplicación (ejemplo: Transaccion).
│
├── services/                 → Servicios externos o acceso a datos.
│                               Manejan SQLite, APIs, scanner, etc.
│
├── utils/                    → Funciones auxiliares reutilizables.
│                               Formateos, colores, fechas, helpers, etc.
│
├── views/                    → Pantallas principales de la aplicación.
│                               Cada carpeta representa una sección visual.
│   │
│   ├── home/                 → Pantalla principal.
│   │
│   ├── search/               → Pantalla de búsqueda.
│   │
│   ├── stats/                → Pantalla de estadísticas.
│   │
│   └── user/                 → Pantalla de usuario o perfil.
│
├── widgets/                  → Componentes visuales reutilizables.
│                               Botones, tarjetas, formularios,
│                               barras, calendarios, etc.
│
└── main.dart                 → Punto de entrada principal de Flutter.