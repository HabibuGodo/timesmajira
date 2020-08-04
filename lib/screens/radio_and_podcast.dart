//import 'package:audioplayers/audioplayers.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_radio/flutter_radio.dart';
import './firstPage.dart';
import './podcast.dart';
import '../utility/fadetransation.dart';

class RadioPlay extends StatefulWidget {
  @override
  _RadioPlayState createState() => _RadioPlayState();
}

class _RadioPlayState extends State<RadioPlay> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    double paddingTop = mediaQuery.padding.top;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: Alignment.centerRight,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop),
            image: AssetImage("assets/images/podcast_background.jpg"),
          ),
        ),
        child: Center(
          child: PlayerWidget(),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        backgroundColor: Colors.black.withOpacity(0.4),
        buttonBackgroundColor: Colors.black,
        height: 45,
        items: <Widget>[
          Icon(Icons.arrow_back_ios, size: 20,color:Colors.orange),
          Icon(Icons.radio, size: 20,color:Colors.orange),
          Icon(Icons.headset, size: 20,color:Colors.orange),
        ],
        index: 1,
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
          } else if (index == 2) {
            Navigator.push(
              context,
              MyCustomRoute(
                builder: (context) => Podcast(),
              ),
            );
          } else {}
        },
      ),
    );
  }
}

class PlayerWidget extends StatefulWidget {
  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget>
    with SingleTickerProviderStateMixin {
      //bongo : http://173.244.208.77:8000/bongo.mp3
      //mixtape : http://162.243.173.18:8034/stream
  String streamUrl = "http://173.244.208.77:8000/bongo.mp3";

  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioStart();
    // radioPlaying();
    playingStatus();
  }

  audioStart() async {
    if (await FlutterRadio.isPlaying()) {
      if (streamUrl == streamUrl) {
        FlutterRadio.stop();
        FlutterRadio.play(url: streamUrl);
      } else {}
    } else {
      print("adsf");
      FlutterRadio.playOrPause(url: streamUrl);
    }
    playingStatus();
    print('Audio Start OK');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "Timesmajira Radio \n     Coming soon",
            style: TextStyle(fontSize: 28),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
            child: Image.asset(
              "assets/images/radio.jpg",
              width: 120,
              fit: BoxFit.cover,
              height: 120,
              colorBlendMode: BlendMode.dstATop,
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          IconButton(
            iconSize: 80,
            icon: !isPlaying
                ? Icon(
                    Icons.play_circle_filled,
                    color: Colors.orange,
                  )
                : Icon(
                    Icons.pause_circle_filled,
                    color: Colors.orange,
                  ),
            onPressed: () async {
              FlutterRadio.playOrPause(url: streamUrl);
              bool isP = await FlutterRadio.isPlaying();
              setState(() {
                isPlaying = !isPlaying;
              });
            },
          ),
        ],
      ),
    );
  }

  Future playingStatus() async {
    setState(() {
      isPlaying = true;
    });
  }
}
