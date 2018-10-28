class AccessToken {

  ///Date in which the token was created.
  DateTime createdOn;
  
  ///An access token that can be provided in subsequent calls, 
  ///for example to Spotify Web API services.
  String token;

  ///How the access token may be used: always `Bearer`.
  String tokenType;

  ///A list of scopes which have been granted for this [token].
  List<String> scopes;

  ///The time period (in seconds) for which the access token is valid.
  int expiresIn;

  ///Date in which the token will expire.
  DateTime expiresOn;

  bool get expired => DateTime.now().isAfter(expiresOn);

  ///A token that can be sent to the Spotify Accounts service in place of an 
  ///authorization code. (When the access code expires, send a POST request 
  ///to the Accounts service /api/token endpoint, but use this code in place 
  ///of an authorization code. A new access token will be returned. A new 
  ///refresh token might be returned too.)
  String refreshToken;

  AccessToken(this.token, this.scopes, this.expiresIn, this.refreshToken) {
    tokenType = 'Bearer';
    createdOn = DateTime.now();
    final duration = Duration(seconds: expiresIn);
    expiresOn = createdOn.add(duration);
  }

  factory AccessToken.fromJSON(Map<String, dynamic> json) {
    final scopes = (json['scope'] as String).split(',') ?? [];
    return AccessToken(json['access_token'], scopes, 
                  json['expires_in'], json['refresh_token']);
  }
}