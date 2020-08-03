import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import './about.dart';
import './archive.dart';
import './gazeti_leo.dart';
import './homescreen.dart';
import './onlineTV.dart';
import './radio_and_podcast.dart';
import '../utility/fadetransation.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
dispose(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    var strToday = getStrToday();
    var mediaQuery = MediaQuery.of(context);
    double paddingTop = mediaQuery.padding.top;
    return Scaffold(
      body: Container(
        color: Colors.grey.withOpacity(0.5),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                //Color(0xFFF1F5F9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
              ),
              padding: EdgeInsets.only(
                top: paddingTop + 16.0,
                bottom: 10.0,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      WidgetTitle(strToday),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  WidgetLogo(),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              leading: Icon(
                Icons.today,
                color: Colors.black,
                size: 38,
              ),
              title: Text(
                'Habari',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MyCustomRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.radio,
                color: Colors.black,
                size: 38,
              ),
              title: Text(
                'Radio & Podcast',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MyCustomRoute(
                    builder: (context) => RadioPlay(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.live_tv,
                color: Colors.black,
                size: 38,
              ),
              title: Text(
                'Online Tv',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MyCustomRoute(
                    builder: (context) => OnlineTv(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.archive,
                color: Colors.black,
                size: 38,
              ),
              title: Text(
                'Archive',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MyCustomRoute(
                    builder: (context) => ArchiveSreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.chrome_reader_mode,
                color: Colors.black,
                size: 38,
              ),
              title: Text(
                'Gazeti La Leo',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MyCustomRoute(
                    builder: (context) => GazetiLeo(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.black,
                size: 38,
              ),
              title: Text(
                'About Us',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MyCustomRoute(
                    builder: (context) => About(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  //METHOD TO CONVERT DATE
  String getStrToday() {
    var today = DateFormat().add_yMMMMd().format(DateTime.now());
    var strDay = today.split(' ')[1].replaceFirst(',', '');
    if (strDay == '1') {
      strDay = strDay + 'st';
    } else if (strDay == '2') {
      strDay = strDay + 'nd';
    } else if (strDay == '3') {
      strDay = strDay + 'rd';
    } else {
      strDay = strDay + 'th';
    }

    var strMonth = today.split(' ')[0];
    var strYear = today.split(' ')[2];
    return '$strDay $strMonth, $strYear';
  }
}

//IT DISPLAY DATE
class WidgetTitle extends StatelessWidget {
  final String strToday;
  WidgetTitle(this.strToday);

  final String urlInsta = 'https://www.instagram.com/timesmajira';
  final String urlFb = 'https://www.facebook.com/timesmajira';
  final String urlTwitter = 'https://www.twitter.com/timesmajira';

  Future<void> _launchInApp(String url) async {
    if (await canLaunch(url)) {
      final bool onApp =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!onApp) {
        await launch(url, forceWebView: true, forceSafariVC: true);
      }
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 5, top: 0),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () => _launchInApp(urlInsta),
                        child: Image.asset(
                          "assets/icons/instagram.png",
                          width: 35,
                          height: 25,
                          //color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () => _launchInApp(urlFb),
                        child: Image.asset("assets/icons/facebook.png",
                            width: 35, height: 22, color: Colors.white),
                      ),
                      InkWell(
                        onTap: () => _launchInApp(urlTwitter),
                        child: Image.asset(
                          "assets/icons/twitter.png",
                          width: 35,
                          height: 18,
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MyCustomRoute(
                              builder: (context) => OnlineTv(),
                            ),
                          );
                        },
                        child: Image.asset(
                          "assets/icons/youtube.png",
                          width: 23,
                          height: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              strToday,
              style: Theme.of(context).textTheme.title.merge(
                    TextStyle(
                      color: Colors.white,
                      //Color(0xFF325384),
                      fontSize: 18.0,
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.0,
      child: ListTile(
        leading: CircleAvatar(
          maxRadius: 35.0,
          minRadius: 35.0,
          backgroundImage: AssetImage("assets/logo/logo_old.jpg"),
        ),
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Timesmajira \n',
                style: Theme.of(context).textTheme.title.merge(
                      TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                        // Color(0xFF325384),
                      ),
                    ),
              ),
              TextSpan(
                text: "Gazeti Huru La Kila Siku",
                style: Theme.of(context).textTheme.subtitle.merge(
                      TextStyle(
                        color: Colors.white,
                        // Color(0xFF325384),
                        fontSize: 12.0,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
