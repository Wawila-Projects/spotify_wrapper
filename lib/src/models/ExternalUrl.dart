import 'dart:collection';
import 'package:spotify_wrapper/src/StaticClasses/EnumUtils.dart';
import 'package:spotify_wrapper/src/models/Types.dart';

class ExternalUrls {
  
  ///__Key__: The type of the URL, for example:
  ///* `spotify` - The [Spotify URL](https://developer.spotify.com/documentation/web-api/#spotify-uris-and-ids) for the object.
  ///
  ///__Value__: An external, public URL to the object.
  HashMap<ExternalUrlType, String> externalUrls;

  ExternalUrls(this.externalUrls);
  factory ExternalUrls.fromJSON(Map<String, dynamic> json) {
    var urls = HashMap<ExternalUrlType, String>();
    
    for (var key in json.keys) {
      final type = EnumUtils.enumFromString<ExternalUrlType>(key);
      if (type == ExternalUrlType.Error) continue;
      final value = json[key] as String;
      if (value == null) continue;
      urls[type] = value; 
    }

    return ExternalUrls(urls);
  }
}