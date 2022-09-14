import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OutputMovementPage extends StatelessWidget {
  String title;
  OutputMovementPage(this.title);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text("OutputMovementPage")],
          ),
        ),
      );
}
