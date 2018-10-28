import 'package:spotify_wrapper/src/Abstracts/SpotifyObject.dart';
import 'package:spotify_wrapper/src/models/ExternalUrl.dart';
import 'package:spotify_wrapper/src/models/Types.dart';

class TrackLink extends SpotifyObject {
  ///Known external URLs for this track.
  ExternalUrls externalUrls;

  ///A link to the Web API endpoint providing full details of the track.
  String href;

  ///The Spotify ID for the track.
  String id;

  ///The Spotify URI for the track.
  String uri;

  TrackLink(this.externalUrls, this.href, this.id, this.uri): 
    super(SpotifyType.Track);

  factory TrackLink.fromJSON(Map<String, dynamic> json) {
    if (json == null) return null;
    final externalUrls = ExternalUrls.fromJSON(json['external_urls']);
    return TrackLink(externalUrls, json['href'], json['id'], json['uri']);
  }
}