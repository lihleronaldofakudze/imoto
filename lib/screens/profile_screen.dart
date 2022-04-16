import 'package:flutter/material.dart';
import 'package:imoto/models/CurrentUser.dart';
import 'package:imoto/models/Garage.dart';
import 'package:imoto/services/database.dart';
import 'package:imoto/widgets/drawer.dart';
import 'package:imoto/widgets/loading_widget.dart';
import 'package:imoto/widgets/popup_menu_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUser?>(context);

    return StreamBuilder<Garage>(
      stream: DatabaseService(uid: currentUser!.uid).garage,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Garage? garage = snapshot.data;
          return Scaffold(
            drawer: drawer(context: context),
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'My Profile',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/edit_profile');
                    },
                    icon: Icon(Icons.settings_rounded)),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/notifications');
                    },
                    icon: Icon(Icons.notifications_rounded)),
                popupMenuButton(context: context)
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 200,
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
