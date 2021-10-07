import 'package:herotome/constants.dart';

class MyHero {
  final String name;
  final String link;

  MyHero({required this.name, required this.link});
}

class HeroProfile extends MyHero {
  final String imgLink;
  final String context;
  HeroProfile({
    required name,
    required link,
    required this.imgLink,
    required this.context,
  }) : super(name: name, link: link);

  static HeroProfile fromJson(Map<String, dynamic> map) {
    String tempName = '';
    String tempLink = '';
    String tempImgLink = '';
    String tempContext = '';

    map.forEach((key, value) {
      if (key.contains(MyConstants.headlineKey)) {
        tempName = value.toString();
      } else if (key.contains(MyConstants.linkKey)) {
        tempLink = value.toString();
      } else if (key.contains(MyConstants.imageKey)) {
        tempImgLink = value.toString();
      } else if (key.contains(MyConstants.contextKey)) {
        tempContext = value.toString();
      } else {
        // should never get here as long as the data in firebase does not change format / structure
      }
    });

    return HeroProfile(
      name: tempName,
      link: tempLink,
      imgLink: tempImgLink,
      context: tempContext,
    );
  }
}

class FeatureHighlights {
  final String title;
  final String description;
  final String image;

  FeatureHighlights({
    required this.title,
    required this.description,
    required this.image,
  });
}
