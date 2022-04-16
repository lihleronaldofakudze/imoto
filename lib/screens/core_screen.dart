import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imoto/screens/garages_screen.dart';
import 'package:imoto/screens/profile_screen.dart';

import 'categories_screen.dart';
import 'home_screen.dart';

class CoreScreen extends StatefulWidget {
  const CoreScreen({Key? key}) : super(key: key);

  @override
  _CoreScreenState createState() => _CoreScreenState();
}

class _CoreScreenState extends State<CoreScreen> {
  int currentIndex = 0;
  final bottomTabs = [
    const HomeScreen(),
    const CategoriesScreen(),
    const GaragesScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_car');
        },
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: bottomTabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        elevation: 8.0,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.house,
                size: 20,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.car,
                size: 20,
              ),
              label: 'Categories'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.warehouse, size: 20),
              label: 'Garages'),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user, size: 20), label: 'Profile'),
        ],
      ),
    );
  }
}
