import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/logo.png'),
                      fit: BoxFit.contain)),
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.white, elevation: 10.0),
                            onPressed: () {},
                            icon: FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.red,
                            ),
                            label: Text(
                              'Google',
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            )),
                      )),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blue, elevation: 10.0),
                            onPressed: () {},
                            icon: FaIcon(
                              FontAwesomeIcons.facebookSquare,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Facebook',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text('or Use your email address'),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            primary: Colors.orange,
                            side: BorderSide(color: Colors.orange)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Register using Email Address ',
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            primary: Colors.orange,
                            side: BorderSide(color: Colors.orange)),
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'Login using Email Address ',
                          style: TextStyle(fontSize: 18),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
