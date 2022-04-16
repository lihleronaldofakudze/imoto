import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:imoto/services/auth_service.dart';
import 'package:imoto/services/database.dart';
import 'package:imoto/widgets/glass_container_widget.dart';
import 'package:imoto/widgets/loading_widget.dart';
import 'package:imoto/widgets/text_box_widget.dart';

import '../constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return _loading
        ? const LoadingWidget()
        : Scaffold(
            backgroundColor: Colors.white,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: const IconThemeData(color: Colors.red),
            ),
            body: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/makhenikha.jpg'),
                        fit: BoxFit.cover)),
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Create your account.',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GlassContainerWidget(
                          height: 530,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                const Text('Please enter al required details',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                TextBoxWidget(
                                    hintText: 'Full Name or Company Name',
                                    controller: _usernameController,
                                    keyboardType: TextInputType.text,
                                    obscureText: false),
                                TextBoxWidget(
                                    hintText: 'Email Address',
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: false),
                                TextBoxWidget(
                                    hintText: ' Password',
                                    controller: _passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: false),
                                TextBoxWidget(
                                    hintText: 'Confirm Password',
                                    controller: _confirmPasswordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: false),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 45,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ElevatedButton(
                                    onPressed: _register,
                                    child: Text(
                                      'Continue'.toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/login');
                                    },
                                    child: const Text('I have an account?',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          );
  }

  _register() async {
    setState(() {
      _loading = true;
    });
    if (_usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
      if (_passwordController.text == _confirmPasswordController.text) {
        dynamic result = await AuthService().register(
            email: _emailController.text, password: _passwordController.text);
        if (result != null) {
          await DatabaseService(uid: result.uid)
              .setUserProfile(
                  image: Constants().mf2,
                  username: _usernameController.text,
                  email: _emailController.text,
                  address: 'Manzini, Lobamba',
                  number: '+268 7499 014',
                  cars: 0,
                  parts: 0,
                  type: 'Individual')
              .then((value) {
            _passwordController.clear();
            _confirmPasswordController.clear();
            _usernameController.clear();
            _emailController.clear();
            setState(() {
              _loading = false;
            });
            Navigator.pushNamed(context, '/auth');
          });
        } else {
          setState(() {
            _loading = false;
          });
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Error',
            desc: 'Email already exists',
            btnOkOnPress: () {},
          ).show();
        }
      } else {
        setState(() {
          _loading = false;
        });
        _passwordController.clear();
        _confirmPasswordController.clear();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Error',
          desc: 'Passwords do not match',
          btnOkOnPress: () {},
        ).show();
      }
    } else {
      setState(() {
        _loading = false;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Error',
        desc: 'Please fill all the required fields',
        btnOkOnPress: () {},
      ).show();
    }
  }
}
