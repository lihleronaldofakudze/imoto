import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imoto/models/Car.dart';
import 'package:imoto/services/database.dart';
import 'package:imoto/widgets/loading_widget.dart';

class CarScreen extends StatelessWidget {
  const CarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carId = ModalRoute.of(context)!.settings.arguments as String;

    return StreamBuilder<Car>(
      stream: DatabaseService(carId: carId).car,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Car? car = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Car Details',
                style: TextStyle(color: Colors.white),
              ),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/garage',
                        arguments: car!.uid);
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
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(height: 300.0),
                    items: car!.images.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(i), fit: BoxFit.fill)),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  ListTile(
                    title: Text('Car Model'),
                    subtitle: Text(
                      car.model,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Car Brand'),
                    subtitle: Text(
                      car.brand,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Car Price'),
                    subtitle: Text(
                      'E ${car.price}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Car Body Type'),
                    subtitle: Text(
                      car.bodyType,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Car Condition'),
                    subtitle: Text(
                      car.condition,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Car Number Of Doors'),
                    subtitle: Text(
                      '${car.numberOfDoors} Doors',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Car Drive Wheels'),
                    subtitle: Text(
                      '${car.drivenWheels} Driven',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Car Engine Capacity'),
                    subtitle: Text(
                      '${car.engineCapacity} cc',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Car Engine Position'),
                    subtitle: Text(
                      '${car.enginePositions} Position',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Car Engine Position'),
                    subtitle: Text(
                      '${car.enginePositions} Position',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Car Engine Type'),
                    subtitle: Text(
                      '${car.engineType}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Car Fuel Type'),
                    subtitle: Text(
                      '${car.fuelType}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Car Fuel Capacity'),
                    subtitle: Text(
                      '${car.fuelCapacity} litres',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Car Seats'),
                    subtitle: Text(
                      '${car.numberOfSeats} Seats',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Car Seats'),
                    subtitle: Text(
                      '${car.numberOfSeats} Seats',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Car Top Speed'),
                    subtitle: Text(
                      '${car.topSpeed} km/h',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text('Car Dealer Comment'),
                    subtitle: Text(
                      '${car.comment}',
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
                        'Contact Car Dealer',
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
