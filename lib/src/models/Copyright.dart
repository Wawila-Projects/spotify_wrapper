import 'package:spotify_wrapper/src/StaticClasses/EnumUtils.dart';
import 'package:spotify_wrapper/src/models/Types.dart';

class Copyright {
  ///	The copyright text for this album.
  String text;

  ///The type of copyright: `C` = the copyright, 
  ///`P` = the sound recording (performance) copyright.
  CopyrightType type;

  Copyright(this.text, this.type);

  factory Copyright.fromJSON(Map<String, dynamic> json) {
    return Copyright(json['text'], EnumUtils.enumFromString<CopyrightType>(json['type']));
  }
}