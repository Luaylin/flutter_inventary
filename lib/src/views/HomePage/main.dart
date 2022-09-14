import 'package:flutter/material.dart';
import 'package:flutter_inventary/src/router/main.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  /// Creates a [Page1Screen].
  String title;
  HomePage(this.title);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => context.go('/' + routes["incomeMovement"]),
                child: const Text('Registrar Ingresos'),
              ),
              ElevatedButton(
                onPressed: () => context.go('/' + routes["incomeDetails"]),
                child: const Text('Registrar Salidas'),
              ),
            ],
          ),
        ),
      );
}
