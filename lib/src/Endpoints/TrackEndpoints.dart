import 'dart:async';

import 'package:spotify_wrapper/src/Abstracts/Endpoints.dart';
import 'package:spotify_wrapper/src/models/Track.dart';

class TrackEndpoints extends Endpoints {
  final urlSegment = 'tracks';

  ///Get a Track
  Future<Track> getTrack(String id, [String market]) async {
    final reponse = await httpGet('$urlSegment/$id${buildUrl(market: market)}');
    return Track.fromJSON(reponse);
  }

  ///Get Several Tracks
  ///
  ///Objects are returned in the order requested. If an object is not found, 
  ///a `null` value is returned in the appropriate position. Duplicate [ids] in 
  ///the query will result in duplicate objects in the response.
  Future<List<Track>> getSeveralTracks(List<String> ids) async {
    final query = '?ids=${ids.join(',')}';
    final response = await httpGet('$urlSegment/$query');
    final values = List<Map<String, dynamic>>.from(response['albums']);
    var tracks = List<Track>();
    for (var track in values) {
      tracks.add(Track.fromJSON(track));
    }
    return tracks;
  }
}
