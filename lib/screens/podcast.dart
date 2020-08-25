import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import './firstPage.dart';
import './radio_and_podcast.dart';
import '../utility/fadetransation.dart';

class Podcast extends StatefulWidget {
  @override
  _PodcastState createState() => _PodcastState();
}

class _PodcastState extends State<Podcast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            alignment: Alignment.center,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.dstATop,
            ),
            image: AssetImage("assets/logo/logonew1.png"),
          ),
        ),
        child: Center(
          child: Text(
            "Huduma hii itakujia hivi punde..",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        backgroundColor: Colors.black.withOpacity(0.2),
        buttonBackgroundColor: Colors.black,
        height: 45,
        items: <Widget>[
          Icon(Icons.arrow_back_ios, size: 20,color:Colors.orange),
          Icon(Icons.radio, size: 20,color:Colors.orange),
          Icon(Icons.headset, size: 20,color:Colors.orange),
        ],
        index: 2,
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.bounceInOut,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MyCustomRoute(
                builder: (context) => FirstPage(),
              ),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MyCustomRoute(
                builder: (context) => RadioPlay(),
              ),
            );
          } else {}
        },
      ),
    );
  }
}
