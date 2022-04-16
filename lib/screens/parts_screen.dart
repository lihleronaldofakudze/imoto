import 'package:flutter/material.dart';
import 'package:imoto/lists/parts_list.dart';

class PartsScreen extends StatelessWidget {
  const PartsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/sell_part');
        },
        label: Text(
          'Sell Car Part',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        icon: Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Car Parts',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded))
        ],
      ),
      body: PartList(),
    );
  }
}
