import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_inventary/src/views/HomePage/main.dart';
import 'package:flutter_inventary/src/views/InventaryPage/main.dart';

getRouter() {
  return GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            HomePage("Pagina principal"),
        routes: <GoRoute>[
          GoRoute(
            path: 'inventary',
            builder: (BuildContext context, GoRouterState state) =>
                InventaryPage("Vista de inventario"),
          ),
        ],
      ),
    ],
  );
}
