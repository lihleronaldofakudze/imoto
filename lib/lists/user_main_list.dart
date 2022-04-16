import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imoto/models/Car.dart';
import 'package:imoto/models/CurrentUser.dart';
import 'package:imoto/models/Part.dart';
import 'package:imoto/services/database.dart';
import 'package:provider/provider.dart';

class UserMainList extends StatelessWidget {
  const UserMainList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<List<Car>>(context);
    final currentUser = Provider.of<CurrentUser?>(context);
    return ListView.builder(
      itemCount: cars.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/car', arguments: cars[index].id);
          },
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(cars[index].images[1]),
                          fit: BoxFit.contain)),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: cars[index].uid == currentUser!.uid
                        ? IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                        title: Text('Imoto'),
                                        content: Text(
                                            'Are you sure you want to delete this car'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.green),
                                              )),
                                          TextButton(
                                              onPressed: () async {
                                                await DatabaseService(
                                                        carId: cars[index].id,
                                                        uid: currentUser.uid)
                                                    .deleteCar()
                                                    .then((value) {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              )),
                                        ],
                                      ));
                            },
                            icon: Icon(
                              Icons.delete_rounded,
                              color: Colors.red,
                            ))
                        : IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite_border_rounded)),
                  ),
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
          ),
        );
      },
    );
  }
}
