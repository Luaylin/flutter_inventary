import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//HomePage
import 'package:flutter_inventary/src/views/HomePage/main.dart';
//DetailsPage
import 'package:flutter_inventary/src/views/DetailsPage/main.dart';
//MovementPage
import 'package:flutter_inventary/src/views/MovementPage/main.dart';
//IncomeMovementPage
import 'package:flutter_inventary/src/views/IncomeMovementPage/main.dart';
//IncomeDetailsPage
import 'package:flutter_inventary/src/views/IncomeDetailsPage/main.dart';
//OutputMovementPage
import 'package:flutter_inventary/src/views/OutputMovementPage/main.dart';
//OutputDetailsPage
import 'package:flutter_inventary/src/views/OutputDetailsPage/main.dart';
//ConfirmationPage
import 'package:flutter_inventary/src/views/ConfirmationPage/main.dart';

Map routes = {
  "home": "/",
  "details": "details",
  "movement": "movement",
  "incomeMovement": "income_movement",
  "incomeDetails": "income_details",
  "outputMovement": "output_movement",
  "outputDetails": "output_details",
  "confirmation": "confirmation"
};

Map titles = {
  "home": "Pagina Principal",
  "details": "Detalles",
  "movement": "Movimientos",
  "incomeMovement": "Registrar Ingreso",
  "incomeDetails": "Registrar Detalles de Ingreso",
  "outputMovement": "Registrar Salida",
  "outputDetails": "Registrar Detalles de Salida",
  "confirmation": "Pagina de Confirmación"
};

getRouter() {
  return GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: routes["home"],
        builder: (BuildContext context, GoRouterState state) =>
            HomePage(titles["home"]),
        routes: <GoRoute>[
          //Detalles
          GoRoute(
            path: routes["details"],
            builder: (BuildContext context, GoRouterState state) =>
                DetailsPage(titles["details"]),
          ),
          //Detalles
          GoRoute(
            path: routes["movement"],
            builder: (BuildContext context, GoRouterState state) =>
                MovementPage(titles["movement"]),
          ),
          //Detalles
          GoRoute(
            path: routes["incomeMovement"],
            builder: (BuildContext context, GoRouterState state) =>
                IncomeMovementPage(titles["incomeMovement"]),
          ),
          //Detalles
          GoRoute(
            path: routes["incomeDetails"],
            builder: (BuildContext context, GoRouterState state) =>
                IncomeDetailsPage(titles["incomeDetails"]),
          ),
          //Detalles
          GoRoute(
            path: routes["outputMovement"],
            builder: (BuildContext context, GoRouterState state) =>
                OutputMovementPage(titles["outputMovement"]),
          ),
          //Detalles
          GoRoute(
            path: routes["outputDetails"],
            builder: (BuildContext context, GoRouterState state) =>
                OutputDetailsPage(titles["outputDetails"]),
          ),
          //Detalles
          GoRoute(
            path: routes["confirmation"],
            builder: (BuildContext context, GoRouterState state) =>
                ConfirmationPage(titles["confirmation"]),
          ),
        ],
      ),
    ],
  );
}
