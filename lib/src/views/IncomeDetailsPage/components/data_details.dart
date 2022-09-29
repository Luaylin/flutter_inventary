import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inventary/src/utils/main.dart';
//import 'package:flutter_inventary/src/controller/httpRequest/main.dart';
//import 'package:go_router/go_router.dart';
//import 'package:flutter_inventary/src/router/main.dart';

class DataDetails extends StatefulWidget {
  const DataDetails();
  @override
  State<DataDetails> createState() => _DataDetails();
}

class _DataDetails extends State<DataDetails> {
  List<TextEditingController> txt = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  List<String> _headers = [
    "CODIGO PRATRIMONIAL",
    "DENOMINACIÓN",
    "MARCA",
    "MODELO",
    "COLOR",
    "SERIE",
    "OTROS",
    "CONSER.",
    "OBSERVACIONES"
  ];

  Map data = {
    "patrimonial": "",
    "denomination": "",
    "mark": "",
    "model": "",
    "color": "",
    "serie": "",
    "others": "",
    "conservation": "",
    "observations": " "
  };

  dynamic countName = "N° DE ORDEN";

  List<List<String>> _content = [];

  void grow(headers, content) {
    setState(() {
      _headers = headers;
      _content = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DataColumn> WriteHeaders() {
      List<DataColumn> response = [];
      if (countName != null) {
        response.add(DataColumn(label: Center(child: Text(countName!))));
      }
      for (var i = 0; i < _headers.length; i++) {
        response.add(DataColumn(label: Center(child: Text(_headers[i]))));
      }
      response.add(const DataColumn(label: Center(child: Text("ACCIONES"))));
      return response;
    }

    List<DataRow> WriteContent() {
      List<DataRow> response = [];
      List<DataCell> aux = [];
      for (var i = 0; i < _content.length; i++) {
        if (countName != null)
          aux.add(DataCell(Center(child: Text((i + 1).toString()))));
        for (var j = 0; j < _content[i].length; j++) {
          if (j == 1) {
            aux.add(DataCell(Text(_content[i][j])));
          } else {
            aux.add(DataCell(Center(child: Text(_content[i][j]))));
          }
        }
        aux.add(DataCell(Center(
            child: ElevatedButton(
          onPressed: () {
            _content.removeAt(i);
            grow(_headers, _content);
          },
          child: const Text('Eliminar'),
        ))));
        response.add(DataRow(cells: aux));
        aux = [];
      }
      return response;
    }

    final details_form = Form(
        key: _key,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: txt[0],
                    decoration: const InputDecoration(
                      icon: Icon(Icons.branding_watermark_rounded),
                      labelText: 'Codigo Patrimonial',
                    ),
                    onSaved: (String? value) {
                      data["patrimonial"] =
                          value == null || value == "" ? "S/C" : value;
                    },
                    validator: (String? value) {
                      return null;
                    },
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    controller: txt[1],
                    decoration: const InputDecoration(
                      icon: Icon(Icons.abc),
                      labelText: 'Denominación *',
                    ),
                    onSaved: (String? value) {
                      data["denomination"] = value;
                    },
                    validator: (String? value) {
                      return validateSimpleInputString(value);
                    },
                  ),
                )
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: txt[2],
                    decoration: const InputDecoration(
                      icon: Icon(Icons.add_chart_outlined),
                      labelText: 'Marca',
                    ),
                    onSaved: (String? value) {
                      data["mark"] = value;
                    },
                    validator: (String? value) {
                      return null;
                    },
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    controller: txt[3],
                    decoration: const InputDecoration(
                      icon: Icon(Icons.model_training),
                      labelText: 'Modelo',
                    ),
                    onSaved: (String? value) {
                      data["model"] = value;
                    },
                    validator: (String? value) {
                      return null;
                    },
                  ),
                )
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: txt[4],
                    decoration: const InputDecoration(
                      icon: Icon(Icons.color_lens),
                      labelText: 'Color *',
                    ),
                    onSaved: (String? value) {
                      data["color"] = value;
                    },
                    validator: (String? value) {
                      return validateSimpleInputString(value);
                    },
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    controller: txt[5],
                    decoration: const InputDecoration(
                      icon: Icon(Icons.qr_code_scanner),
                      labelText: 'Serie',
                    ),
                    onSaved: (String? value) {
                      data["serie"] = value;
                    },
                    validator: (String? value) {
                      return null;
                    },
                  ),
                )
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: txt[6],
                    decoration: const InputDecoration(
                      icon: Icon(Icons.error_outline_sharp),
                      labelText: 'Otros',
                    ),
                    onSaved: (String? value) {
                      data["others"] = value;
                    },
                    validator: (String? value) {
                      return null;
                    },
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    controller: txt[7],
                    decoration: const InputDecoration(
                      icon: Icon(Icons.abc),
                      labelText: 'Conser.',
                    ),
                    onSaved: (String? value) {
                      data["conservation"] = value;
                    },
                    validator: (String? value) {
                      return null;
                    },
                  ),
                )
              ],
            ),
            TextFormField(
              controller: txt[8],
              decoration: const InputDecoration(
                icon: Icon(Icons.crisis_alert_sharp),
                labelText: 'Observaciones',
              ),
              onSaved: (String? value) {
                data["observations"] = value;
              },
              validator: (String? value) {
                return null;
              },
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 20.0,
              ),
              child: Center(
                  child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        _key.currentState!.save();
                        //Create Query params
                        _content.add(convertMapToList(data));
                        grow(_headers, _content);
                        for (var i = 0; i < txt.length; i++) {
                          txt[i].clear();
                        }
                      }
                    },
                    child: const Text('+ Añadir al listado'),
                  ),
                  const SizedBox(width: 30),
                  if (_content.isNotEmpty)
                    ElevatedButton(
                      onPressed: () {
                        if (_content.isNotEmpty) {
                          /*Map response = sendRegisterOfIncome(true);
                          if (response["status"]) {
                            context.go('/' +
                                routes["confirmation"] +
                                '?success=true&message=Registro realizado con exito&redirection=/hola&redirection_message=visualizar');
                          } else {
                            print("Incorrecto");
                          }*/
                        }
                      },
                      child: const Text('Registrar Listado'),
                    ),
                ],
              )),
            ),
          ],
        ));

    final data_details = Container(
        margin: const EdgeInsets.only(
          top: 20.00,
          right: 20.0,
          left: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "REGISTRO DE DETALLES",
            ),
            details_form,
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: DataTable2(
                      columnSpacing: 12,
                      horizontalMargin: 12,
                      minWidth: 600,
                      columns: WriteHeaders(),
                      rows: WriteContent(),
                    )))
          ],
        ));
    return data_details;
  }
}
