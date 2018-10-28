import 'package:spotify_wrapper/src/Abstracts/SpotifyObject.dart';
import 'package:spotify_wrapper/src/models/ExternalUrl.dart';
import 'package:spotify_wrapper/src/models/Followers.dart';
import 'package:spotify_wrapper/src/models/SporifyImage.dart';
import 'package:spotify_wrapper/src/models/Types.dart';

class User /*extends SpotifyObject*/ {
  ///The name displayed on the user’s profile. 
  ///`null` if not available.
  String displayName;

  ///Known public external URLs for this user.
  ExternalUrls externalUrls;

  ///Information about the followers of this user.
  Followers followers;

  ///A link to the Web API endpoint for this user.
  String href;

  ///The Spotify user ID for this user.
  String id;

  ///The user’s profile image.
  List<SpotifyImage> images;

  ///The object type: `user`
  SpotifyType type;

  ///The Spotify URI for this user.
  String uri;
}

class UserPrivate extends User {
  ///The user’s date-of-birth.
  ///
  ///_This field is only available when the current user
  ///has granted access to the [user-read-birthdate] scope_.
  String birthdate;

  ///The country of the user, as set in the user’s account profile. 
  ///_An [ISO 3166-1 alpha-2 country code](http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2). 
  ///This field is only available when the current user 
  ///has granted access to the [user-read-private] scope_.
  String country;  

  ///The user’s email address, as entered by 
  ///the user when creating their account.
  ///
  ///_**Important!** This email address is unverified; there is 
  ///no proof that it actually belongs to the user. This field is 
  ///only available when the current user has granted access to 
  ///the [user-read-email] scope_.
  String email;


  ///The user’s Spotify subscription level: `premium`, `free`, 
  ///etc. (The subscription level `open` can be considered the 
  ///same as `free`.) 
  ///
  ///_This field is only available when the current 
  ///user has granted access to the [user-read-private] scope_.
  String product;
}