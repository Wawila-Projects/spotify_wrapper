import 'dart:async';

import 'package:spotify_wrapper/src/Abstracts/Endpoints.dart';
import 'package:spotify_wrapper/src/Exceptions/QueryException.dart';
import 'package:spotify_wrapper/src/models/Paging.dart';
import 'package:spotify_wrapper/src/models/Types.dart';

///For a more complete documentation refer to
///[the official documentation].(https://developer.spotify.com/documentation/web-api/reference/search/search/)
class SearchEndpoints extends Endpoints {  
  final urlSegment = 'search';
  QueriableSearch _search;

  SearchEndpoints() {
    _search = QueriableSearch(this);
  }

  QueriableSearch queryTypes(List<SpotifyType> types) {
    _search.query = '';
    _search.selected = types.map((t) => t.toString().split('.')[1]
                                        .toLowerCase()).join(',');
    return _search;
  }

  String getCurrentQuery() {
    return _search.currentQuery;
  }

  Future<Map<SpotifyType, Paging>> searchByFullQuery(String query) async {
      final response = await httpGet('$urlSegment?q=$query');
      var result = Map<SpotifyType, Paging>();
      
      var value = _breakdownJsonAlbum(response['albums']);
      if (value != null) {
        result[SpotifyType.Album] = value;
      }
      value = _breakdownJsonArtist(response['artists']);
      if (value != null) {
        result[SpotifyType.Artist] = value;
      }
      value = _breakdownJsonTrack(response['tracks']);
      if (value != null) {
        result[SpotifyType.Track] = value;
      }

      return result;
  }

  Paging _breakdownJsonAlbum(Map<String, dynamic> json) {
    if (json == null) return null;
    return Paging.fromJSON(SpotifyType.Album, json);
  }

  Paging _breakdownJsonArtist(Map<String, dynamic> json) {
    if (json == null) return null;
    return Paging.fromJSON(SpotifyType.Artist, json);
  }

  Paging _breakdownJsonTrack(Map<String, dynamic> json) {
    if (json == null) return null;
    return Paging.fromJSON(SpotifyType.Track, json);
  }
}

class QueriableSearch {
  SearchEndpoints endpoint;
  QueriableSearch(this.endpoint);

  String query = '';
  List<String> filters = [];
  String selected;

  String get currentQuery => '${this.query}&type=$selected${_buildQuery()}';

  bool _orUsed = false;
  bool _multipleSelect = false;

  Future<Map<SpotifyType, Paging>> search() {
    final query = currentQuery;

    final matches = '*'.allMatches(query);
    if (matches.length > 2) {
      throw QueryException.WildcardLimit();
    }

    final result = endpoint.searchByFullQuery(query); 
    _resetArguments();
    return result;
  }

  void _resetArguments() {
    filters = [];
    query = '';
    _orUsed = false;
    _multipleSelect = false;
  }

  String _buildQuery() {
    if (filters.isEmpty) return '';
    return '&${filters.join('&')}';
  }

  QueriableSearch select(SpotifyType type) {
    if (_multipleSelect) {
      query += '%20';
    }
    query += '${type.toString().split('.')[1].toLowerCase()}:';
    _multipleSelect = true;
    return this;
  }

  QueriableSearch matchLiteral(String query, {bool not, bool or}) {
    if (not != null) {
      this.query += '%20NOT%20';
    } else if (or != null) {
       if(_orUsed) {
         throw QueryException.OrLimit();
       }
      this.query += '%20OR%20';
      _orUsed = true;
    }
    this.query += '"${query.replaceAll(' ', '%20')}"';
    return this;
  }

  QueriableSearch matchIncluding(String query, {bool not, bool or}) {
    if (not != null) {
      this.query += '%20NOT%20';
    } else if (or != null) {
       if(_orUsed) {
         throw QueryException.OrLimit();
       }
      this.query += '%20OR%20';
    }
    this.query += '${query.replaceAll(' ', '%20')}';
    return this;
  }

  QueriableSearch filterYear(int year, {int range}) {
    query += '%20year:$year${range != null ? '-$range' : ''}';
    return this;
  }

  QueriableSearch filter({String market, int limit, int offset}) {
    if (market != null) {
      filters.add('market=$market');
    }
    if (limit != null) {
      filters.add('limit=${limit.toString()}');
    }
    if (offset != null) {
      filters.add('offset=${offset.toString()}');
    }
    return this;
  }
}