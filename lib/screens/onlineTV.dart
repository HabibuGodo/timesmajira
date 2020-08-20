import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../api/youtubeData.dart';
import '../models/onliveTv_model.dart';
import './onlineTv_play.dart';
import '../utility/fadetransation.dart';

class OnlineTv extends StatefulWidget {
  @override
  _OnlineTvState createState() => _OnlineTvState();
}

class _OnlineTvState extends State<OnlineTv> {
  @override
  void initState() {
    super.initState();
    _initOnlineTv();
  }

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

  OnlineTvModel _onlineTv;
  bool _isLoading = false;

  _initOnlineTv() async {
    OnlineTvModel onlineTv = await YoutubeAPI.instance
        // mubashara studio : UCXX1WAx4XY7LmEXMLXw_hRA
        //Original TimesMajira Youtube Channel Id: UCxAWoWzTmt1qkA6hRF_mIvg
        .fetchChannel(channelId: "UCxAWoWzTmt1qkA6hRF_mIvg");
    setState(() {
      _onlineTv = onlineTv;
    });
  }

  _buildProfileInfo() {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
              color: Colors.white38, offset: Offset(0, 1), blurRadius: 6.0),
        ],
        border: Border.all(
          color: Colors.orange,
          width: 3,
        ),
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            backgroundImage: NetworkImage(_onlineTv.profilePic),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _onlineTv.title,
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                Row(
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
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MyCustomRoute(
            builder: (context) => VideoScreen(
              id: video.id,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        padding: EdgeInsets.all(10),
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 1), blurRadius: 6),
          ],
        ),
        child: Row(
          children: <Widget>[
            FadeInImage(
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/gif/loading.gif'),
              image: CacheImage(video.thumbnailUrl),
              width: 140,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              video.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            )),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await YoutubeAPI.instance
        .fetchVideosFromPlayList(playlistId: _onlineTv.uploadPlayListId);
    List<Video> allVideos = _onlineTv.videos..addAll(moreVideos);
    setState(() {
      _onlineTv.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "OnlineTv",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _onlineTv != null
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading &&
                    _onlineTv.videos.length !=
                        int.parse(_onlineTv.videoCount) &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                  _loadMoreVideos();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: 1 + _onlineTv.videos.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return _buildProfileInfo();
                  }
                  Video video = _onlineTv.videos[index - 1];
                  return _buildVideo(video);
                },
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SpinKitThreeBounce(color: Colors.orange, size: 50),
                ],
              ),
            ),
    );
  }
}
