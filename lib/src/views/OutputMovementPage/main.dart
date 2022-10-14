import 'package:flutter/material.dart';
import 'package:flutter_inventary/src/controller/httpRequest/main.dart';
import 'package:flutter_inventary/src/utils/main.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_inventary/src/views/IncomeMovementPage/components/user_data.dart';
import 'package:flutter_inventary/src/router/main.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class OutputMovementPage extends StatelessWidget {
  String title;

  int? id;

  OutputMovementPage(this.title, {super.key, this.id});

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

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(title)),
      floatingActionButton: id != null
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Añadir Detalles"),
                          scrollable: true,
                          content: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                  width: 500,
                                  child: Form(
                                      key: _key,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: TextFormField(
                                                  controller: txt[0],
                                                  decoration:
                                                      const InputDecoration(
                                                    icon: Icon(Icons
                                                        .branding_watermark_rounded),
                                                    labelText:
                                                        'Codigo Patrimonial',
                                                  ),
                                                  onSaved: (String? value) {
                                                    data["patrimonial"] =
                                                        value == null ||
                                                                value == ""
                                                            ? "S/C"
                                                            : value;
                                                  },
                                                  validator: (String? value) {
                                                    return null;
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: TextFormField(
                                                  controller: txt[1],
                                                  decoration:
                                                      const InputDecoration(
                                                    icon: Icon(Icons.abc),
                                                    labelText: 'Denominación *',
                                                  ),
                                                  onSaved: (String? value) {
                                                    data["denomination"] =
                                                        value;
                                                  },
                                                  validator: (String? value) {
                                                    return validateSimpleInputString(
                                                        value);
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
                                                  decoration:
                                                      const InputDecoration(
                                                    icon: Icon(Icons
                                                        .add_chart_outlined),
                                                    labelText: 'Marca',
                                                  ),
                                                  onSaved: (String? value) {
                                                    data["mark"] = value;
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
                                                  controller: txt[3],
                                                  decoration:
                                                      const InputDecoration(
                                                    icon: Icon(
                                                        Icons.model_training),
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
                                                  decoration:
                                                      const InputDecoration(
                                                    icon:
                                                        Icon(Icons.color_lens),
                                                    labelText: 'Color *',
                                                  ),
                                                  onSaved: (String? value) {
                                                    data["color"] = value;
                                                  },
                                                  validator: (String? value) {
                                                    return validateSimpleInputString(
                                                        value);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: TextFormField(
                                                  controller: txt[5],
                                                  decoration:
                                                      const InputDecoration(
                                                    icon: Icon(
                                                        Icons.qr_code_scanner),
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
                                                  decoration:
                                                      const InputDecoration(
                                                    icon: Icon(Icons
                                                        .error_outline_sharp),
                                                    labelText: 'Otros',
                                                  ),
                                                  onSaved: (String? value) {
                                                    data["others"] = value;
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
                                                  controller: txt[7],
                                                  decoration:
                                                      const InputDecoration(
                                                    icon: Icon(Icons.abc),
                                                    labelText: 'Conser.',
                                                  ),
                                                  onSaved: (String? value) {
                                                    data["conservation"] =
                                                        value;
                                                  },
                                                  validator: (String? value) {
                                                    return validateStringLengthInput(
                                                        value, 1);
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                          TextFormField(
                                            controller: txt[8],
                                            decoration: const InputDecoration(
                                              icon: Icon(
                                                  Icons.crisis_alert_sharp),
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
                                                  onPressed: () async {
                                                    //Manda a la pagina recargando los nuevos datos
                                                    if (_key.currentState!
                                                        .validate()) {
                                                      _key.currentState!.save();
                                                      var response =
                                                          await sendPostHTTPRequest(
                                                              '/detail',
                                                              'asd', {
                                                        "moveId": id,
                                                        "codePatrimonial":
                                                            data["patrimonial"],
                                                        "denomination": data[
                                                            "denomination"],
                                                        "marca": data["mark"],
                                                        "model": data["model"],
                                                        "color": data["color"],
                                                        "series": data["serie"],
                                                        "others":
                                                            data["others"],
                                                        "condition": data[
                                                            "conservation"],
                                                        "observation": data[
                                                            "observations"],
                                                        "canceled": 0
                                                      });
                                                      if (response["status"]) {
                                                        print("Correcto");
                                                        context.push('/in/$id');
                                                      }
                                                    }
                                                  },
                                                  child: const Text(
                                                      '+ Añadir al listado'),
                                                ),
                                              ],
                                            )),
                                          ),
                                        ],
                                      )))
                            ],
                          ),
                        ));
              })
          : null,
      body: UserData(id: id));
}
