import 'package:flutter/material.dart';
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
                onPressed: () => context.go('/inventary'),
                child: const Text('Go to inventary'),
              ),
            ],
          ),
        ),
      );
}
