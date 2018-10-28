import 'package:spotify_wrapper/src/models/Types.dart';

class RecommendationsSeed {
  ///The number of tracks available after min_* and 
  ///max_* filters have been applied.
  int afterFilteringSize;

  ///The number of tracks available after relinking 
  ///for regional availability.
  int afterRelinkingSize;

  ///A link to the full track or artist data for this 
  ///seed. For tracks this will be a link to a Track Object. 
  ///For artists a link to an Artist Object. For genre seeds, 
  ///this value will be `null`.
  String href;

  ///The id used to select this seed. This will be the same as 
  ///the string used in the [seed_artists] , [seed_tracks] or 
  ///[seed_genres] parameter.
  String id;

  ///The number of recommended tracks available for this seed.
  int initialPoolSize;

  ///The entity type of this seed. One of `artist`, `track` or `genre`.
  RecommendationSeedType type;
}