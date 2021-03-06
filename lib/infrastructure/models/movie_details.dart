import 'package:herotome/constants.dart';
import 'package:herotome/infrastructure/models/my_hero.dart';

class MovieDetails {
  final String imgLink;
  final String shortBio;
  final List<FeatureHighlights> storyMoments;
  final List<FeatureHighlights> powersAbilities;

  MovieDetails({
    this.imgLink = '',
    this.shortBio = '',
    this.storyMoments = const [],
    this.powersAbilities = const [],
  });

  static MovieDetails fromJson(Map<String, dynamic> map) {
    String tempImgLink = '';
    String tempShortBio = '';
    List<FeatureHighlights> tempStoryMoments = [];
    List<FeatureHighlights> tempPowerAbilities = [];

    map.forEach((key, value) {
      if (key.contains('header_image')) {
        tempImgLink = value.toString();
      } else if (key.contains('short_bio')) {
        tempShortBio = value.toString();
      } else if (key.contains('powers_abilities')) {
        var list = value as List<dynamic>;
        list.forEach((miniMap) {
          tempPowerAbilities.add(mapTrioParser(miniMap));
        });
      } else if (key.contains('story_moments')) {
        var list = value as List<dynamic>;
        list.forEach((miniMap) {
          tempStoryMoments.add(mapTrioParser(miniMap));
        });
      }
    });

    return MovieDetails(
      imgLink: tempImgLink,
      shortBio: tempShortBio,
      storyMoments: tempStoryMoments,
      powersAbilities: tempPowerAbilities,
    );
  }
}

FeatureHighlights mapTrioParser(Map<String, dynamic> map) {
  String tempDesc = '', tempImg = '', tempTitle = '';
  map.forEach((key, value) {
    if (key.contains(MyConstants.descriptionKey)) {
      tempDesc = value;
    } else if (key.contains(MyConstants.imageKey)) {
      tempImg = value;
    } else if (key.contains(MyConstants.titleKey)) {
      tempTitle = value;
    }
  });
  return FeatureHighlights(
    title: tempTitle,
    description: tempDesc,
    image: tempImg,
  );
}
