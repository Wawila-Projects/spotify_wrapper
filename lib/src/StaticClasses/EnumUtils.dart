//
//import 'dart:mirrors';

import 'package:spotify_wrapper/src/models/Types.dart';

///Util class to get Enum from String and int.
///
///Base on this [Stack Overflow post](https://stackoverflow.com/questions/27673781/enum-from-string)
class EnumUtils {
  /// Get enum of type [T] from [query]. Return [T.Error] if [query] does not exist; 
  static T enumFromString<T>(String query) {
    dynamic value;
    switch(T) {
      case SpotifyType:
        value = _searchForValue<SpotifyType>(SpotifyType.values, query);
        break;
      case AlbumType:
        value = _searchForValue<AlbumType>(AlbumType.values, query);
        break;
      case ContextType:
        value = _searchForValue<ContextType>(ContextType.values, query);
        break;
      case CopyrightType:
        value = _searchForValue<CopyrightType>(CopyrightType.values, query);
        break;
      case DeviceType:
        value = _searchForValue<DeviceType>(DeviceType.values, query);
        break;
      case ExternalIDType:
        value = _searchForValue<ExternalIDType>(ExternalIDType.values, query);
        break;
      case ExternalUrlType:
        value = _searchForValue<ExternalUrlType>(ExternalUrlType.values, query);
        break;
      case CurrentlyPlayingType:
        value = _searchForValue<CurrentlyPlayingType>(CurrentlyPlayingType.values, query);
        break;
      default:
      throw('Incompatible type ${T.runtimeType}'); 
    }

    if (value == null) {
      throw('Value no found for this type');
    }

    return value;
  }

  static T _searchForValue<T>(List<T> list, String value) {
    return list.firstWhere((e)=>e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
  }



  // /// __Dart Only__: Only compatible with dart:mirrors.  
  // static T enumFromString<T>(String value) {
  //   final values = ((reflectType(T) as ClassMirror).getField(#values).reflectee as List);
  //   try {
  //     final result = values.firstWhere((e)=>e.toString().split('.')[1].toUpperCase() == value.toUpperCase());
  //     return result;
  //   } catch (Exception) {
  //     final result = values.firstWhere((e)=>e.toString().split('.')[1].toUpperCase() == 'ERROR');
  //     return result;
  //   }
  // }
}