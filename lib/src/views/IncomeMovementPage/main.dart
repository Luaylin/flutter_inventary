import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_inventary/src/views/IncomeMovementPage/components/user_data.dart';
import 'package:flutter_inventary/src/router/main.dart';

class IncomeMovementPage extends StatelessWidget {
  
    String title;

    int? id;

    IncomeMovementPage(this.title, {super.key, this.id});

    @override
    Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        floatingActionButton: id!=null?FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
                context.go('/in/' + id.toString() + '/detail/create');
            }):null,
        body: UserData(id: id)
    );

}
