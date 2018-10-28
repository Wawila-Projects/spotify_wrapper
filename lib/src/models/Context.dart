import 'package:spotify_wrapper/src/StaticClasses/EnumUtils.dart';
import 'package:spotify_wrapper/src/models/ExternalUrl.dart';
import 'package:spotify_wrapper/src/models/Types.dart';

class Context { 
  ///The object type, e.g. `artist`, `playlist`, `album`.
  ContextType type;

  ///	A link to the Web API endpoint providing full details of the track.
  String href;

  ///External URLs for this context.
  ExternalUrls externalUrls;

  ///The Spotify URI for the context.
  String uri;

  Context(this.type, this.href, this.externalUrls, this.uri);

  factory Context.fromJSON(Map<String, dynamic> json) {
    final type = EnumUtils.enumFromString<ContextType>(json['type']);
    final urls = ExternalUrls.fromJSON(json['external_urls']);
    return Context(type, json['href'], urls, json['uri']);
  }
}