import 'package:FlutterTube/shared/models/youtube_video_thumbnail.dart';

class VideoSnippet {
  String publishedAt;
  String channelId;
  String title;
  String description;
  VideoThumbnail thumbnails;
  String channelTitle;
  String liveBroadcastContent;
  String publishTime;

  VideoSnippet(
      {this.publishedAt,
      this.channelId,
      this.title,
      this.description,
      this.thumbnails,
      this.channelTitle,
      this.liveBroadcastContent,
      this.publishTime});

  VideoSnippet.fromJson(Map<String, dynamic> json) {
    publishedAt = json['publishedAt'];
    channelId = json['channelId'];
    title = json['title'];
    description = json['description'];
    thumbnails = json['thumbnails'] != null
        ? new VideoThumbnail.fromJson(json['thumbnails'])
        : null;
    channelTitle = json['channelTitle'];
    liveBroadcastContent = json['liveBroadcastContent'];
    publishTime = json['publishTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publishedAt'] = this.publishedAt;
    data['channelId'] = this.channelId;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.thumbnails != null) {
      data['thumbnails'] = this.thumbnails.toJson();
    }
    data['channelTitle'] = this.channelTitle;
    data['liveBroadcastContent'] = this.liveBroadcastContent;
    data['publishTime'] = this.publishTime;
    return data;
  }
}
