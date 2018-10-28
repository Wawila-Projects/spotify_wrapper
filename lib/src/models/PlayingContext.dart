import 'package:spotify_wrapper/src/StaticClasses/EnumUtils.dart';
import 'package:spotify_wrapper/src/models/Context.dart';
import 'package:spotify_wrapper/src/models/Device.dart';
import 'package:spotify_wrapper/src/models/Track.dart';
import 'package:spotify_wrapper/src/models/Types.dart';

class PlayingContext {
  ///The device that is currently active
  Device device;

  ///`off`, `track`, `context`
  RepeateState repeatState;

  ///If shuffle is on or off
  bool shuffleState;

  ///A Context Object. Can be `null` (e.g. If private 
  ///session is enabled this will be `null`).
  Context context;

  ///Timestamp when data was fetched
  DateTime timestamp;

  ///Progress into the currently playing track. Can be `null` 
  ///(e.g. If private session is enabled this will be `null`).
  Duration progress;

  ///If something is currently playing.
  bool isPlaying;

  ///The currently playing track. Can be `null` (e.g. 
  ///If private session is enabled this will be `null`).
  Track item;

  ///The object type of the currently playing item. 
  CurrentlyPlayingType currentlyPlayingType;


  PlayingContext(this.device, this.repeatState, this.shuffleState, 
                 this.context, this.timestamp, this.progress, 
                 this.isPlaying, this.item, this.currentlyPlayingType);

  factory PlayingContext.fromJSON(Map<String, dynamic> json) {
    final device = Device.fromJSON(json['device']);
    final context = Context.fromJSON(json['context']);
    final timestamp = DateTime.fromMicrosecondsSinceEpoch(json['timestamp']);
    final progress = Duration(milliseconds: json['progress_ms']);
    final track = Track.fromJSON(json['item']);
    final currentlyPlayingType = EnumUtils.enumFromString<CurrentlyPlayingType>(json['currently_playing_type']);
    return PlayingContext(device, json['repeat_state'], 
              json['shuffle_state'], context, timestamp, progress, 
              json['is_playing'], track, currentlyPlayingType);
  }
}