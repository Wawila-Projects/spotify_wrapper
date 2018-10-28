import 'package:spotify_wrapper/src/models/Types.dart';

abstract class SpotifyObject {
  SpotifyType type;

  SpotifyObject(this.type);
}