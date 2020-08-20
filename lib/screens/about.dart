import 'package:flutter/material.dart';
import './onlineTV.dart';
import '../utility/fadetransation.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  final String about =
      "Kivuli Business Care Limited (KBC) is a Media House specializing in print media (newspapers) for the Cultural and Creative Industry to accelerate development in the country. It is the place where creative inspiration meets innovation, thanks to the talent of a number of professionals who create new solutions aimed at informing, entertaining and thrilling the audience.";

  final String urlInsta = 'https://www.instagram.com/timesmajira';
  final String urlFb = 'https://www.facebook.com/timesmajira';
  final String urlTwitter = 'https://www.twitter.com/timesmajira';
  final String email = 'mailto:kivulibussinesscare@gmail.com';

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
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 35, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.cancel,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 120,
                    height: 100,
                    margin: EdgeInsets.only(top: 20),
                    child: CircleAvatar(
                      maxRadius: 50.0,
                      minRadius: 50.0,
                      backgroundImage: AssetImage("assets/logo/logonew1.png"),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Times',
                            style: Theme.of(context).textTheme.title.merge(
                                  TextStyle(
                                      color: Colors.white,
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.bold
                                      // Color(0xFF325384),
                                      ),
                                ),
                          ),
                          TextSpan(
                            text: "majira",
                            style: Theme.of(context).textTheme.subtitle.merge(
                                  TextStyle(
                                      color: Colors.orange,
                                      // Color(0xFF325384),
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold),
                                ),
                          ),
                        ],
                      ),
                    ),
                    // Text(
                    //   'TimesMajira',
                    //   style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 32,
                    //       fontWeight: FontWeight.bold),
                    // ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Text(
                about,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        "Email Us: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () => _launchInApp(email),
                            child: Text(
                              "kivulibussinesscare@gmail.com",
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
