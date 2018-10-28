import 'package:spotify_wrapper/src/models/RecommendationsSeed.dart';
import 'package:spotify_wrapper/src/models/Track.dart';

class Recommendations {
  //An array of recommendation seed objects.
  List<RecommendationsSeed> seeds;

  //An array of track object ordered according to the parameters supplied.
  List<Track> tracks;
}