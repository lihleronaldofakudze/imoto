import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imoto/models/Part.dart';
import 'package:provider/provider.dart';

class PartList extends StatelessWidget {
  const PartList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parts = Provider.of<List<Part>>(context);
    return ListView.builder(
      itemCount: parts.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/part', arguments: parts[index].id);
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
                          image: NetworkImage(parts[index].images[1]),
                          fit: BoxFit.contain)),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_border_rounded)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'E ${parts[index].price}0',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '${parts[index].brand}',
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
