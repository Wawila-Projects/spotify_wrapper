
///For more detailed information refer to the
///[official documentation].(https://developer.spotify.com/documentation/general/guides/scopes/)
class AuthScopes {
  // Spotify Connect
  static String get userReadPlaybackState => 'user-read-playback-state';
  static String get userReadCurrentlyPlaying => 'user-read-currently-playing';
  static String get userModifyPlaybackState => 'user-modify-playback-state';

  // Playback
  static String get streaming => 'streaming';
  static String get appRemoteControl => 'app-remote-control';
  
  // Playlist
  static String get playlistReadCollaborative => 'playlist-read-collaborative';
  static String get playlistModifyPrivate => 'playlist-modify-private';
  static String get playlistModifyPublic => 'playlist-modify-public';
  static String get playlistReadPrivate => 'playlistReadPrivate';

  // Users
  static String get userReadBirthdate => 'user-read-birthdate';
  static String get userReadEmail => 'user-read-email';
  static String get userReadPrivate => 'user-read-private';

  // Follow 
  static String get userFollowModify => 'user-follow-modify';
  static String get userFollowRead => 'user-follow-read';

  // Library
  static String get userLibraryRead => 'user-library-read';
  static String get userLibraryModify => 'user-library-modify';

  // Listening History
  static String get userReadRecentlyPlayed => 'user-read-recently-played';
  static String get userTopRead => 'user-top-read';
}