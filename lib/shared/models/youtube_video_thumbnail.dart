import 'package:FlutterTube/shared/models/youtube_video_thumbnail_image.dart';

class VideoThumbnail {
  VideoThumbnailImage defaultSize;
  VideoThumbnailImage mediumSize;
  VideoThumbnailImage largeSize;

  VideoThumbnail({this.defaultSize, this.mediumSize, this.largeSize});

  VideoThumbnail.fromJson(Map<String, dynamic> json) {
    defaultSize = json['default'] != null
        ? new VideoThumbnailImage.fromJson(json['default'])
        : null;
    mediumSize = json['medium'] != null
        ? new VideoThumbnailImage.fromJson(json['medium'])
        : null;
    largeSize = json['high'] != null
        ? new VideoThumbnailImage.fromJson(json['high'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.defaultSize != null) {
      data['default'] = this.defaultSize.toJson();
    }
    if (this.mediumSize != null) {
      data['medium'] = this.mediumSize.toJson();
    }
    if (this.largeSize != null) {
      data['high'] = this.largeSize.toJson();
    }
    return data;
  }
}
