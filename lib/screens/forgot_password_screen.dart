import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:imoto/services/auth_service.dart';
import 'package:imoto/widgets/glass_container_widget.dart';
import 'package:imoto/widgets/loading_widget.dart';
import 'package:imoto/widgets/text_box_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  final _emailController = TextEditingController();
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
                      const SizedBox(
                        height: 80,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Forgot Password',
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
                        height: 290,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const Text('Please enter email to reset password',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              TextBoxWidget(
                                  hintText: 'Email Address',
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
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
                                  onPressed: _login,
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
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/auth');
                                  },
                                  child: const Text(
                                      'I just remembered my password',
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
              ),
            ),
          );
  }

  _login() async {
    setState(() {
      _loading = true;
    });
    if (_emailController.text.isNotEmpty) {
      dynamic result =
          await AuthService().forgotPassword(email: _emailController.text);

      if (result != null) {
        setState(() {
          _loading = false;
        });
        Navigator.pushNamed(context, '/auth');
      } else {
        setState(() {
          _loading = false;
        });
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Error',
          desc: 'Email is incorrect',
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
        desc: 'Please fill all fields',
        btnOkOnPress: () {},
      ).show();
    }
  }
}
