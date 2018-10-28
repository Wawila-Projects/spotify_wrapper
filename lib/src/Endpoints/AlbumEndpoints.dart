import 'dart:async';

import 'package:spotify_wrapper/src/Abstracts/Endpoints.dart';
import 'package:spotify_wrapper/src/models/Album.dart';
import 'package:spotify_wrapper/src/models/Paging.dart';
import 'package:spotify_wrapper/src/models/Types.dart';

class AlbumEndpoints extends Endpoints {
  final urlSegment = 'albums';

  ///Get an Album
  Future<Album> getAlbum(String id, [String market]) async {
    final response = await httpGet('$urlSegment/$id${buildUrl(market: market)}');
    return Album.fromJSON(response);
  }

  ///Get an Album's Tracks
  ///
  ///__Query Parameters__ (_optionals_):
  ///
  ///* [market]: An [ISO 3166-1 alpha-2 country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) 
  ///or the string [from_token]. Supply this parameter if you want
  ///to apply [Track Relinking](https://developer.spotify.com/documentation/general/guides/track-relinking-guide/)
  ///
  ///* [limit]: The number of tracks to return. Default: `20`. 
  ///Minimum: `1`. Maximum: `50`.
  ///
  ///* [offset]: The index of the first track to return. Default: `0` 
  ///(the first album). Use with limit to get the next set of tracks.
  Future<Paging> getTracks(String id, [int limit, int offset, String market]) async {
    final baseUrl = '$urlSegment/$id/tracks';
    final query = buildUrl(limit: limit, offset: offset, market: market);
    final response = await httpGet('$baseUrl$query');
    return Paging.fromJSON(SpotifyType.Track, response);
  }

  ///Get Several Albums
  ///
  ///Objects are returned in the order requested. If an object is not found, 
  ///a `null` value is returned in the appropriate position. Duplicate [ids] in 
  ///the query will result in duplicate objects in the response. 
  Future<List<Album>> getAlbums(List<String> ids) async {
    final query = '?ids=${ids.join(',')}';
    final response = await httpGet('$urlSegment/$query');
    final values = List<Map<String, dynamic>>.from(response['albums']);
    var albums = List<Album>();
    for (var album in values) {
      albums.add(Album.fromJSON(album));
    }
    return albums;
  }
}