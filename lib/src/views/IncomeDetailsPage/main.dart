import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IncomeDetailsPage extends StatelessWidget {
  String title;
  IncomeDetailsPage(this.title);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text("IncomeDetailsPage")],
          ),
        ),
      );
}
