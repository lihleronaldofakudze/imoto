import 'package:flutter/material.dart';
import 'package:imoto/services/auth.dart';
import 'package:imoto/widgets/loading.dart';
import 'package:imoto/widgets/okAlertDialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
                'Sign In using Email Address',
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
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          controller: _passwordController,
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
                              if (_emailController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty) {
                                dynamic result = await AuthService().login(
                                    email: _emailController.text,
                                    password: _passwordController.text);

                                if (result != null) {
                                  setState(() {
                                    _loading = false;
                                  });
                                  Navigator.pushNamed(context, '/auth');
                                } else {
                                  setState(() {
                                    _loading = false;
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (_) => okAlertDialog(
                                          context: context,
                                          message:
                                              'Something went wrong, Please Try Again.'));
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
                                            'Please enter all required information'));
                              }
                            },
                            child: Text(
                              'Access your account',
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
                            Text('or'),
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
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
