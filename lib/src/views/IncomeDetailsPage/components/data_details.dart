import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_inventary/src/utils/main.dart';
import 'package:flutter_inventary/src/widgets/custom_table.dart';

class DataDetails extends StatefulWidget {
  const DataDetails();
  @override
  State<DataDetails> createState() => _DataDetails();
}

class _DataDetails extends State<DataDetails> {
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

  List<List<String>> _content = [];

  void grow(headers, content) {
    setState(() {
      _headers = headers;
      _content = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    final details_form = Form(
        key: _key,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.branding_watermark_rounded),
                labelText: 'Codigo Patrimonial *',
              ),
              onSaved: (String? value) {
                data["patrimonial"] = value;
              },
              validator: (String? value) {
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.abc),
                labelText: 'Denominación *',
              ),
              onSaved: (String? value) {
                data["denomination"] = value;
              },
              validator: (String? value) {
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.add_chart_outlined),
                labelText: 'Marca *',
              ),
              onSaved: (String? value) {
                data["mark"] = value;
              },
              validator: (String? value) {
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.model_training),
                labelText: 'Modelo *',
              ),
              onSaved: (String? value) {
                data["model"] = value;
              },
              validator: (String? value) {
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.color_lens),
                labelText: 'Color *',
              ),
              onSaved: (String? value) {
                data["color"] = value;
              },
              validator: (String? value) {
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.qr_code_scanner),
                labelText: 'Serie *',
              ),
              onSaved: (String? value) {
                data["serie"] = value;
              },
              validator: (String? value) {
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.error_outline_sharp),
                labelText: 'Otros *',
              ),
              onSaved: (String? value) {
                data["others"] = value;
              },
              validator: (String? value) {
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.abc),
                labelText: 'Conser. *',
              ),
              onSaved: (String? value) {
                data["conservation"] = value;
              },
              validator: (String? value) {
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.crisis_alert_sharp),
                labelText: 'Observaciones *',
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
                      }
                    },
                    child: const Text('+ Añadir al listado'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        _key.currentState!.save();
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
            Expanded(child: CustomTable(_headers, _content, null))
          ],
        ));
    return data_details;
  }
}
