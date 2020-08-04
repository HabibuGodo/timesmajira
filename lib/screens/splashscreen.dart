import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timesmajira/screens/firstPage.dart';
import './homescreen.dart';
import '../utility/fadetransation.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  void navigationPage() {
    Navigator.pushReplacement(
      context,
      MyCustomRoute(
        builder: (context) => FirstPage(),
        //HomeScreen(),
      ),
    );
  }

  startTime() async {
    var _duration = Duration(seconds: 10);
    return Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    startTime();
    //_showNots();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light
          .copyWith(statusBarIconBrightness: Brightness.light),
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.width,
          width: 300,
          child: Image.asset('assets/logo/logo.png'),
        ),
      ),
    );
  }
}
