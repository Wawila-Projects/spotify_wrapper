enum SpotifyType {
  Error, None, Track, Album, Artist, AudioFeatures, Playlist, User, PlayHistory
}

enum AlbumType {
  Error, None, Album, Single, Compilation
}

enum ContextType {
  Error, None, Artist, Playlist, Album
}

enum CopyrightType {
  Error, None, C, P
}

enum ExternalIDType {
  Error, None, Isrc, Ean, Upc
}

enum ExternalUrlType {
  Error, None, Spotify
}

enum RecommendationSeedType {
  Error, None, Artist, Track, Genre
}

enum DeviceType {
  Error, None, Computer, Smartphone, Speaker
}

enum RepeateState {
  Error, None, Off, Track, Context
}

enum CurrentlyPlayingType {
  Error, None, Track, Episode, Ad, Unknonwn
}