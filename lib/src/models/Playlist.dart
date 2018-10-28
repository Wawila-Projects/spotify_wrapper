import 'package:spotify_wrapper/src/Abstracts/SpotifyObject.dart';
import 'package:spotify_wrapper/src/models/ExternalUrl.dart';
import 'package:spotify_wrapper/src/models/Followers.dart';
import 'package:spotify_wrapper/src/models/SporifyImage.dart';
import 'package:spotify_wrapper/src/models/Track.dart';
import 'package:spotify_wrapper/src/models/Types.dart';
import 'package:spotify_wrapper/src/models/User.dart';

class Playlist /*extends SpotifyObject*/{
  ///Returns `true` if context is not search and the 
  ///owner allows other users to modify the playlist. 
  ///Otherwise returns `false`.
  bool coolaborative;

  ///External URLs for this playlist.
  ExternalUrls externalUrls;	

  ///A link to the Web API endpoint providing full details of the playlist.
  String href; 

  //The Spotify ID for the playlist.
  String id;

  ///Images for the playlist. The array may be empty or contain up 
  ///to three images. The images are returned by size in descending 
  ///order. See [Working with Playlists](https://developer.spotify.com/documentation/general/guides/working-with-playlists/).
  ///
  ///_Note: If returned, the source URL for the image ([url]) is 
  ///temporary and will expire in less than a day_.
  List<SpotifyImage> image;

  ///The name of the playlist.
  String name;

  ///The user who owns the playlist
  User owner; 

  ///The playlist’s public/private status: true the playlist is public,
  ///false the playlist is private, null the playlist status is not relevant. 
  ///For more about public/private status, 
  ///see [Working with Playlists](https://developer.spotify.com/documentation/general/guides/working-with-playlists/).
  bool public;

  ///The version identifier for the current playlist. Can be supplied in 
  ///other requests to target a specific playlist version
  String snapshotID;

  ///A collection containing a link ([href]) to the Web API endpoint where 
  ///full details of the playlist’s tracks can be retrieved, along with the 
  ///total number of tracks in the playlist.
  List<Track> tracks;

  ///The Spotify URI for the playlist.
  String uri;
}

class PlaylistFull extends Playlist{
  ///The playlist description. _Only returned for modified, 
  ///verified playlists, otherwise `null`_.
  String description;

  ///Information about the followers of the playlist.
  Followers followers;

  ///Information about the tracks of the playlist.
  ///
  ///Of type [PlaylistTrack] instead of [TrackFull]
  List<Track> tracks;
}