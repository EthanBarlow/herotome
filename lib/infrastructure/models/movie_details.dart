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

    print('img link - $tempImgLink');
    print('short bio - $tempShortBio');
    print('powers and abilities - $tempPowerAbilities');
    print('story momemnt - $tempStoryMoments');

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
    if (key.contains('description')) {
      tempDesc = value;
    } else if (key.contains('image')) {
      tempImg = value;
    } else if (key.contains('title')) {
      tempTitle = value;
    }
  });
  return FeatureHighlights(
    title: tempTitle,
    description: tempDesc,
    image: tempImg,
  );
}
