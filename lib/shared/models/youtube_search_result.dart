import 'package:FlutterTube/shared/models/youtube_video_id.dart';
import 'package:FlutterTube/shared/models/youtube_video_snippet.dart';

class YouTubeSearchResult {
  String itemKind;
  String etag;
  VideoId videoId;
  VideoSnippet snippet;

  String get defaultThumbnail => snippet.thumbnails.defaultSize.url;
  String get largeThumbnail => snippet.thumbnails.largeSize.url;
  String get channel => snippet.channelTitle;
  String get videoTitle => snippet.title;
  String get id => videoId.videoId;

  YouTubeSearchResult({this.itemKind, this.etag, this.videoId, this.snippet});

  YouTubeSearchResult.fromJson(Map<String, dynamic> json) {
    itemKind = json['kind'];
    etag = json['etag'];
    videoId = json['id'] != null ? new VideoId.fromJson(json['id']) : null;
    snippet = json['snippet'] != null
        ? new VideoSnippet.fromJson(json['snippet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.itemKind;
    data['etag'] = this.etag;
    if (this.videoId != null) {
      data['id'] = this.videoId.toJson();
    }
    if (this.snippet != null) {
      data['snippet'] = this.snippet.toJson();
    }
    return data;
  }
}
