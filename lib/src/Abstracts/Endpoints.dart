import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spotify_wrapper/src/Exceptions/HttpException.dart';
import 'package:spotify_wrapper/spotify_wrapper.dart';

abstract class Endpoints {
  final _basePath = 'https://api.spotify.com/v1';
  final _validStatusCodes = [200, 201, 202];

  Future<Map<String, dynamic>> httpGet(String url, {Map<String, String> headers}) async {
    var allheaders = {
      'Content-Type': 'application/json',    
      'Authorization': 'Bearer ${SpotifyWrapper().accessToken}'
      };
    if (headers != null) {
      allheaders.addAll(headers);
    }

    final response =  await http.get('$_basePath/$url', headers: allheaders);
    final data = json.decode(response.body);
    if (_validStatusCodes.contains(response.statusCode)) {
      return data;
    }
    throw HttpExeption(response.statusCode, message: data['error']['message']);
  }
  
  Future<Map<String, dynamic>> httpPut(String url, {Map<String, String> headers, String body}) async {
    var allheaders = {
      'Content-Type': 'application/json',    
      'Authorization': 'Bearer ${SpotifyWrapper().accessToken}'
      };
    if (headers != null) {
      allheaders.addAll(headers);
    }
   
    final response =  await http.put('$_basePath/$url', headers: allheaders, body: body);
    final data = json.decode(response.body);
    if (_validStatusCodes.contains(response.statusCode)) {
      return data;
    }
    throw HttpExeption(response.statusCode, message: data['error']['message']);
  }

  Future<Map<String, dynamic>> httpPost(String url, {Map<String, String> headers, String body}) async {
    var allheaders = {
      'Content-Type': 'application/json',    
      'Authorization': 'Bearer ${SpotifyWrapper().accessToken}'
      };
    if (headers != null) {
      allheaders.addAll(headers);
    }
   
    final response =  await http.post('$_basePath/$url', headers: allheaders, body: body);
    final data = json.decode(response.body);
    if (_validStatusCodes.contains(response.statusCode)) {
      return data;
    }
    throw HttpExeption(response.statusCode, message: data['error']['message']);
  }

  Future<Map<String, dynamic>> httpDelete(String url, {Map<String, String> headers}) async {
    var allheaders = {
      'Content-Type': 'application/json',    
      'Authorization': 'Bearer ${SpotifyWrapper().accessToken}'
      };
    if (headers != null) {
      allheaders.addAll(headers);
    }
    
    final response =  await http.delete('$_basePath/$url', headers: allheaders);
    final data = json.decode(response.body);
    if (_validStatusCodes.contains(response.statusCode)) {
      return data;
    }
    throw HttpExeption(response.statusCode, message: data['error']['message']);
  }

  String buildUrl({List<String> includeGroups, String market, int limit, int offset}) {
    var url = '?';
    if (includeGroups != null) {
      url += 'include_gorups=${includeGroups.join(',')}&';
    }
    if (market != null) {
      url += 'market=${market.toUpperCase()}&';
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