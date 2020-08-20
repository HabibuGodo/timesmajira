import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:timesmajira/services/ads.dart';
import 'package:url_launcher/url_launcher.dart';

class SomaZaidi extends StatefulWidget {
  final Map<String, dynamic> postData;

  SomaZaidi({Key key, @required this.postData});
  @override
  _SomaZaidiState createState() => _SomaZaidiState();
}

class _SomaZaidiState extends State<SomaZaidi> {
  //BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();
    // DisplayAds.initializeAdMob();
    // _bannerAd = DisplayAds.createBannerAd()
    //   ..load()
    //   ..show();
  }

  @override
  dispose() {
    super.dispose();
    //_bannerAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = widget.postData['_embedded']['wp:featuredmedia'] == null
        ? 'https://pbs.twimg.com/profile_images/1282921492435607553/4g1xcHPG_400x400.jpg'
        : widget.postData['_embedded']['wp:featuredmedia'][0]['source_url'];
    String content = widget.postData['content']['rendered'];
    //////Date convertion///////////////
    DateTime formatted = DateTime.parse(widget.postData['modified']);
    var formatter = new DateFormat('MMM dd, yyyy');
    String postDate = formatter.format(formatted);
    ////////////////////////////////////
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, _) => Stack(
            children: <Widget>[
              Positioned.fill(
                bottom: MediaQuery.of(context).size.height * .55,
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: "assets/gif/loading.gif",
                  image: imageUrl,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.2),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.0,
                        0.7,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: DraggableScrollableSheet(
                  initialChildSize: .65,
                  minChildSize: .65,
                  builder: (context, controller) => Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                    ),
                    child: ListView(
                      controller: controller,
                      children: <Widget>[
                        ListTile(
                          leading: Image.asset(
                            "assets/logo/logonew1.png",
                            height: 35,
                            width: 35,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            postDate,
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                        ),
                        SizedBox(height: 9),
                        Html(
                          data: content,
                          defaultTextStyle: TextStyle(fontSize: 16.0),
                          showImages: true,
                          onLinkTap: (url) async {
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                        // Container(
                        //   //space for ads
                        //   height:50,
                        // )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
