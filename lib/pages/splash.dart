import 'dart:async';

import 'package:coindcx/pages/home.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static const routeName = 'splashPage';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: Image.asset('assets/images/cdx.png'),
            ),
          ),
          Text('Welcome to CoinDCX Markets')
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, switchPage);
  }

  switchPage() {
    Navigator.pushReplacementNamed(context, HomePage.routeName);
  }
}
