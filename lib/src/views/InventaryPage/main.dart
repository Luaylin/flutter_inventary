import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InventaryPage extends StatelessWidget {
  /// Creates a [Page2Screen].
  String title;
  InventaryPage(this.title);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Go back to home page'),
              ),
            ],
          ),
        ),
      );
}
