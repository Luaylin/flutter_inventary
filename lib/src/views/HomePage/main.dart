import 'package:flutter/material.dart';
import 'package:flutter_inventary/src/controller/httpRequest/main.dart';
import 'package:flutter_inventary/src/router/main.dart';
import 'package:go_router/go_router.dart';
import 'package:data_table_2/data_table_2.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({this.title = ''});

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
      sendGetHTTPRequest('/0/0', 'a').then((value) {
        sendGetHTTPRequest('/0/${value["data"]["size"]}', 'asd').then((value2) {
          grow(value2["data"]["data"]);
          if (value2["status"]) {
            flag = true;
          }
        });
      });
    }
    final DataTableSource _data = MyData(content, context);
    TextStyle ts = TextStyle(color: Colors.white);
    return Scaffold(
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text("Header")),
            ListTile(
              leading: new Icon(Icons.table_chart),
              title: const Text("Ingresos"),
              onTap: () {
                context.go('/' + routes["ins"]);
              },
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  leading: new Icon(Icons.add),
                  title: const Text("Crear"),
                  onTap: () {
                    context.go('/' + routes["in_create"]);
                  },
                )),
            ListTile(
              leading: new Icon(Icons.table_chart),
              title: const Text("Salidas"),
              onTap: () {
                context.go('/' + routes["outs"]);
              },
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  leading: new Icon(Icons.add),
                  title: const Text("Crear"),
                  onTap: () {
                    context.go('/' + routes["outs_create"]);
                  },
                )),
          ],
        )),
        appBar: AppBar(title: Text(widget.title)),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              context.go('/in/create');
            }),
        body: Container(
          child: Column(
            children: [
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
                  child: PaginatedDataTable2(
                      headingRowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.black),
                      columns: [
                        DataColumn(
                            label: Center(
                                child: Text('Código de Registro', style: ts))),
                        DataColumn(
                            label: Center(child: Text('Usuario', style: ts))),
                        DataColumn(
                            label: Center(
                                child: Text('Organo o Unidad Organica',
                                    style: ts))),
                        DataColumn(
                            label:
                                Center(child: Text('Local o Sede', style: ts))),
                        DataColumn(
                            label: Center(child: Text('Fecha', style: ts))),
                        DataColumn(
                            label: Center(child: Text('Acciones', style: ts))),
                      ],
                      source: _data))
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
            onPressed: () => context.go('/in/${_data[index]["id"]}'),
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
