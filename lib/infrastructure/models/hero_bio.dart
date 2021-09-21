import 'package:herotome/infrastructure/models/comic_details.dart';
import 'package:herotome/infrastructure/models/movie_details.dart';
import 'package:herotome/infrastructure/models/my_hero.dart';

class HeroBio extends MyHero {
  final String miniBio;
  final ComicDetails comicDetails;
  final MovieDetails movieDetails;

  HeroBio({
    required name,
    required link,
    required this.miniBio,
    required this.comicDetails,
    required this.movieDetails,
  }) : super(name: name, link: link);

  static HeroBio fromJson(Map<String, dynamic> map) {
    String tempName = '';
    String tempLink = '';
    String tempMiniBio = '';
    ComicDetails comicDetails = new ComicDetails();
    MovieDetails movieDetails = new MovieDetails();


    map.forEach((key, value) {
      if (key.contains('headline')) {
        tempName = value.toString();
      } else if (key.contains('link')) {
        tempLink = value.toString();
      } else if (key.contains('miniBio')) {
        tempMiniBio = value.toString();
      } else if (key.contains('comic')) {
        comicDetails = ComicDetails.fromJson(value as Map<String, dynamic>);
      } else if (key.contains('live_action')) {
        movieDetails = MovieDetails.fromJson(value as Map<String, dynamic>);
      } else {
        // should never get here as long as the data in firebase does not change format / structure
      }
    });

    return HeroBio(
      name: tempName,
      link: tempLink,
      miniBio: tempMiniBio,
      comicDetails: comicDetails,
      movieDetails: movieDetails,
    );
  }
}
