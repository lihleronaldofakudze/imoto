import 'package:flutter/material.dart';
import 'package:imoto/services/auth.dart';
import 'package:imoto/services/database.dart';
import 'package:imoto/widgets/loading.dart';
import 'package:imoto/widgets/okAlertDialog.dart';

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
  final _numberController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return _loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(color: Colors.orange),
              title: Text(
                'Sign Up using Email Address',
                style: TextStyle(color: Colors.orange),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: 'Username & Company',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          controller: _usernameController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Email Address',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          controller: _emailController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Phone Number',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          controller: _numberController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.streetAddress,
                          decoration: InputDecoration(
                              hintText: 'Address',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          controller: _addressController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          controller: _passwordController,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          controller: _confirmPasswordController,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100)),
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _loading = true;
                              });
                              if (_usernameController.text.isNotEmpty &&
                                  _emailController.text.isNotEmpty &&
                                  _numberController.text.isNotEmpty &&
                                  _addressController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty &&
                                  _confirmPasswordController.text.isNotEmpty) {
                                if (_passwordController.text ==
                                    _confirmPasswordController.text) {
                                  dynamic result = await AuthService().register(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                                  if (result != null) {
                                    await DatabaseService(uid: result.uid)
                                        .setUserProfile(
                                            image: Constants().mf2,
                                            username: _usernameController.text,
                                            email: _emailController.text,
                                            address: _addressController.text,
                                            number: _numberController.text,
                                            type: 'Individual')
                                        .then((value) {
                                      _passwordController.clear();
                                      _confirmPasswordController.clear();
                                      _usernameController.clear();
                                      _emailController.clear();
                                      _numberController.clear();
                                      _addressController.clear();
                                      setState(() {
                                        _loading = false;
                                      });
                                      Navigator.pushNamed(context, '/auth');
                                    });
                                  } else {
                                    setState(() {
                                      _loading = false;
                                    });
                                    showDialog(
                                        context: context,
                                        builder: (_) => okAlertDialog(
                                            context: context,
                                            message:
                                                'Something went wrong, Please try again'));
                                  }
                                } else {
                                  setState(() {
                                    _loading = false;
                                  });
                                  _passwordController.clear();
                                  _confirmPasswordController.clear();
                                  showDialog(
                                      context: context,
                                      builder: (_) => okAlertDialog(
                                          context: context,
                                          message: 'Passwords do not match'));
                                }
                              } else {
                                setState(() {
                                  _loading = false;
                                });
                                showDialog(
                                    context: context,
                                    builder: (_) => okAlertDialog(
                                        context: context,
                                        message:
                                            'Please enter all required information.'));
                              }
                            },
                            child: Text(
                              'Create an account',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
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
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white, elevation: 10.0),
                                  onPressed: () {},
                                  child: Text(
                                    'Google',
                                    style: TextStyle(fontSize: 18),
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
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue, elevation: 10.0),
                                  onPressed: () {},
                                  child: Text(
                                    'Facebook',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  )),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 40,
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
