import 'dart:convert';
import 'dart:io';

import 'package:spotify_wrapper/spotify_wrapper.dart';
import 'package:test/test.dart';
//import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Enum Utils', () {
    test('SpotifyType from String', () {
      final possibleEnum = EnumUtils.enumFromString<SpotifyType>("track");
      expect(possibleEnum, SpotifyType.Track);
    });

    test('SpotifyType from Int', () {
      final possibleEnum = SpotifyType.values[2];
      expect(possibleEnum, SpotifyType.Track);
    });

    test('Enum from String with Error: value not found', () {
      expect(()=> EnumUtils.enumFromString<SpotifyType>("Exception"), throws);
    });

    test('Enum from Int with Error: out of bounds', () {
      expect(() =>  SpotifyType.values[99], throws);
    });
  });

  group('Factories from json', () {
    Map<String, dynamic> source;

    setUp(() async {
      final file = await File('./test/sources/sources.json').readAsString();
      source = jsonDecode(file);
    });

    test('Create Album', () async {
      final album = Album.fromJSON(source['album']);
      final test = album.name == 'She\'s So Unusual' && 
                  album.artists[0].name == 'Cyndi Lauper' &&
                  album.tracks.items.length == 1;
      expect(test, true);
    });

     test('Create Artist', () async {
      final artist = Artist.fromJSON(source['artist']);
      final test = artist.name == 'Band of Horses' && artist.popularity == 59 &&
                    artist.uri == 'spotify:artist:0OdUWJ0sBjDrqHygGUXeCF' && 
                    artist.id == '0OdUWJ0sBjDrqHygGUXeCF';
      expect(test, true);
    });

    test('Create Album Paging object', () async {
      final paging = Paging.fromJSON(SpotifyType.Album, source['album_paging']);
      final test = paging.items.length == 2 && paging.itemType == SpotifyType.Album;
      expect(test, true);
    });

    test('Create Track', () async {
      final track = Track.fromJSON(source['track']);
      final test = track.name == 'Cut To The Feeling' &&
                   track.album.name == 'Cut To The Feeling' &&
                   track.artists[0].name == 'Carly Rae Jepsen';
      expect(test, true);
    });
  });

  group('Artist Endpoints', () {
    Map<String, dynamic> source;
    
    setUp(() async {
      await SpotifyWrapper().initializeWrapper('4ed590485fc14c118e6f421070254274', 
                                         'aec2dcef06964fdea3897bba920339cb');
      final file = await File('./test/sources/sources.json').readAsString();
      source = jsonDecode(file);
    });
    test('Get Artist', () async {
      final artist = await SpotifyWrapper().artistEndpoint.getArtist('0OdUWJ0sBjDrqHygGUXeCF');
      final local = Artist.fromJSON(source['artist']);
      final test = artist.name == local.name && artist.id == local.id; 
      expect(test, true);
    });
  });

  group('URL Query Creation', () {
    setUp(() async {
        await SpotifyWrapper().initializeWrapper('4ed590485fc14c118e6f421070254274', 
                                          'aec2dcef06964fdea3897bba920339cb');
    });

    test('Search for Artist', () {
      SpotifyWrapper().searchEndpoints.queryTypes([SpotifyType.Artist])
          .matchIncluding('tania bowra');
      final query = SpotifyWrapper().searchEndpoints.getCurrentQuery();
      final test = 'tania%20bowra&type=artist';
      expect(query, test);
    });

    test('Search for Albums - Name Matching “Arrival” and Artist Matching “ABBA”', () {
      SpotifyWrapper().searchEndpoints.queryTypes([SpotifyType.Album])
          .select(SpotifyType.Album).matchIncluding('arrival')
          .select(SpotifyType.Artist).matchIncluding('abba');
      final query = SpotifyWrapper().searchEndpoints.getCurrentQuery();
      final test = 'album:arrival%20artist:abba&type=album';
      expect(query, test);
    });

    test('Search for Artists - Name Matching “Bob”, Offset, and Limit', () {
      SpotifyWrapper().searchEndpoints.queryTypes([SpotifyType.Artist])
          .matchIncluding('bob').filter(offset: 20, limit: 2);
      final query = SpotifyWrapper().searchEndpoints.getCurrentQuery();
      final test = 'bob&type=artist&limit=2&offset=20';
      expect(query, test);
    });
  });

  // group('Auth Grant Scopes', () {
  //   setUp(() async {
  //     await SpotifyWrapper().initializeWrapper(
  //       '4ed590485fc14c118e6f421070254274', 'aec2dcef06964fdea3897bba920339cb',
  //       scopes: [AuthScopes.userReadCurrentlyPlaying, AuthScopes.userReadRecentlyPlayed,
  //                AuthScopes.userModifyPlaybackState]);
  //   });

  //   test('Pause Player', () async {
  //     print('print');
  //     final response = await SpotifyWrapper().playerEndpoints.pause();
  //     print(response);
  //     expect(response != null, true);
  //   });
  // });
}
