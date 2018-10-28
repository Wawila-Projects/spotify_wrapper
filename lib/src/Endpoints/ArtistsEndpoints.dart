import 'dart:async';

import 'package:spotify_wrapper/src/Abstracts/Endpoints.dart';
import 'package:spotify_wrapper/src/models/Artist.dart';
import 'package:spotify_wrapper/src/models/Paging.dart';
import 'package:spotify_wrapper/src/models/Track.dart';
import 'package:spotify_wrapper/src/models/Types.dart';

class ArtistsEndpoints extends Endpoints {
  final urlSegment = 'artists';

  ///Get an Artist
  Future<Artist> getArtist(String id, [String market]) async {
    final response = await httpGet('$urlSegment/$id${buildUrl(market: market)}');
    return Artist.fromJSON(response);
  }
  
  ///Get an Artist's Albums
  ///
  ///__Query Parameters__ (_optionals_):
  ///
  ///* [includeGroups]: A list of keywords that will be used to 
  ///filter the response. If not supplied, all album types will be returned.
  ///Valid values are: `album`, `single`, `appears_on`, `compilation`
  ///
  ///* [market]: An [ISO 3166-1 alpha-2 country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) 
  ///or the string [from_token]. Supply this parameter to limit the 
  ///response to one particular geographical market. _If not given, 
  ///results will be returned for all markets and you are likely to 
  ///get duplicate results per album, one for each market in which 
  ///the album is available!_
  ///
  ///* [limit]: The number of album objects to return. Default: `20`. 
  ///Minimum: `1`. Maximum: `50`.
  ///
  ///* [offset]: The index of the first album to return. Default: `0` 
  ///(i.e., the first album). Use with limit to get the next set of albums.
  Future<Paging> getAlbums(String id, [List<String> includeGroups, String market, int limit, int offset]) async {
    final baseUrl = '$urlSegment/$id/albums';
    final query = buildUrl(includeGroups: includeGroups,market: market,limit: limit, offset: offset);
    final response = await httpGet('$baseUrl$query');
    return Paging.fromJSON(SpotifyType.Album, response);
  } 
  
  ///Get an Artist's Top Tracks.
  ///Return a maximum of `10` Tracks.
  ///
  ///[market]: _Required_. An [ISO 3166-1 alpha-2 country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) 
  ///or the string [from_token]. 
  Future<List<Track>> getTopTracks(String id, String market) async {
    final baseUrl = '$urlSegment/$id/top-tracks';
    final query = buildUrl(market: market);
    final response = await httpGet('$baseUrl$query');
    final values = List<Map<String, dynamic>>.from(response['tracks']);
    var tracks = List<Track>();
    for (var value in values) {
      tracks.add(Track.fromJSON(value));
    }
    return tracks;
  }

  ///Get an Artist's Related Artists.
  ///Returns a maximum of `20` Artists.
  Future<List<Artist>> getRelatedArtists(String id) async {
    final response = await httpGet('$urlSegment/$id/related-artists');
    final values = List<Map<String, dynamic>>.from(response['artists']);
    var artists = List<Artist>();
    for (var value in values) {
      artists.add(Artist.fromJSON(value));
    }
    return artists;
  }

  ///Get Several Artists
  ///
  ///Objects are returned in the order requested. If an object is not found, 
  ///a `null` value is returned in the appropriate position. Duplicate [ids] in 
  ///the query will result in duplicate objects in the response. 
  Future<List<Artist>> getArtists(List<String> ids) async {
    final query = '?ids=${ids.join(',')}';
    final response = await httpGet('$urlSegment/$query');
    final values = List<Map<String, dynamic>>.from(response['artists']);
    var artists = List<Artist>();
    for (var value in values) {
      artists.add(Artist.fromJSON(value));
    }
    return artists;
  }
}