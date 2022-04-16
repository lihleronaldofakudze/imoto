import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imoto/models/CurrentUser.dart';
import 'package:imoto/screens/add_car_screen.dart';
import 'package:imoto/screens/add_part_screen.dart';
import 'package:imoto/screens/auth_state_screen.dart';
import 'package:imoto/screens/car_screen.dart';
import 'package:imoto/screens/category_screen.dart';
import 'package:imoto/screens/edit_profile_screen.dart';
import 'package:imoto/screens/forgot_password_screen.dart';
import 'package:imoto/screens/garage_cars_screen.dart';
import 'package:imoto/screens/garage_parts_screen.dart';
import 'package:imoto/screens/garage_screen.dart';
import 'package:imoto/screens/login_screen.dart';
import 'package:imoto/screens/part_screen.dart';
import 'package:imoto/screens/parts_screen.dart';
import 'package:imoto/screens/register_screen.dart';
import 'package:imoto/services/auth_service.dart';
import 'package:imoto/services/database.dart';
import 'package:provider/provider.dart';

import 'models/Car.dart';
import 'models/Garage.dart';
import 'models/Part.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<CurrentUser?>.value(
            value: AuthService().user, initialData: CurrentUser()),
        StreamProvider<List<Car>>.value(
            value: DatabaseService().cars, initialData: []),
        StreamProvider<List<Garage>>.value(
            value: DatabaseService().garages, initialData: []),
        StreamProvider<List<Part>>.value(
            value: DatabaseService().parts, initialData: []),
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => AnimatedSplashScreen(
              splashIconSize: double.infinity,
              splash: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Clout Developers',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/logo.png'),
                              fit: BoxFit.contain)),
                    ),
                  ],
                ),
              ),
              nextScreen: AuthStateScreen()),
          '/auth': (context) => AuthStateScreen(),
          '/register': (context) => RegisterScreen(),
          '/login': (context) => LoginScreen(),
          '/forgot_password': (context) => ForgotPasswordScreen(),
          '/add_car': (context) => AddCarScreen(),
          '/edit_profile': (context) => EditProfileScreen(),
          '/garage_cars': (context) => GarageCarsScreen(),
          '/garage_parts': (context) => GaragePartsScreen(),
          '/category': (context) => CategoryScreen(),
          '/garage': (context) => GarageScreen(),
          '/car': (context) => CarScreen(),
          '/parts': (context) => PartsScreen(),
          '/part': (context) => PartScreen(),
          '/sell_part': (context) => AddPartScreen(),
        },
        title: 'Imoto',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.red,
            textTheme:
                GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme)),
      ),
    );
  }
}
