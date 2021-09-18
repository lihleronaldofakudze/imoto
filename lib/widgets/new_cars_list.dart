import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imoto/models/Car.dart';
import 'package:provider/provider.dart';

class NewCarsList extends StatelessWidget {
  const NewCarsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<List<Car>>(context);
    return ListView.builder(
      itemCount: cars.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(cars[index].images[1]),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'E ${cars[index].price}0',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '${cars[index].model}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
