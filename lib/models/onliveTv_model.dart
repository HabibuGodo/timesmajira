class OnlineTvModel {
  String id;
  String title;
  String profilePic;
  String subscriberCount;
  String videoCount;
  String uploadPlayListId;
  List<Video> videos;

  OnlineTvModel(
      {this.id,
      this.title,
      this.profilePic,
      this.subscriberCount,
      this.videoCount,
      this.uploadPlayListId,
      this.videos});

  factory OnlineTvModel.fromMap(Map<String, dynamic> map) {
    return OnlineTvModel(
      id: map['id'],
      title: map['snippet']['title'],
      profilePic: map['snippet']['thumbnails']['default']['url'],
      subscriberCount: map['statistics']['subscriberCount'],
      videoCount: map['statistics']['videoCount'],
      uploadPlayListId: map['contentDetails']['relatedPlaylists']['uploads'],
    );
  }
}

class Video {
  String id;
  String title;
  String thumbnailUrl;
  String channelTitle;

  Video({this.id, this.title, this.thumbnailUrl, this.channelTitle});

  factory Video.fromMap(Map<String, dynamic> snippet) {
    return Video(
      id: snippet['resourceId']['videoId'],
      title: snippet['title'],
      thumbnailUrl: snippet['thumbnails']['high']['url'],
      channelTitle: snippet['channelTitle'],
    );
  }
}
