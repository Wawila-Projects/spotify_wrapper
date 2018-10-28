import 'package:spotify_wrapper/src/Abstracts/SpotifyObject.dart';
import 'package:spotify_wrapper/src/models/Context.dart';
import 'package:spotify_wrapper/src/models/Track.dart';
import 'package:spotify_wrapper/src/models/Types.dart';

class PlayHistory extends SpotifyObject{
  ///The track the user listened to.
  TrackSimplified track;

  ///The date and time the track was played.
  DateTime playedAt;

  ///The context the track was played from.
  Context context;

  PlayHistory(this.track, this.playedAt, this.context) : 
    super (SpotifyType.PlayHistory);

  factory PlayHistory.fromJSON(Map<String, dynamic> json) {
      final track = TrackSimplified.fromJSON(json['track']);
      final playedAt = DateTime.parse(json['played_at']);
      final context = Context.fromJSON(json['context']);
      return PlayHistory(track, playedAt, context);
  }
}