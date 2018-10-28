import 'package:spotify_wrapper/src/Abstracts/SpotifyObject.dart';
import 'package:spotify_wrapper/src/models/Album.dart';
import 'package:spotify_wrapper/src/models/Artist.dart';
import 'package:spotify_wrapper/src/models/Track.dart';
import 'package:spotify_wrapper/src/models/Types.dart';
///The offset-based paging object is a container for a set of objects.
///It contains a key called [items] (whose value is an array of the 
///requested objects) along with other keys like [previous], [next] and 
///[limit] that can be useful in future calls.
class Paging {
  ///A link to the Web API endpoint returning the full result of the request.
  String href;

  ///The requested Data. 
  ///
  ///It can be any Spotify Object. For example:
  ///`Track`, `Artist`, `Album` or `Playlist` 
  List<SpotifyObject> items;

  SpotifyType itemType;

  ///The maximum number of items in the response (as set in the query or by default).
  int limit;

  ///URL to the next page of items. (`null` if none)
  String next;

  ///The offset of the items returned (as set in the query or by default).
  int offset;

  ///URL to the previous page of items. (`null` if none)
  String previous;

  ///The maximum number of items available to return.
  int total;

  Paging(this.href, this.items, this.itemType, this.limit, 
        this.next, this.offset, this.previous, this.total);

  factory Paging.fromJSON(SpotifyType type, Map<String, dynamic> json) {
    var items = List<SpotifyObject>();
    final objects = List<Map<String, dynamic>>.from(json['items']);
    switch (type) {
      case SpotifyType.Album:
        items = objects.map((i) => AlbumSimplified.fromJSON(i)).toList();
        break;
      case SpotifyType.Artist:
        items = objects.map((i) => ArtistSimplified.fromJSON(i)).toList();
        break;
      case SpotifyType.Track:
        items = objects.map((i) => TrackSimplified.fromJSON(i)).toList();
        break;
      default: 
        return null;
    }

    return Paging(json['href'], items, type, json['limit'], json['next'], 
                  json['offset'], json['previous'], json['total']);
  }
}