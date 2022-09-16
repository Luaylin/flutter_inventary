import 'package:flutter/material.dart';
import 'package:flutter_inventary/src/router/main.dart';
import 'package:go_router/go_router.dart';
import 'package:data_table_2/data_table_2.dart';

class HomePage extends StatelessWidget {
  List<List<String>> content = [
    ["1", "2", "3"],
    ["3", "2", "1"],
    ["2", "1", "3"]
  ];
  String title;
  HomePage(this.title);
  @override
  Widget build(BuildContext context) {
    final DataTableSource _data = MyData(content);
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Container(
          margin: const EdgeInsets.only(
              top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => context.go('/' + routes["incomeMovement"]),
                    child: const Text('Registrar Ingresos'),
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () => context.go('/' + routes["incomeDetails"]),
                    child: const Text('Registrar Salidas'),
                  )
                ],
              ),
              Form(
                  child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.abc),
                      labelText: 'Codigo de Registro',
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.abc),
                      labelText: 'DNI Usuario',
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.abc),
                      labelText: 'Nombres y Apellidos de Usuario',
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.abc),
                      labelText: 'Fecha de registro',
                    ),
                  ),
                  Text(""),
                  ElevatedButton(
                    onPressed: () => context.go('/' + routes["incomeDetails"]),
                    child: const Text('Filtrar'),
                  ),
                  Text(""),
                ],
              )),
              Expanded(
                  child: PaginatedDataTable2(columns: [
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
              ], source: _data))
            ],
          ),
        ));
  }
}

class MyData extends DataTableSource {
  List<List<String>> _data;
  MyData(this._data);
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index][0])),
      DataCell(Text(_data[index][1])),
      DataCell(Text(_data[index][2])),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
