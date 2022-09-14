import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_inventary/src/views/IncomeMovementPage/components/user_data.dart';

class IncomeMovementPage extends StatelessWidget {
  /// Creates a [Page2Screen].
  String title;
  IncomeMovementPage(this.title);

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: Text(title)), body: new UserData());
}
