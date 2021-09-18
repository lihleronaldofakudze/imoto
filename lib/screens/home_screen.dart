import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imoto/services/auth.dart';
import 'package:imoto/widgets/drawer.dart';
import 'package:imoto/widgets/new_cars_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Imoto',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_rounded)),
          PopupMenuButton<String>(
              onSelected: (selected) {
                switch (selected) {
                  case 'logout':
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Imoto'),
                              content: Text('Are you sure you want to log out'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('No')),
                                TextButton(
                                    onPressed: () {
                                      AuthService().signOut()!.then((value) {
                                        Navigator.pushNamed(context, '/auth');
                                      });
                                    },
                                    child: Text('Yes'))
                              ],
                            ));
                    return;

                  case 'share':
                    return;
                }
              },
              itemBuilder: (context) => [
                    PopupMenuItem<String>(
                        value: 'share',
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0.0),
                          leading: Icon(Icons.share_rounded),
                          title: Text('Share App'),
                        )),
                    PopupMenuItem<String>(
                        value: 'logout',
                        child: ListTile(
                          contentPadding: EdgeInsets.all(0.0),
                          leading: Icon(Icons.logout_rounded),
                          title: Text('Log Out'),
                        )),
                  ])
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: Text(
                'Explore',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
            ),
            Container(height: 280, child: NewCarsList()),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Cars',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(height: 280, child: NewCarsList()),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Cars',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(height: 280, child: NewCarsList()),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Used Cars',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See All',
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(height: 280, child: NewCarsList()),
          ],
        ),
      ),
    );
  }
}
