import 'package:flutter/material.dart';
import 'package:flutter_inventary/src/controller/httpRequest/main.dart';
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
  List<dynamic> content = [];
  bool flag = false;

  void grow(_content) {
    setState(() {
      content = _content;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!flag) {
      sendGetHTTPRequest('0/0', 'a').then((value) {
        sendGetHTTPRequest('0/${value["data"]["size"]}', 'asd').then((value2) {
          if (value2["status"]) {
            grow(value2["data"]["data"]);
            flag = true;
          }
        });
      });
    }
    final DataTableSource _data = MyData(content, context);
    return Scaffold(
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text("Header")),
            ListTile(
              title: const Text("Registrar Ingresos"),
              onTap: () {
                context.go('/${routes["incomeMovement"]}');
              },
            ),
            ListTile(
              title: const Text("Registrar Salidas"),
              onTap: () {
                context.go('/${routes["incomeDetails"]}');
              },
            )
          ],
        )),
        appBar: AppBar(title: Text(widget.title)),
        body: Container(
          margin: const EdgeInsets.only(
              top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
          child: Column(
            children: <Widget>[
              Form(
                  child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.abc),
                            labelText: 'Codigo de Registro',
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.abc),
                            labelText: 'DNI Usuario',
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.abc),
                            labelText: 'Nombres y Apellidos de Usuario',
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.abc),
                            labelText: 'Fecha de registro',
                          ),
                        ),
                      )
                    ],
                  ),
                  const Text(""),
                  ElevatedButton(
                    onPressed: () {
                      sendGetHTTPRequest('', '').then((value) {
                        if (value["status"]) {
                          grow(value["data"]);
                        }
                      });
                    },
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
  final List<dynamic> _data;
  BuildContext context;
  MyData(this._data, this.context);
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]["uid"] != null ? _data[index]["uid"] : "")),
      DataCell(Text(
          _data[index]["fullName"] != null ? _data[index]["fullName"] : "")),
      DataCell(
          Text(_data[index]["company"] != null ? _data[index]["company"] : "")),
      DataCell(Text(_data[index]["dependence"] != null
          ? _data[index]["dependence"]
          : "")),
      DataCell(Text(_data[index]["date"] != null ? _data[index]["date"] : "")),
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
