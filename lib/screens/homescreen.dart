import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:cache_image/cache_image.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:timesmajira/screens/onlineTV.dart';
import 'package:timesmajira/screens/search_page.dart';
import 'package:timesmajira/services/ads.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:uni_links/uni_links.dart';
import '../block/home_bloc.dart';
import '../models/category.dart';
import './soma_zaid.dart';
import '../utility/fadetransation.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
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
    var strToday = getStrToday();
    var mediaQuery = MediaQuery.of(context);
    double paddingTop = mediaQuery.padding.top;
    return Scaffold(
      body: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  )),
              padding: EdgeInsets.only(
                top: paddingTop + 16.0,
                bottom: 8.0,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 8),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      WidgetTitle(strToday),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  WidgetCategory(),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            _buildWidgetLabelLatestPost(context),
            _buildWidgetSubtitleLatestPost(context),
            Expanded(
              child: WidgetLatestPosts(),
            )
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.black,
        height: 45,
        items: <Widget>[
          Icon(Icons.arrow_back_ios, size: 20, color: Colors.orange),
          Icon(Icons.home, size: 20, color: Colors.orange),
          Icon(Icons.search, size: 25, color: Colors.orange),
        ],
        index: 1,
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.bounceInOut,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 2) {
            Navigator.push(
              context,
              MyCustomRoute(
                builder: (context) => SearchPage(),
              ),
            );
          } else {}
        },
      ),
    );
  }

  //It Display Habari Label
  Widget _buildWidgetLabelLatestPost(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        "Habari",
        style: Theme.of(context).textTheme.subtitle.merge(
              TextStyle(
                fontSize: 18,
                color: Color(0xFF325384).withOpacity(0.8),
              ),
            ),
      ),
    );
  }

  Widget _buildWidgetSubtitleLatestPost(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        "Zilizotokea sasa",
        style: Theme.of(context).textTheme.caption.merge(
              TextStyle(
                color: Color(0xFF325384).withOpacity(0.5),
              ),
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
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Majira Leo\n',
                style: Theme.of(context).textTheme.title.merge(
                      TextStyle(
                        color: Colors.white,
                        // Color(0xFF325384),
                      ),
                    ),
              ),
              TextSpan(
                text: strToday,
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

//CATEGORIES
class WidgetCategory extends StatefulWidget {
  @override
  _WidgetCategoryState createState() => _WidgetCategoryState();
}

class _WidgetCategoryState extends State<WidgetCategory> {
  final listCategories = [
    Category('', 'All'),
    Category('assets/images/Tanzania.jpg', 'Kitaifa'),
    Category('assets/images/world.gif', 'Kimataifa'),
    Category('assets/images/sports.png', 'Michezo'),
    Category('assets/images/magazeti.jpg', 'Magazeti'),
    Category('assets/icons/makala.png', 'Makala'),
    Category('assets/icons/mikoani.png', 'Mikoani'),
  ];
  int indexSelectedCategory = 0;

  @override
  void initState() {
    // ignore: close_sinks
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(DataEvent(listCategories[indexSelectedCategory].title));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return Container(
      height: 72.0,
      child: ListView.builder(
          itemCount: listCategories.length,
          shrinkWrap: false,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Category itemaCategory = listCategories[index];
            return Padding(
              padding: EdgeInsets.only(
                left: 16.0,
                right: index == listCategories.length - 1 ? 16.0 : 0.0,
              ),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        indexSelectedCategory = index;
                        homeBloc.add(DataEvent(
                            listCategories[indexSelectedCategory].title));
                      });
                    },
                    child: index == 0
                        ? Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFBDCDDE),
                              border: indexSelectedCategory == index
                                  ? Border.all(
                                      color: Colors.orange,
                                      width: 3,
                                    )
                                  : null,
                            ),
                            child: Icon(
                              Icons.apps,
                              color: Colors.white,
                            ),
                          )
                        : Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(itemaCategory.image),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center),
                              border: indexSelectedCategory == index
                                  ? Border.all(
                                      color: Colors.orange,
                                      width: 3.0,
                                    )
                                  : null,
                            ),
                          ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    itemaCategory.title,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        // Color(0xFF325384),
                        fontWeight: indexSelectedCategory == index
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class WidgetLatestPosts extends StatefulWidget {
  @override
  _WidgetLatestPostsState createState() => _WidgetLatestPostsState();
}

class _WidgetLatestPostsState extends State<WidgetLatestPosts> {
  InterstitialAd _interstitialAd;
  @override
  void initState() {
    super.initState();
    _interstitialAd = DisplayAds.createInterstitialAd()..load();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    // ignore: close_sinks
    final HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context);

    return Padding(
        padding: EdgeInsets.only(
          left: 16,
          top: 8,
          right: 16,
          bottom: mediaQuery.padding.bottom + 16,
        ),
        child: BlocListener<HomeBloc, DataState>(
          listener: (context, state) {},
          child: BlocBuilder(
              bloc: homeBloc,
              builder: (context, state) {
                return _buildWidgetContentLatestPost(state, mediaQuery);
              }),
        ));
  }

  Widget _buildWidgetContentLatestPost(
      DataState state, MediaQueryData mediaQuery) {
    if (state is DataLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitThreeBounce(color: Colors.orange, size: 50),
          ],
        ),
      );
    } else if (state is DataSuccess) {
      List dataPost = state.data;
      return ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          String imageUrl =
              dataPost[index]['_embedded']['wp:featuredmedia'][0]['source_url'];
          String title = dataPost[index]['title']['rendered'];
          String category = dataPost[index]['categories'].toString();
          if (index == 0) {
            return Stack(
              children: <Widget>[
                ClipRRect(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/gif/loading.gif'),
                      image: CacheImage(imageUrl),
                      height: 192.0,
                    ),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _interstitialAd.show();
                    _interstitialAd = DisplayAds.createInterstitialAd()..load();
                    Navigator.push(
                      context,
                      MyCustomRoute(
                        builder: (context) => SomaZaidi(
                          postData: dataPost[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: mediaQuery.size.width,
                    height: 192.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.black.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [
                          0.0,
                          0.7,
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, top: 12, right: 12),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 12, top: 90, right: 12),
                      child: Wrap(
                        children: <Widget>[
                          category == "[48, 1]" || category == '[48]'
                              ? Text(
                                  "BREAKING NEWS",
                                  style: TextStyle(
                                    backgroundColor: Colors.red,
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            width: 4.0,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          } else {
            return GestureDetector(
              onTap: () {
                _interstitialAd.show();
                _interstitialAd = DisplayAds.createInterstitialAd()..load();
                Navigator.push(
                  context,
                  MyCustomRoute(
                    builder: (context) => SomaZaidi(
                      postData: dataPost[index],
                    ),
                  ),
                );
              },
              child: Container(
                width: mediaQuery.size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 80.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF325384),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.launch,
                                  color: Color(0xFF325384).withOpacity(0.5),
                                  size: 12.0,
                                ),
                                SizedBox(width: 4.0),
                                Text(
                                  "Soma zaidi",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Color(0xFF325384).withOpacity(0.5),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          placeholder: AssetImage('assets/gif/loading.gif'),
                          image: CacheImage(imageUrl),
                          height: 72.0,
                          width: 72.0,
                        ),

                        // FadeInImage.assetNetwork(
                        //   fit: BoxFit.cover,
                        //   placeholder: "assets/gif/loading.gif",
                        //   image: imageUrl,
                        //   height: 72.0,
                        //   width: 72.0,
                        //),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: dataPost.length,
      );
    } else {
      return Center(child: Text("Please check your connection."));
    }
  }
}
