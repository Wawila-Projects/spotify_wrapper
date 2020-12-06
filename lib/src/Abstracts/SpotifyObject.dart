import 'package:spotify_wrapper/src/models/Types.dart';

abstract class SpotifyObject {
  final SpotifyType type;

  const SpotifyObject(this.type);
}