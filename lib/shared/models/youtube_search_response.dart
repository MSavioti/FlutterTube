import 'package:FlutterTube/shared/models/youtube_search_page_info.dart';
import 'package:FlutterTube/shared/models/youtube_search_result.dart';

class YouTubeSearchResponse {
  String responseKind;
  String etag;
  String nextPageToken;
  String regionCode;
  SearchResultPageInfo pageInfo;
  List<YouTubeSearchResult> results;

  YouTubeSearchResponse(
      {this.responseKind,
      this.etag,
      this.nextPageToken,
      this.regionCode,
      this.pageInfo,
      this.results});

  YouTubeSearchResponse.fromJson(Map<String, dynamic> json) {
    responseKind = json['kind'];
    etag = json['etag'];
    nextPageToken = json['nextPageToken'];
    regionCode = json['regionCode'];
    pageInfo = json['pageInfo'] != null
        ? new SearchResultPageInfo.fromJson(json['pageInfo'])
        : null;
    if (json['items'] != null) {
      results = [];
      json['items'].forEach((v) {
        results.add(new YouTubeSearchResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.responseKind;
    data['etag'] = this.etag;
    data['nextPageToken'] = this.nextPageToken;
    data['regionCode'] = this.regionCode;
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo.toJson();
    }
    if (this.results != null) {
      data['items'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
