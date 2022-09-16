import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmationPage extends StatelessWidget {
  String title;
  Map data;
  ConfirmationPage(this.title, this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            data["success"]
                ? Icon(
                    Icons.check_circle_outline,
                    color: Color.fromARGB(255, 14, 197, 7),
                    size: 200,
                  )
                : Icon(Icons.error_outline_sharp,
                    color: Color.fromARGB(255, 219, 11, 11), size: 200),
            Text(""),
            Text(data["message"], style: TextStyle(fontSize: 25)),
            Text(""),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (data["redirection"] != "")
                  ElevatedButton(
                    onPressed: () {
                      context.go(data["redirection"]);
                    },
                    child: Text(data["redirection_message"],
                        style: TextStyle(fontSize: 17)),
                  ),
                if (data["redirection"] != "") const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () {
                    context.go('/');
                  },
                  child: Text("Ir al Inicio", style: TextStyle(fontSize: 17)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
