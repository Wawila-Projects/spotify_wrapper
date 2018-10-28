import 'dart:async';

import 'package:spotify_wrapper/src/Abstracts/Endpoints.dart';
import 'package:spotify_wrapper/src/models/Device.dart';
import 'package:spotify_wrapper/src/models/PlayingContext.dart';
import 'package:spotify_wrapper/src/models/CursorBasedPaging.dart';
import 'package:spotify_wrapper/src/models/Types.dart';

///__Beta__.
///These endpoints are in Beta. While we encourage you to build with them, 
///a situation may arise where we need to disable some or all of the 
///functionality and/or change how they work without prior notice. Please 
///report any issues via our 
///[GitHub issue tracker](https://github.com/spotify/web-api/issues).
///
///You can read more about how to work with the Spotify Connect Web API 
///[here](https://developer.spotify.com/documentation/web-api/guides/using-connect-web-api/).
class PlayerEndpoints extends Endpoints {
  final urlSegement = 'me/player';

  ///Get a User's Available Devices
  Future<List<Device>> getAvailableDevices() async {
    final response = await httpGet('$urlSegement/devices');
    final values = List<Map<String, dynamic>>.from(response['devices']);
    var devices = List<Device>();
    for (var device in values) {
      devices.add(Device.fromJSON(device));
    }
    return devices;
  }

  ///Get Current User's Recently Played Tracks
  ///
  ///__Query Parameters__ (_optionals_):
  ///
  ///* [limit]: The maximum number of items to return. Default: `20`. 
  ///Minimum: `1`. Maximum: `50`.
  ///
  ///* [after]: A Unix timestamp in milliseconds. Returns all items 
  ///after (but not including) this cursor position. If [after] is 
  ///specified, [before] must not be specified.
  ///
  ///* [before]: A Unix timestamp in milliseconds. Returns all items 
  ///before (but not including) this cursor position. If [before] is 
  ///specified, [after] must not be specified.
  Future<CursorBasedPaging> getRecentlyPlayed({int limit, int before, int after}) async {
    var query = '';
    if (limit != null) {
      query = '?limit=$limit';
    }
    if (before != null) {
      if (query.isEmpty) {
        query = '?before=$before';
      } else {
        query += '&before=$before';
      }
    }
    if (after != null) {
      if (query.isEmpty) {
        query = '?after=$after';
      } else {
        query += '&after=$after';
      }
    }
    final response = await httpGet('$urlSegement/recently-played$query');
    final history = CursorBasedPaging.fromJSON(SpotifyType.PlayHistory, response);
    return history;
  }

  ///Get Information About The User's Current Playback
  Future<PlayingContext> getPlayingContext() async {
    final response = await httpGet('$urlSegement');
    return PlayingContext.fromJSON(response);
  }

  ///Start/Resume a User's Playback
  Future<void> play({String deviceID, String contextUri, 
    List<String> uris, Map<String, dynamic> object, int positionMS}) async {
    var body = {
      'context_uri': contextUri,
      'uris': uris,
      'object': object,
      'position_ms': positionMS
    };
    
    body.removeWhere((k,v) => v == null);

    var query = '';
    if (deviceID != null) {
      query = '?device_id=$deviceID';
    }
    await httpPut('$urlSegement/play$query');
  }

  ///Pause a User's Playback
  Future<Map<String, dynamic>> pause({String deviceID}) async {
    var query = '';
    if (deviceID != null) {
      query = '?device_id=$deviceID';
    }
   final response = await httpPut('$urlSegement/pause$query');
   print('Response =  $response');
   return response;
  }

  ///Seek To Position In Currently Playing Track
  Future<void> seek(int positionMS, {String deviceID}) async {
    var query = '';
    if (deviceID != null) {
      query = '&device_id=$deviceID';
    }
    await httpPut('$urlSegement/next?position_ms=$positionMS$query');
  }

  ///Skip User’s Playback To Next Track
  Future<void> next({String deviceID}) async {
    var query = '';
    if (deviceID != null) {
      query = '?device_id=$deviceID';
    }
    await httpPost('$urlSegement/next$query');
  }

  ///Skip User’s Playback To Previous Track
  Future<void> previous({String deviceID}) async {
    var query = '';
    if (deviceID != null) {
      query = '?device_id=$deviceID';
    }
    await httpPost('$urlSegement/previous$query');
  }

  ///Set Repeat Mode On User’s Playback
  ///
  ///[state] = `track`, `context` or `off`
  ///* `track` will repeat the current track.
  ///* `context` will repeat the current context.
  ///* `off` will turn repeat off.
  Future<void> repeat(String state, {String deviceID}) async {
    var query = '';
    if (deviceID != null) {
      query = '&device_id=$deviceID';
    }
    await httpPut('$urlSegement/repeat?state=$state$query');
  }


  ///Set Volume For User's Playback
  ///
  ///[volumePercent]: The volume to set. Must be a value from 0 to 100 inclusive.
  Future<void> volume(int volumePercent, {String deviceID}) async {
    var query = '';
    if (deviceID != null) {
      query = '&device_id=$deviceID';
    }
    await httpPut('$urlSegement/volume?volume_perfcent=$volumePercent$query');
  }

  ///Toggle Shuffle For User’s Playback
  Future<void> shuffle(bool state, {String deviceID}) async {
    var query = '';
    if (deviceID != null) {
      query = '&device_id=$deviceID';
    }
    await httpPut('$urlSegement/repeat?state=$state$query');
  }
}