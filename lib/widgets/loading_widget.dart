import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SpinKitPianoWave(
            color: Colors.red,
          ),
          SizedBox(
            height: 20,
          ),
          Text('Please wait...')
        ],
      ),
    );
  }
}
