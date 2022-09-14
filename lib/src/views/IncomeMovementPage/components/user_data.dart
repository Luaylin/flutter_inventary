import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_inventary/src/router/main.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_inventary/src/utils/main.dart';
import 'package:go_router/go_router.dart';

class UserData extends StatelessWidget {
  final dateFormat = DateFormat("yyyy-MM-dd");
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
    final user_data_form = Form(
        key: _key,
        child: Column(
          children: [
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
            //Document
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
            ),
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
            ),
            DateTimeField(
              format: dateFormat,
              onSaved: (DateTime? value) {
                if (value != null) {
                  dataForm["cod"] = dateFormat.format(value);
                } else {
                  dataForm["cod"] = "";
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
            Container(
              margin: const EdgeInsets.only(
                top: 20.0,
              ),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      _key.currentState!.save();
                      //Create Query params
                      context.go('/' +
                          routes["incomeDetails"] +
                          "?" +
                          convertMapToQuery(dataForm));
                    }
                  },
                  child: const Text('Iniciar Registro de listado'),
                ),
              ),
            )
          ],
        ));

    final user_data = Container(
        margin: const EdgeInsets.only(
          right: 20.0,
          left: 20.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "DATOS DEL USUARIO",
            ),
            user_data_form
          ],
        ));
    return user_data;
  }
}
