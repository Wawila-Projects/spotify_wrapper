import 'package:spotify_wrapper/src/models/SporifyImage.dart';

class Category {
  ///A link to the Web API endpoint returning
  /// full details of the category.
  String href;

  ///The category icon, in various sizes.
  List<SpotifyImage> icons;

  ///The Spotify category ID of the category.
  String id;

  ///The name of the category.
  String name;
}