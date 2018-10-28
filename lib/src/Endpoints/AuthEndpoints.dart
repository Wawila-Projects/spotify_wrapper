import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:spotify_wrapper/spotify_wrapper.dart';
import 'package:spotify_wrapper/src/models/AccessToken.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthEndpoints {
  final _tokenPath = 'https://accounts.spotify.com/api/token';
  final _authPath = 'https://accounts.spotify.com/authorize';
  final _redirectUrl = 'http://localhost:1337/';

  Future<AccessToken> authClientCredentials({String code}) async {
    final headers = {'Authorization': 'Basic ${SpotifyWrapper().authToken}'};
    var body = {'grant_type': 'client_credentials'}; 
    
    if (code != null) {
      body['grant_type'] = 'authorization_code';
      body['code'] = code;
      body['redirect_uri'] = _redirectUrl;
    }

    final response =  await http.post('$_tokenPath', headers: headers, body: body);
  
    if (response.statusCode == 200) {
      return AccessToken.fromJSON(json.decode(response.body));
    }
    return null;
  }

  Future<AccessToken> authAuthorizeCode(List<String> scopes) async {
    final onCode = await _initServer();

    final clientID = SpotifyWrapper().clientID;
    if (clientID == null) return null;
    
    final query = '?client_id=$clientID&response_type=code&redirect_uri=$_redirectUrl';
    final scope = '&scope=${scopes.join('%20')}';
    final url  = '$_authPath$query$scope';
    
    _launchURL(url);
    final String code = await onCode.first;
    final token = await authClientCredentials(code: code);
    return token;
  }


  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
}

  Future<Stream<String>> _initServer() async {
    final StreamController<String> onCode = new StreamController();
    var server =
    await HttpServer.bind(InternetAddress.loopbackIPv4, 1337, shared: true);
    server.listen((HttpRequest request) async {
      final String code = request.uri.queryParameters["code"];
      request.response
        ..statusCode = 200
        ..headers.set("Content-Type", ContentType.html.mimeType)
        ..write("<html><h1>You can now close this window</h1></html>");
      await request.response.close();
      await server.close(force: true);
      onCode.add(code);
      await onCode.close();
    });
    return onCode.stream;
  }
}