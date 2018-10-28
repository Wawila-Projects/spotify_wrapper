import 'package:spotify_wrapper/src/Abstracts/SpotifyObject.dart';
import 'package:spotify_wrapper/src/models/Album.dart';
import 'package:spotify_wrapper/src/models/Artist.dart';
import 'package:spotify_wrapper/src/models/Date.dart';
import 'package:spotify_wrapper/src/models/ExternalID.dart';
import 'package:spotify_wrapper/src/models/ExternalUrl.dart';
import 'package:spotify_wrapper/src/models/TrackLink.dart';
import 'package:spotify_wrapper/src/models/Types.dart';
import 'package:spotify_wrapper/src/models/User.dart';

class TrackSimplified extends SpotifyObject {
  ///The artists who performed the track. Each artist object includes 
  ///a link in [href] to more detailed information about the artist.
  List<ArtistSimplified> artists;
  
  ///A list of the countries in which the track can be played,
  ///identified by their ISO 3166-1 alpha-2 code.
  List<String> availableMarkets;

  ///The disc number (usually [1] unless the 
  ///album consists of more than one disc).
  int discNumber;

  ///The track length in milliseconds.
  int durationMS;

  ///Whether or not the track has explicit lyrics 
  ///([true] = yes it does; [false] = no it does not OR unknown).
  bool explicit;

  ///External URLs for this track.
  ExternalUrls externalUrls;	

  ///A link to the Web API endpoint providing full details of the track.
  String href; 

  //The Spotify ID for the track.
  String id;

  ///Part of the response when Track Relinking is applied. 
  ///If [true] , the track is playable in the given market. Otherwise [false].
  bool isPlayable;

  ///Part of the response when Track Relinking is applied and is only 
  ///part of the response if the track linking, in fact, exists. The 
  ///requested track has been replaced with a different track. The 
  ///track in the linked_from object contains  information about the 
  ///originally requested track.
  TrackLink linkedFrom;

  ///Part of the response when Track Relinking is applied, the original 
  ///track is not available in the given market, and Spotify did not have
  /// any tracks to relink it with. The track response will still contain
  ///  metadata for the original track, and a restrictions object containing 
  /// the reason why the track is not available: 
  /// `"restrictions" : {"reason" : "market"}`
  Map<String, dynamic> restrictions;

  ///The name of the track.
  String name;

  ///A link to a 30 second preview (MP3 format) of the track. Can be [null].
  String previewUrl;

  ///The number of the track. If an album has several discs, the track number
  /// is the number on the specified disc.
  int trackNumber;

  ///The Spotify URI for the track.
  String uri; 

  ///Whether or not the track is from a local file.
  bool isLocal; 

  TrackSimplified(this.artists, this.availableMarkets, this.discNumber, this.durationMS,
    this.explicit, this.externalUrls, this.href, this.id, this.isPlayable,
    this.linkedFrom, this.restrictions, this.name, this.previewUrl, this.trackNumber,
    this.uri, this.isLocal): super(SpotifyType.Track);

  // factory TrackSimplified.fromTrack(Track track) {
  //   return TrackSimplified(track.artists, track.availableMarkets, track.discNumber, 
  //       track.durationMS, track.explicit, track.externalUrls, track.type, track.href,
  //       track.id, track.isPlayable, track.linkedFrom, track.restrictions, track.name,
  //       track.previewUrl, track.trackNumber, track.uri, track.isLocal);
  // }

  factory TrackSimplified.fromJSON(Map<String, dynamic> json) {
    final externalUrls = ExternalUrls.fromJSON(json['external_urls']);
    final trackLink = TrackLink.fromJSON(json['linked_from']);
    var artists = List<ArtistSimplified>();
    for (var artist in json['artists']) {
      artists.add(ArtistSimplified.fromJSON(artist));
    }
    return TrackSimplified(artists, json['availableMarkets'], json['discNumber'], 
                    json['durationMS'], json['explicit'], externalUrls, 
                    json['href'], json['id'], json['isPlayable'], 
                    trackLink, json['restrictions'], json['name'], 
                    json['previewUrl'], json['trackNumber'], 
                    json['uri'], json['isLocal']);
    }
}

class Track extends TrackSimplified {
  ///The album on which the track appears. The album object includes 
  ///a link in [href] to full information about the album.
  AlbumSimplified album;

  ///Known external IDs for the track.
  ExternalIDs externalIds;

  ///The popularity of the track. The value will be between 0 and 100, with 100 
  ///being the most popular.
  ///
  ///The popularity of a track is a value between 0 and 100, with 100 being the 
  ///most popular. The popularity is calculated by algorithm and is based, in 
  ///the most part, on the total number of plays the track has had and how recent
  ///those plays are.
  ///
  ///Generally speaking, songs that are being played a lot now will have a higher
  ///popularity than songs that were played a lot in the past. Duplicate tracks 
  ///(e.g. the same track from a single and an album) are rated independently. 
  ///Artist and album popularity is derived mathematically from track popularity.
  ///Note that the popularity value may lag actual popularity by a few days: the
  ///value is not updated in real time.
  int popularity;

  Track.fromTrack(TrackSimplified track, this.album, this.externalIds, this.popularity): 
  super(track.artists, track.availableMarkets, track.discNumber, track.durationMS,
        track.explicit, track.externalUrls, track.href, track.id,
        track.isPlayable, track.linkedFrom, track.restrictions, track.name,
        track.previewUrl, track.trackNumber, track.uri, track.isLocal);

  factory Track.fromJSON(Map<String, dynamic> json) {
    final track = TrackSimplified.fromJSON(json);
    final externalIds = ExternalIDs.fromJSON(json['external_ids']);
    final album = AlbumSimplified.fromJSON(json['album']);
    return  Track.fromTrack(track, album, externalIds, json['popularity']);
  }
}

class PlaylistTrack {
  ///The date and time the track was added.
  ///_Note that some very old playlists may return `null` in this field_.
  Date addedAt;

  ///The Spotify user who added the track.
  ///_Note that some very old playlists may return `null` in this field_.
  User addedBy;

  ///Whether this track is a [local file](https://developer.spotify.com/documentation/general/guides/local-files-spotify-playlists/) 
  ///or not.
  bool isLocal;

  ///Information about the track.
  Track track;

  PlaylistTrack(this.addedAt, this.addedBy, this.isLocal, this.track);
}