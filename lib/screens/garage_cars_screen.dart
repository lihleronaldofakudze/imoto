import 'package:flutter/material.dart';
import 'package:imoto/lists/user_main_list.dart';
import 'package:imoto/models/Car.dart';
import 'package:imoto/services/database.dart';
import 'package:provider/provider.dart';

class GarageCarsScreen extends StatelessWidget {
  const GarageCarsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            args['garageName'],
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: StreamProvider<List<Car>>.value(
          value: DatabaseService(uid: args['garageId']).garageCars,
          initialData: [],
          child: UserMainList(),
        ));
  }
}
