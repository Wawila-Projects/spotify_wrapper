import 'package:spotify_wrapper/src/models/Album.dart';
import 'package:spotify_wrapper/src/models/Date.dart';

class SavedAlbum {
  ///The date and time the album was saved.
  Date addedAt;

  ///Information about the album.
  Album album;
}