import 'package:flutter/material.dart';
import 'package:imoto/models/CurrentUser.dart';
import 'package:imoto/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'core_screen.dart';

class AuthStateScreen extends StatelessWidget {
  const AuthStateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<CurrentUser?>(context);

    if (currentUser == null) {
      return WelcomeScreen();
    } else {
      return CoreScreen();
    }
  }
}
