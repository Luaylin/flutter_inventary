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
              builder: (BuildContext context, GoRouterState state) {
                final query = state.queryParametersAll;
                final Map data = {
                  "fullname": "",
                  "document": "",
                  "email": "",
                  "unit": "",
                  "local": "",
                  "reference": "",
                  "date": "",
                  "cod": ""
                };
                final fullname = query["fullname"],
                    document = query["document"],
                    email = query["email"],
                    unit = query["unit"],
                    local = query["local"],
                    reference = query["reference"],
                    date = query["date"],
                    cod = query["cod"];
                //Valida la estructura del JSON
                if (fullname != null &&
                    document != null &&
                    email != null &&
                    unit != null &&
                    local != null &&
                    reference != null &&
                    date != null &&
                    cod != null) {
                  if (fullname.isNotEmpty &&
                      document.isNotEmpty &&
                      email.isNotEmpty &&
                      unit.isNotEmpty &&
                      local.isNotEmpty &&
                      reference.isNotEmpty &&
                      date.isNotEmpty &&
                      cod.isNotEmpty) {
                    data["fullname"] = fullname[0];
                    data["document"] = document[0];
                    data["email"] = email[0];
                    data["unit"] = unit[0];
                    data["local"] = local[0];
                    data["reference"] = reference[0];
                    data["date"] = date[0];
                    data["cod"] = cod[0];
                    return IncomeDetailsPage(titles["incomeDetails"], data);
                  } else {
                    return ConfirmationPage(titles["confirmation"], {
                      "success": false,
                      "message": "Error 404",
                      "redirection": "",
                      "redirection_message": ""
                    });
                  }
                } else {
                  return ConfirmationPage(titles["confirmation"], {
                    "success": false,
                    "message": "Error 404",
                    "redirection": "",
                    "redirection_message": ""
                  });
                }
              }),
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
              builder: (BuildContext context, GoRouterState state) {
                final query = state.queryParametersAll;
                final Map data = {
                  "success": false,
                  "message": "",
                  "redirection": "",
                  "redirection_message": ""
                };
                final success = query["success"],
                    message = query["message"],
                    redirection = query["redirection"],
                    redirection_message = query["redirection_message"];
                //Valida la estructura del JSON
                if (success != null &&
                    message != null &&
                    redirection != null &&
                    redirection_message != null) {
                  if (success.isNotEmpty &&
                      message.isNotEmpty &&
                      redirection.isNotEmpty &&
                      redirection_message.isNotEmpty) {
                    data["success"] = success[0] == "true" ? true : false;
                    data["message"] = message[0];
                    data["redirection"] = redirection[0];
                    data["redirection_message"] = redirection_message[0];
                    return ConfirmationPage(titles["confirmation"], data);
                  } else {
                    /*Manda a la ruta de error*/ return ConfirmationPage(
                        titles["confirmation"], {
                      "success": false,
                      "message": "Error 404",
                      "redirection": "",
                      "redirection_message": ""
                    });
                  }
                } else {
                  return ConfirmationPage(titles["confirmation"], {
                    "success": false,
                    "message": "Error 404",
                    "redirection": "",
                    "redirection_message": ""
                  });
                }
              }),
        ],
      ),
    ],
  );
}
