import 'package:flutter/material.dart';
import 'package:imoto/models/Garage.dart';
import 'package:imoto/services/database.dart';
import 'package:imoto/widgets/loading_widget.dart';

class GarageScreen extends StatelessWidget {
  const GarageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final garageId = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<Garage>(
      stream: DatabaseService(uid: garageId).garage,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Garage? garage = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Agent Garage',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(garage!.image),
                            fit: BoxFit.cover)),
                  ),
                  ListTile(
                    title: Text('Agent Name'),
                    subtitle: Text(
                      garage.username,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Agent Email Address'),
                    subtitle: Text(
                      garage.email,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Agent Phone Number'),
                    subtitle: Text(
                      garage.number,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Agent Type'),
                    subtitle: Text(
                      garage.type,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Agent Address'),
                    subtitle: Text(
                      garage.address,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/garage_cars',
                                arguments: {
                                  'garageId': garage.id,
                                  'garageName': garage.username
                                });
                          },
                          child: Column(
                            children: [
                              Text(
                                'Cars Uploaded',
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                garage.cars.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/garage_parts',
                                arguments: {
                                  'garageId': garage.id,
                                  'garageName': garage.username
                                });
                          },
                          child: Column(
                            children: [
                              Text('Parts Uploaded',
                                  style: TextStyle(fontSize: 16)),
                              Text(
                                garage.parts.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}
