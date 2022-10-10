import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_inventary/src/router/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:localstorage/localstorage.dart';

void main() async {
  //Load the .env File
  await dotenv.load(fileName: "../.env");
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  runApp(App());
}

LocalStorage storage = new LocalStorage('localstorage_app');

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  static const String title = 'Inventary Application';

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: title,
      );

  final GoRouter _router = getRouter();
}
