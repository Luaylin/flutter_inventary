import 'dart:html' as html;
import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inventary/main.dart';
import 'package:flutter_inventary/src/controller/httpRequest/main.dart';
import 'package:flutter_inventary/src/views/IncomeMovementPage/detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:gra_utils/gra_utils.dart';
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
  "ins": "in",
  "in_create": "in/create",
  "in_detail_create": "in/:id/detail/create",
  "out_create": "out/create",
  "out": "out/:id",
  "outs": "out",
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
  http2.API_URL = 'http://web.regionancash.gob.pe/api/inventary';

  return GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: "/",
        builder: (BuildContext context, GoRouterState state) {
          return FutureBuilder(
            future: storage.ready,
            builder: (BuildContext context, snapshot) {
              if (snapshot.data == true) {
                var token = storage.getItem('token');

                print('as tol=' + token.toString());
                if (token == null) {
                  final query = state.queryParametersAll;
                  dynamic code = query["code"];
                  html.Location location = html.window.location;
                  if (code == null) {
                    location.replace(
                        '${dotenv.env['OAUTH_URL']}authorize?response_type=code&client_id=${dotenv.env['OAUTH_CLIENT_ID']}&scope=profile');
                    return HomePage(title: "error");
                  } else {
                    http2.post('/token', {'code': code[0]}).then((response) {
                      var result = jsonDecode(response.body);
                      print(response.body);
                      token = result['access_token'];
                      if (token != null) {
                        storage.setItem("token", token);

                        html.window.location.replace(
                            '${location.protocol}//${location.host}${location.pathname ?? ''}');
                      }
                    });
                    return HomePage(title: "home");
                  }
                } else {
                  http2.headers['Authorization'] = 'Bearer $token';
                  print(http2.headers);
                  return HomePage(title: "home");
                }
              } else {
                return Text('Loading...');
              }
            },
          );
        },
        routes: <GoRoute>[
          //Detalles
          GoRoute(
            path: "details",
            builder: (BuildContext context, GoRouterState state) =>
                DetailsPage("details"),
          ),
          //Detalles
          GoRoute(
              path: 'in/:id/detail/create',
              builder: (BuildContext context, GoRouterState state) =>
                  DetailFragment(movementId: int.parse(state.params['id']!))),
          GoRoute(
            path: routes["ins"],
            builder: (BuildContext context, GoRouterState state) {
              return FutureBuilder(
                future: storage.ready,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.data == true) {
                    var token = storage.getItem('token');

                    if (token == null) {
                      html.Location location = html.window.location;
                      return HomePage(
                        title: "Ingresos",
                        type: 'I',
                      );
                    } else {
                      http2.headers['Authorization'] = 'Bearer $token';
                      print(http2.headers);
                      return HomePage(
                        title: "Ingresos",
                        type: 'I',
                      );
                    }
                  } else {
                    return Text('Loading...');
                  }
                },
              );
            },
          ),
          //Detalles
          GoRoute(
            path: "in/create",
            builder: (BuildContext context, GoRouterState state) =>
                IncomeMovementPage("Crear Ingreso"),
          ),
          GoRoute(
            path: "in/:id",
            builder: (BuildContext context, GoRouterState state) =>
                IncomeMovementPage("Ver Ingreso",
                    id: int.parse(state.params['id']!)),
          ),
          //Detalles
          GoRoute(
              path: "incomeDetails",
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
                    return ConfirmationPage(titles["confirmation"], const {
                      "success": false,
                      "message": "Error 404",
                      "redirection": "",
                      "redirection_message": ""
                    });
                  }
                } else {
                  return ConfirmationPage(titles["confirmation"], const {
                    "success": false,
                    "message": "Error 404",
                    "redirection": "",
                    "redirection_message": ""
                  });
                }
              }),
          //Detalles
          GoRoute(
              path: "out",
              builder: (BuildContext context, GoRouterState state) {
                return FutureBuilder(
                  future: storage.ready,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.data == true) {
                      var token = storage.getItem('token');

                      if (token == null) {
                        html.Location location = html.window.location;
                        return HomePage(
                          title: "Salidas",
                          type: 'O',
                        );
                      } else {
                        http2.headers['Authorization'] = 'Bearer $token';
                        print(http2.headers);
                        return HomePage(
                          title: "Salidas",
                          type: 'O',
                        );
                      }
                    } else {
                      return Text('Loading...');
                    }
                  },
                );
              }),
          GoRoute(
            path: "out/create",
            builder: (BuildContext context, GoRouterState state) =>
                OutputMovementPage("Registrar salida"),
          ),
          //Detalles
          GoRoute(
            path: "outputDetails",
            builder: (BuildContext context, GoRouterState state) =>
                OutputDetailsPage("outputDetails"),
          ),
          //Detalles
          GoRoute(
              path: "confirmation",
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
                        titles["confirmation"], const {
                      "success": false,
                      "message": "Error 404",
                      "redirection": "",
                      "redirection_message": ""
                    });
                  }
                } else {
                  return ConfirmationPage("confirmation", const {
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
