class VideoThumbnailImage {
  String url;
  int width;
  int height;

  VideoThumbnailImage({this.url, this.width, this.height});

  VideoThumbnailImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}
