import 'package:flutter/material.dart';
import 'package:imoto/models/Car.dart';
import 'package:imoto/services/database.dart';
import 'package:imoto/lists/car_list.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cat = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            cat,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: StreamProvider<List<Car>>.value(
          value: DatabaseService(category: cat).bodyTpe,
          initialData: const [],
          child: const CarList(),
        ));
  }
}
