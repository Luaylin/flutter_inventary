import 'package:flutter/material.dart';
import 'package:flutter_inventary/src/router/main.dart';
import 'package:go_router/go_router.dart';
import 'package:data_table_2/data_table_2.dart';

class HomePage extends StatefulWidget {
  const HomePage({this.title = ''});
  final String title;
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<List<String>> content = [
    ["1", "2", "3", "1", "2", "3"],
    ["1", "2", "3", "1", "2", "3"],
    ["1", "2", "3", "1", "2", "3"],
  ];
  @override
  Widget build(BuildContext context) {
    final DataTableSource _data = MyData(content, context);
    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Container(
          margin: const EdgeInsets.only(
              top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => context.go('/${routes["incomeMovement"]}'),
                    child: const Text('Registrar Ingresos'),
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () async =>
                        context.go('/${routes["incomeDetails"]}'),
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
                  const Text(""),
                  ElevatedButton(
                    onPressed: () => context.go('/${routes["incomeDetails"]}'),
                    child: const Text('Filtrar'),
                  ),
                  const Text(""),
                ],
              )),
              Expanded(
                  child: PaginatedDataTable2(columns: const [
                DataColumn(
                    label: Center(
                  child: Text('Código de Registro'),
                )),
                DataColumn(
                    label: Center(
                  child: Text('Usuario'),
                )),
                DataColumn(
                    label: Center(
                  child: Text('Organo o Unidad Organica'),
                )),
                DataColumn(
                    label: Center(
                  child: Text('Local o Sede'),
                )),
                DataColumn(
                    label: Center(
                  child: Text('Fecha'),
                )),
                DataColumn(
                    label: Center(
                  child: Text('Acciones'),
                )),
              ], source: _data))
            ],
          ),
        ));
  }
}

class MyData extends DataTableSource {
  final List<List<String>> _data;
  BuildContext context;
  MyData(this._data, this.context);
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index][0])),
      DataCell(Text(_data[index][1])),
      DataCell(Text(_data[index][2])),
      DataCell(Text(_data[index][3])),
      DataCell(Text(_data[index][4])),
      DataCell(
        Center(
          child: ElevatedButton(
            onPressed: () => context.go('/${routes["movement"]}'),
            child: const Text('Visualizar'),
          ),
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
