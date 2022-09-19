import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Example without a datasource
class CustomTable extends StatelessWidget {
  List<String> headers;
  List<List<String>> content;
  String? countName;
  CustomTable(this.headers, this.content, this.countName);

  List<DataColumn> WriteHeaders() {
    List<DataColumn> response = [];
    if (countName != null) {
      response.add(DataColumn(label: Text(countName!)));
    }
    for (var i = 0; i < headers.length; i++) {
      response.add(DataColumn(label: Text(headers[i])));
    }
    return response;
  }

  List<DataRow> WriteContent() {
    List<DataRow> response = [];
    List<DataCell> aux = [];
    for (var i = 0; i < content.length; i++) {
      if (countName != null) aux.add(DataCell(Text((i + 1).toString())));
      for (var j = 0; j < content[i].length; j++) {
        aux.add(DataCell(Text(content[i][j])));
      }
      response.add(DataRow(cells: aux));
      aux = [];
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          columns: WriteHeaders(),
          rows: WriteContent(),
        ));
  }
}
