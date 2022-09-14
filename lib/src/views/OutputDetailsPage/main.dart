import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OutputDetailsPage extends StatelessWidget {
  String title;
  OutputDetailsPage(this.title);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text("OutputDetailsPage")],
          ),
        ),
      );
}
