import 'package:flutter/material.dart';
import 'package:flutter_inventary/src/controller/httpRequest/main.dart';
import 'package:intl/intl.dart';
import 'package:flutter_inventary/src/router/main.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_inventary/src/utils/main.dart';
import 'package:go_router/go_router.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:collection/collection.dart';

class UserData extends StatelessWidget {

  final dateFormat = DateFormat("yyyy-MM-dd");

  Axis orientation = Axis.vertical;

  int? id;

  UserData({this.id});

  final Map dataForm = {
    "fullname": "",
    "document": "",
    "email": "",
    "unit": "",
    "local": "",
    "reference": "",
    "date": "",
    "cod": ""
  };

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = false;

    Widget Flex2(List<Widget> children) {
      if (isScreenWide) {
        return Row(
          children: children.map<Widget>((e) => Expanded(child: e)).toList(),
        );
      }
      return Flex(direction: Axis.vertical, children: children);
    }

    List _data = [];
    String str(o) {
      return o != null ? o.toString() : '';
    }

    List _selected = [];
    for (var i = 0; i < 10; i++) {
      _data.add({
        'id': (i + 1).toString(),
        'denomination': 'denomination-' + str(i + 1),
        'marca': 'marca ' + i.toString(),
        'model': 'modelo ' + i.toString(),
        'color': 'green'
      });
      _selected.add(false);
    }

    return OrientationBuilder(builder: (context, orientation) {
      isScreenWide = MediaQuery.of(context).size.width >= 500;

      return Form(
          key: _key,
          child: Column(children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Column(children: [
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(children: [
                    Flex2(
                      [
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.badge_outlined),
                            labelText: 'DNI *',
                          ),
                          onSaved: (String? value) {
                            dataForm["document"] = value;
                          },
                          validator: (String? value) {
                            return validateDNIInput(value);
                          },
                        ),
                        //Fullname
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person_pin_outlined),
                            labelText: 'Nombres y Apellidos *',
                          ),
                          onSaved: (String? value) {
                            dataForm["fullname"] = value;
                          },
                          validator: (String? value) {
                            return validateSimpleInputString(value);
                          },
                        ),
                      ],
                    ),
                    Flex2(
                      [
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email),
                            labelText: 'Correo Electronico *',
                          ),
                          onSaved: (String? value) {
                            dataForm["email"] = value;
                          },
                          validator: (String? value) {
                            return validateEmailInput(value);
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.account_balance_outlined),
                            labelText: 'Organo o Unidad Organica *',
                          ),
                          onSaved: (String? value) {
                            dataForm["unit"] = value;
                          },
                          validator: (String? value) {
                            return validateSimpleInputString(value);
                          },
                        )
                      ],
                    ),
                    Flex2(
                      [
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.add_location),
                            labelText: 'Local o Sede *',
                          ),
                          onSaved: (String? value) {
                            dataForm["local"] = value;
                          },
                          validator: (String? value) {
                            return validateSimpleInputString(value);
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.abc),
                            labelText: 'Referencia *',
                          ),
                          onSaved: (String? value) {
                            dataForm["reference"] = value;
                          },
                          validator: (String? value) {
                            return validateSimpleInputString(value);
                          },
                        )
                      ],
                    ),
                    Flex2(
                      [
                        DateTimeField(
                          format: dateFormat,
                          onSaved: (DateTime? value) {
                            if (value != null) {
                              dataForm["date"] =
                                  '${dateFormat.format(value)} 00:00:00';
                            } else {
                              dataForm["date"] = "";
                            }
                          },
                          validator: (DateTime? value) {
                            return validateCompleteDateTimeInput(value);
                          },
                          decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_month_outlined),
                              labelText: "Fecha de Movimiento *"),
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime(2100));
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.qr_code),
                            labelText: 'Codigo de Registro *',
                          ),
                          onSaved: (String? value) {
                            dataForm["cod"] = value;
                          },
                          validator: (String? value) {
                            return validateSimpleInputString(value);
                          },
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.save),
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
                                _key.currentState!.save();
                                var response =
                                    await sendPostHTTPRequest('/in', '', {
                                  "company": dataForm["unit"],
                                  "date": dataForm["date"],
                                  "dependence": dataForm["local"],
                                  "dni": dataForm["document"],
                                  "email": dataForm["email"],
                                  "fullName": dataForm["fullname"],
                                  "reference": dataForm["reference"],
                                  "uid": dataForm["cod"]
                                });
                                if (response["status"]) {
                                  context.go(
                                      '/${routes["incomeDetails"]}?${convertMapToQuery(dataForm)}');
                                }
                              }
                            },
                            label: const Text('Grabar'),
                          )),
                    ),
                  ])),
              Container(
                  height: 320,
                  child: DataTable2(
                    columnSpacing: 12,
                    headingTextStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    headingRowColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.black),
                    horizontalMargin: 12,
                    minWidth: 600,
                    columns: [
                      DataColumn2(
                        label: Text('N°'),
                        size: ColumnSize.S,
                      ),
                      DataColumn2(label: Text('Codigo'), size: ColumnSize.M),
                      DataColumn2(label: Text('Denominación'), fixedWidth: 200),
                      DataColumn(label: Text('Marca')),
                      DataColumn(label: Text('Modelo')),
                      DataColumn(label: Text('Color')),
                    ],
                    rows: _data
                        .mapIndexed((index, item) => DataRow(
                                cells: [
                                  DataCell(Text(str(index + 1))),
                                  DataCell(Text(str(item['codePatrimonial']))),
                                  DataCell(Text(str(item['denomination']))),
                                  DataCell(Text(str(item['marca']))),
                                  DataCell(Text(str(item['model']))),
                                  DataCell(Text(str(item['color'])))
                                ],
                                selected: _selected[index],
                                onSelectChanged: (bool? selected) {
                                  print(selected);

                                  ///setState(() {
                                  // bool old = isSelected();
                                  _selected[index] = selected!;
                                  // if (old != isSelected())
                                  // widget.buildAction!(actions: getActions());
                                  //});/
                                }))
                        .toList(),
                  ))
            ])))
          ]));
    });
  }
}
