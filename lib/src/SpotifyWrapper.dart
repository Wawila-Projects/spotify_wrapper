library spotify_wrapper;

import 'dart:async';
import 'dart:convert' show base64, utf8;

import 'package:spotify_wrapper/src/Endpoints/AlbumEndpoints.dart';
import 'package:spotify_wrapper/src/Endpoints/ArtistsEndpoints.dart';
import 'package:spotify_wrapper/src/Endpoints/AuthEndpoints.dart';
import 'package:spotify_wrapper/src/Endpoints/PlayerEndpoints.dart';
import 'package:spotify_wrapper/src/Endpoints/SearchEndpoints.dart';
import 'package:spotify_wrapper/src/Endpoints/TrackEndpoints.dart';
import 'package:spotify_wrapper/src/models/AccessToken.dart';

class SpotifyWrapper {
  static final SpotifyWrapper _instance = SpotifyWrapper._internal();
  SpotifyWrapper._internal();

  factory SpotifyWrapper() {
    return _instance;
  }

  String clientID;
  String _secretID;
  String get authToken =>  base64.encode(utf8.encode('$clientID:$_secretID'));
  
  AccessToken _accessToken; 
  String get accessToken => _accessToken?.token;

  AlbumEndpoints albumEndpoints = AlbumEndpoints();
  ArtistsEndpoints artistEndpoint = ArtistsEndpoints();
  PlayerEndpoints playerEndpoints = PlayerEndpoints();
  SearchEndpoints searchEndpoints = SearchEndpoints();
  TrackEndpoints trackEndpoints = TrackEndpoints();

  Future<void> initializeWrapper(String id, String secret, {List<String> scopes}) async {
    clientID = id;
    _secretID = secret;
    await setAccessToken(scopes: scopes);
  }

  Future<void> setAccessToken({List<String> scopes}) async {
    final authEndpoint = AuthEndpoints();
    if (scopes == null || scopes.isEmpty) {
      _accessToken = await authEndpoint.authClientCredentials();
      return;
    }
    _accessToken = await authEndpoint.authAuthorizeCode(scopes);
  }
}