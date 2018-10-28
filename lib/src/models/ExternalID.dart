import 'dart:collection';
import 'package:spotify_wrapper/src/StaticClasses/EnumUtils.dart';
import 'package:spotify_wrapper/src/models/Types.dart';

class ExternalIDs {
  ///__Key__: The identifier type, for example:
  ///* `isrc` - [International Standard Recording Code](https://en.wikipedia.org/wiki/International_Standard_Recording_Code)
  ///* `ean` - [International Article Number](https://en.wikipedia.org/wiki/International_Article_Number)
  ///* `upc` - [Universal Product Code](https://en.wikipedia.org/wiki/Universal_Product_Code)
  ///
  ///__Value__: An external identifier for the object.
  HashMap<ExternalIDType, String> externalIDs;
  
  ExternalIDs(this.externalIDs);
  factory ExternalIDs.fromJSON(Map<String, dynamic> json){
     var ids = HashMap<ExternalIDType, String>();
    
    for (var key in json.keys) {
      final type = EnumUtils.enumFromString<ExternalIDType>(key);
      if (type == ExternalIDType.Error) continue;
      final value = json[key] as String;
      if (value == null) continue;
      ids[type] = value; 
    }

    return ExternalIDs(ids);
  }
}