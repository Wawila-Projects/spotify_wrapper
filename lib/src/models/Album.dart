import 'package:spotify_wrapper/src/Abstracts/SpotifyObject.dart';
import 'package:spotify_wrapper/src/StaticClasses/EnumUtils.dart';
import 'package:spotify_wrapper/src/models/Artist.dart';
import 'package:spotify_wrapper/src/models/Copyright.dart';
import 'package:spotify_wrapper/src/models/Date.dart';
import 'package:spotify_wrapper/src/models/ExternalID.dart';
import 'package:spotify_wrapper/src/models/ExternalUrl.dart';
import 'package:spotify_wrapper/src/models/Paging.dart';
import 'package:spotify_wrapper/src/models/SporifyImage.dart';
import 'package:spotify_wrapper/src/models/Types.dart';

class AlbumSimplified extends SpotifyObject {
  ///_Optional_. The field is present when getting an artist’s albums. 
  ///Possible values are “album”, “single”, “compilation”, “appears_on”. 
  ///Compare to album_type this field represents relationship between 
  ///the artist and the album.
  String albumGroup;

  ///The type of the album: one of [album], [single], or [compilation].
  AlbumType albumType;

  ///The artists of the album. Each artist object includes 
  ///a link in [href] to more detailed information about the artist.
  List<ArtistSimplified> artists;

  ///A list of the countries in which the album can be played,
  ///identified by their ISO 3166-1 alpha-2 code.
  List<String> availableMarkets;

  ///External URLs for this album.
  ExternalUrls externalUrls;	

  ///A link to the Web API endpoint providing full details of the album.
  String href; 

  //The Spotify ID for the album.
  String id;

  ///The cover art for the album in various sizes, widest first.
  List<SpotifyImage> images;

  ///The name of the album.
  String name;

  ///Costume class to encapsulate the release date and the precision
  Date releaseDate;

  ///Part of the response when Track Relinking is applied, the original 
  ///track is not available in the given market, and Spotify did not have
  ///any tracks to relink it with. The track response will still contain
  ///metadata for the original track, and a restrictions object containing 
  ///the reason why the track is not available: 
  /// ```"restrictions" : {"reason" : "market"}```
  Map<String, dynamic> restrictions;
  
  ///The Spotify URI for the album.
  String uri; 

  AlbumSimplified(this.albumGroup, this.albumType, this.artists, this.externalUrls, this.href, 
                  this.availableMarkets, this.id, this.images, 
                  this.name, this.releaseDate, 
                  this.restrictions, this.uri): super(SpotifyType.Album);   

  factory AlbumSimplified.fromJSON(Map<String, dynamic> json) {
    final albumType = EnumUtils.enumFromString<AlbumType>(json['album_type']);
    final availableMarkets = List<String>.from(json['available_markets']);
    final externalUrls = ExternalUrls.fromJSON(json['external_urls']);
    final restrictions = Map<String, dynamic>.from(json['restrictions'] ?? {});
    final releaseDate = Date(json['release_date'], json['release_date_precision']);

    var artists = List<ArtistSimplified>();
    for (var artist  in json['artists']) {
      artists.add(ArtistSimplified.fromJSON(artist));
    }

    var images = List<SpotifyImage>();
    for (var image in json['images']) {
      images.add(SpotifyImage.fromJSON(image));
    }

    return AlbumSimplified(json['album_group'] ?? '', albumType, artists, 
                          externalUrls, json['href'], 
                          availableMarkets, json['id'], images, 
                          json['name'], releaseDate,
                          restrictions, json['uri']);
  }
}

class Album extends AlbumSimplified {

  ///The copyright statements of the album.
  List<Copyright> copyrights;

  ///Known external IDs for the album.
  ExternalIDs externalIds;

  ///A list of the genres used to classify the album. For example: 
  ///`Prog Rock`, `Post-Grunge`.
  ///
  /// (If not yet classified, the array is empty.)
  List<String> genres;

  ///The label for the album.
  String label;

  ///The popularity of the album. The value will be between 0 and 100, 
  ///with 100 being the most popular. The popularity is calculated from
  /// the popularity of the album’s individual tracks.
  int popularity;

  ///The tracks of the album.
  Paging tracks;


  Album.fromAlbum(AlbumSimplified album, this.copyrights, 
                  this.externalIds, this.genres, this.label, 
                  this.popularity, this.tracks) : 
        super(album.albumGroup, album.albumType, album.artists, 
              album.externalUrls, album.href, 
              album.availableMarkets, album.id, album.images, 
              album.name, album.releaseDate, 
              album.restrictions, album.uri);

  factory Album.fromJSON(Map<String, dynamic> json) {
    final genres = List<String>.from(json["genres"]);
    final label = json['label'];
    final externalIds = ExternalIDs.fromJSON(json['external_ids']);
    final tracks = Paging.fromJSON(SpotifyType.Track, json['tracks']);
    
    var copyrights = List<Copyright>(); 
    for (var copyright in json['copyrights']) {
      copyrights.add(Copyright.fromJSON(copyright));
    }
    final album = AlbumSimplified.fromJSON(json);
    return Album.fromAlbum(album, copyrights, externalIds, genres, 
                          label, json['popularity'], tracks);
  }
}


