class SpotifyImage {
  ///The image height in pixels. If unknown: `null` or not returned.
  int height;

  ///The source URL of the image.
  String url;

  ///The image width in pixels. If unknown: `null` or not returned.
  int width;

  SpotifyImage(this.height, this.url, this.width);
  factory SpotifyImage.fromJSON(Map<String, dynamic> json) {
    return SpotifyImage(json["height"], json["url"], json["width"]);
  }
}