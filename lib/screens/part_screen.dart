import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imoto/models/Part.dart';
import 'package:imoto/services/database.dart';
import 'package:imoto/widgets/loading_widget.dart';

class PartScreen extends StatelessWidget {
  const PartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final partId = ModalRoute.of(context)!.settings.arguments as String;

    return StreamBuilder<Part>(
      stream: DatabaseService(partId: partId).part,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Part? part = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Part Details',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/garage',
                        arguments: part!.uid);
                  },
                  label: Text(
                    'Garage',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  icon: FaIcon(
                    FontAwesomeIcons.warehouse,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(height: 400.0),
                    items: part!.images.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(i))),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  ListTile(
                    title: Text('Part Car Brand'),
                    subtitle: Text(
                      part.brand,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Part Price'),
                    subtitle: Text(
                      'E ${part.price}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Part Name'),
                    subtitle: Text(
                      part.part,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Part Condition'),
                    subtitle: Text(
                      part.condition,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Share Car : ',
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blue,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.whatsapp,
                            color: Colors.green,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.blueAccent,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.instagram,
                            color: Colors.red,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Contact Part Dealer',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
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
