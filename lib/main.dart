import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Crea un Widget Form
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Crea una clase State correspondiente. Esta clase contendrá los datos relacionados con
// el formulario.
class MyCustomFormState extends State<MyCustomForm> {
  // Crea una clave global que identificará de manera única el widget Form
  // y nos permita validar el formulario
  //
  // Nota: Esto es un GlobalKey<FormState>, no un GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Crea un widget Form usando el _formKey que creamos anteriormente
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("CODIGO PATRIMONIAL"),
          TextFormField(
            onSaved: (String? value) {
              dataTemp[0] = value.toString();
            },
          ),
          const Text("DENOMINACIÓN"),
          TextFormField(
            onSaved: (String? value) {
              dataTemp[1] = value.toString();
            },
          ),
          const Text("MARCA"),
          TextFormField(
            onSaved: (String? value) {
              dataTemp[2] = value.toString();
            },
          ),
          const Text("MODELO"),
          TextFormField(
            onSaved: (String? value) {
              dataTemp[3] = value.toString();
            },
          ),
          const Text("COLOR"),
          TextFormField(
            onSaved: (String? value) {
              dataTemp[4] = value.toString();
            },
          ),
          const Text("SERIE"),
          TextFormField(
            onSaved: (String? value) {
              dataTemp[5] = value.toString();
            },
          ),
          const Text("OTROS"),
          TextFormField(
            onSaved: (String? value) {
              dataTemp[6] = value.toString();
            },
          ),
          const Text("CONSER."),
          TextFormField(
            onSaved: (String? value) {
              dataTemp[7] = value.toString();
            },
          ),
          const Text("OBSERVACIONES"),
          TextFormField(
            onSaved: (String? value) {
              dataTemp[8] = value.toString();
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                _data.add({
                  "cod": "dataTemp[0]",
                  "denom": "dataTemp[1]",
                  "marca": "dataTemp[2]",
                });
              },
              child: Text('Añadir a tabla'),
            ),
          ),
          DataTable2(
              columnSpacing: 12,
              headingTextStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              headingRowColor:
                  MaterialStateProperty.resolveWith((states) => Colors.black),
              horizontalMargin: 12,
              minWidth: 600,
              columns: [
                DataColumn2(
                  label: Text('Column A'),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                    label: Text('Column B'),
                    size: ColumnSize.L,
                    fixedWidth: 200),
                DataColumn(
                  label: Text('Column C'),
                ),
                DataColumn(
                  label: Text('Column D'),
                ),
                DataColumn(
                  label: Text('Column NUMBERS'),
                  numeric: true,
                ),
              ],
              rows: _data
                  .map((book) => DataRow(
                        cells: [
                          DataCell(Text(book['code'].toString())),
                          DataCell(Text(book['fullName'].toString())),
                          DataCell(Text(book['address'].toString())),
                          DataCell(Text(book['address'].toString())),
                          DataCell(Text(book['address'].toString()))
                        ],
                      ))
                  .toList()),
        ],
      ),
    );
  }

  List<DataColumn> columns = [
    const DataColumn(
      label: Text('Column C'),
    ),
    const DataColumn(
      label: Text('Column D'),
    ),
    const DataColumn(
      label: Text('Column NUMBERS'),
    ),
  ];

  List<Map> _data = [
    {"code": "a", "denom": "b", "marca": "c"}
  ];
  var dataTemp = ["", "", "", "", "", "", "", "", ""];

  List<DataRow> _createRows() {
    List<DataRow> response = [];
    for (var i = 0; i < _data.length; i++) {
      response.add(DataRow(cells: [
        DataCell(Text(_data[i]['code'].toString())),
        DataCell(Text(_data[i]['denom'].toString())),
        DataCell(Text(_data[i]['marca'].toString())),
      ]));
    }
    return response;
  }

  var data = ["", "", "", "", "", "", "", "", ""];
}
