import 'package:flutter/material.dart';
import 'package:flutter_inventary/src/widgets/custom_table.dart';
//import 'package:go_router/go_router.dart';

class DetailsPage extends StatelessWidget {
  String title;
  final List<String> _headers = [
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

  final List<List<String>> _content = [];

  DetailsPage(this.title);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: CustomTable(_headers, _content, "N° de Orden"))
            ],
          ),
        ),
      );
}
