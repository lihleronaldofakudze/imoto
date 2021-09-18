import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imoto/models/CurrentUser.dart';
import 'package:imoto/screens/add_car_screen.dart';
import 'package:imoto/screens/auth_state_screen.dart';
import 'package:imoto/screens/login_screen.dart';
import 'package:imoto/screens/register_screen.dart';
import 'package:imoto/services/auth.dart';
import 'package:imoto/services/database.dart';
import 'package:provider/provider.dart';

import 'models/Car.dart';

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
            value: DatabaseService().cars, initialData: [])
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
          '/add_car': (context) => AddCarScreen(),
        },
        title: 'Imoto',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.orange,
            textTheme:
                GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme)),
      ),
    );
  }
}
