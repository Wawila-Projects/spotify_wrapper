import 'package:spotify_wrapper/src/Abstracts/SpotifyObject.dart';
import 'package:spotify_wrapper/src/models/ExternalUrl.dart';
import 'package:spotify_wrapper/src/models/Followers.dart';
import 'package:spotify_wrapper/src/models/SporifyImage.dart';
import 'package:spotify_wrapper/src/models/Types.dart';

class ArtistSimplified extends SpotifyObject {
  ///Known external URLs for this artist.
  ExternalUrls externalUrls;

  ///A link to the Web API endpoint providing full details of the artist.
  String href;

  ///	The Spotify ID for the artist.
  String id;

  ///The name of the artist.
  String name;  

  ///The Spotify URI for the artist.
  String uri;

  ArtistSimplified(this.externalUrls, this.href, this.id, 
          this.name, this.uri): super(SpotifyType.Artist);

  factory ArtistSimplified.fromJSON(Map<String, dynamic> json) {
    final urls = ExternalUrls.fromJSON(json['external_urls']);
    return ArtistSimplified(urls, json['href'], json['id'], 
                  json['name'], json['uri']);
  }
}

class Artist extends ArtistSimplified {
  ///Information about the followers of the artist.
  Followers followers;

  ///A list of the genres the artist is associated with.
  ///For example: `Prog Rock` , `Post-Grunge`. 
  ///
  ///(If not yet classified, the array is empty.)
  List<String> genres;

  ///Images of the artist in various sizes, widest first.
  List<SpotifyImage> images;

  ///The popularity of the artist. The value will be between 0 and 100, 
  ///with 100 being the most popular. The artist’s popularity is calculated 
  ///from the popularity of all the artist’s tracks.
  int popularity;

  Artist.fromArtist(ArtistSimplified artist, this.followers, this.genres, this.images, this.popularity) :
                super(artist.externalUrls, artist.href, artist.id, artist.name, artist.uri);

  factory Artist.fromJSON(Map<String, dynamic> json) {
    final artist = ArtistSimplified.fromJSON(json);
    final followers = Followers.fromJSON(json['followers']);
    final popularity = json['popularity'];
    final genres = List<String>.from(json['genres']);
    
    var images = List<SpotifyImage>();
    for (var value in json['images']) {
      images.add(SpotifyImage.fromJSON(value));
    }

    return Artist.fromArtist(artist, followers, genres, images, popularity);
  }
}