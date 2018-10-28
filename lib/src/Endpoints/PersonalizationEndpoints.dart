import 'dart:async';

import 'package:spotify_wrapper/src/Abstracts/Endpoints.dart';
import 'package:spotify_wrapper/src/models/Paging.dart';
import 'package:spotify_wrapper/src/models/Types.dart';

/// For more information read the 
/// [official documentation](https://developer.spotify.com/documentation/web-api/reference/personalization/get-users-top-artists-and-tracks/).
class PersonalizationEndpoints extends Endpoints {
  Future<Paging> getTopSongs({String timeRange, int limit, int offset}) async {
    final response = await _getTop(true, timeRange: timeRange, limit: limit, offset: offset);
    return Paging.fromJSON(SpotifyType.Track, response);
  }

  Future<Paging> getTopArtists({String timeRange, int limit, int offset}) async {
    final response = await _getTop(false, timeRange: timeRange, limit: limit, offset: offset);
    return Paging.fromJSON(SpotifyType.Artist, response);
  }

  Future<Map<String, dynamic>> _getTop(bool songs, {String timeRange, int limit, int offset}) async {
    final url = 'me/top/${songs ? 'tracks' : 'artists'}';
    final query = _buildUrl(timeRange: timeRange, limit: limit, offset: offset);
    final response = await httpGet('$url$query');
    return response;
  }

  String _buildUrl({String timeRange, int limit, int offset}) {
    var url = '?';
    if (timeRange != null) {
      url += 'time_range=${timeRange.toUpperCase()}&';
    }
    if (limit != null) {
      url += 'limit=$limit&';
    }
    if (offset != null) {
      url += 'offset=$offset';
    }
    if (url[url.length-1] == '&' || url[url.length-1] == '?') {
      url = url.substring(0, url.length-1);
    }
    return url;
  }
}
