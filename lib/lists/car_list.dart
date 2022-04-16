import 'package:flutter/material.dart';
import 'package:imoto/constants.dart';
import 'package:imoto/models/Car.dart';
import 'package:imoto/widgets/icon_box_widget.dart';
import 'package:provider/provider.dart';

class CarList extends StatelessWidget {
  const CarList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<List<Car>>(context);
    return GridView.builder(
      itemCount: cars.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/car', arguments: cars[index].id);
          },
          child: Card(
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
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconBoxWidget(
                            onPressed: () {},
                            icon: Icons.favorite_border_rounded,
                            color: Colors.red),
                      ),
                      // Image.asset('images/new.png',
                      //     height: 40, width: 40, fit: BoxFit.cover),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    // cars[index].model.toString(),
                    'LLLLLLLLLLLLLLLL',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'E ${Constants().formatMoney(cars[index].price.toInt())}0',
                    style: const TextStyle(fontSize: 16),
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
