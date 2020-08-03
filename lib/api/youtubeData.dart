import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:timesmajira/models/onliveTv_model.dart';
import 'package:timesmajira/utility/keys.dart';

class YoutubeAPI {
  YoutubeAPI._instntiate();
  static final YoutubeAPI instance = YoutubeAPI._instntiate();
  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future<OnlineTvModel> fetchChannel({String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': API_KEY
    };
    Uri uri = Uri.https(
      _baseUrl,
      "/youtube/v3/channels",
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    //Get Channel
    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      OnlineTvModel onlineTv = OnlineTvModel.fromMap(data);

      //Fetch first batch of videos from uploads playlist
      onlineTv.videos = await fetchVideosFromPlayList(
        playlistId: onlineTv.uploadPlayListId,
      );
      return onlineTv;
    } else {
      
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> fetchVideosFromPlayList({String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': API_KEY
    };

    Uri uri = Uri.https(
      _baseUrl,
      "/youtube/v3/playlistItems",
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromMap(json['snippet']),
        ),
      );

      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
