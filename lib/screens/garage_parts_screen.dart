import 'package:flutter/material.dart';
import 'package:imoto/lists/user_part_list.dart';
import 'package:imoto/models/Part.dart';
import 'package:imoto/services/database.dart';
import 'package:provider/provider.dart';

class GaragePartsScreen extends StatelessWidget {
  const GaragePartsScreen({Key? key}) : super(key: key);

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
        body: StreamProvider<List<Part>>.value(
          value: DatabaseService(uid: args['garageId']).garageParts,
          initialData: [],
          child: UserPartList(),
        ));
  }
}
