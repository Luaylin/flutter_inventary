import 'package:flutter/material.dart';
import 'package:flutter_inventary/src/views/IncomeDetailsPage/components/data_details.dart';

class IncomeDetailsPage extends StatelessWidget {
  String title;
  Map dataMovement;
  IncomeDetailsPage(this.title, this.dataMovement);
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: const <Widget>[
          Expanded(child: DataDetails()),
        ],
      ));
}
