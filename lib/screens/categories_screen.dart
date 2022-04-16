import 'package:flutter/material.dart';
import 'package:imoto/models/BodyType.dart';
import 'package:imoto/widgets/drawer.dart';
import 'package:imoto/widgets/popup_menu_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bodyTypes = [
      BodyType(name: 'Cabriolet', image: 'images/cabriolet.png'),
      BodyType(name: 'Coupe', image: 'images/coupe.png'),
      BodyType(name: 'Fastback', image: 'images/fastback.png'),
      BodyType(name: 'Extended Cab', image: 'images/extended_cab.png'),
      BodyType(name: 'Double Cab', image: 'images/double_cab.png'),
      BodyType(name: 'Crew Bus', image: 'images/crew_bus.png'),
      BodyType(name: 'Hatchback', image: 'images/hatchback.png'),
      BodyType(name: 'King Cab', image: 'images/kingcab.png'),
      BodyType(name: 'LCV', image: 'images/lcv.png'),
      BodyType(name: 'Minibus', image: 'images/minibus.png'),
      BodyType(name: 'MPV', image: 'images/mpv.png'),
      BodyType(name: 'Panel Van', image: 'images/panel_van.png'),
      BodyType(name: 'Sedan', image: 'images/sedan.png'),
      BodyType(name: 'Single Cab', image: 'images/single_cab.png'),
      BodyType(name: 'Sportsback', image: 'images/sportsback.png'),
      BodyType(name: 'Station Wagon', image: 'images/station_wagon.png'),
      BodyType(name: 'Supercab', image: 'images/supercab.png'),
      BodyType(name: 'SUV', image: 'images/suv.png'),
    ];
    return Scaffold(
      drawer: drawer(context: context),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Categories',
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: _bodyTypes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: MediaQuery.of(context).size.width / 410),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/category',
                    arguments: _bodyTypes[index].name);
              },
              child: Card(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(_bodyTypes[index].image),
                              fit: BoxFit.scaleDown)),
                    ),
                    Text(
                      _bodyTypes[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
