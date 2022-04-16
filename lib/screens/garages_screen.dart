import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imoto/models/Garage.dart';
import 'package:imoto/widgets/drawer.dart';
import 'package:imoto/widgets/popup_menu_widget.dart';
import 'package:provider/provider.dart';

class GaragesScreen extends StatelessWidget {
  const GaragesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _garages = Provider.of<List<Garage>>(context);
    return Scaffold(
      drawer: drawer(context: context),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Garages',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
              icon: Icon(Icons.search_rounded)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notifications');
              },
              icon: Icon(Icons.notifications_rounded)),
          popupMenuButton(context: context)
        ],
      ),
      body: ListView.builder(
        itemCount: _garages.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/garage',
                  arguments: _garages[index].id);
            },
            child: Card(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(_garages[index].image),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _garages[index].username,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
