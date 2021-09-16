class MyHero {
  final String name;
  final String link;

  MyHero({required this.name, required this.link});
}

class HeroProfile extends MyHero {
  final String imgLink;
  final String context;
  HeroProfile(
      {required name,
      required link,
      required this.imgLink,
      required this.context})
      : super(name: name, link: link);
}

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
}

class ComicDetails {
  final String headerImg;
  final Map<String, String> physicalAttributes;
  final Map<String, String> contextualAttributes;
  final Map<String, int> powerRatings;
  final List<String> biography;
  final bool crowdSourced;

  ComicDetails({
    required this.headerImg,
    required this.physicalAttributes,
    required this.contextualAttributes,
    required this.powerRatings,
    required this.biography,
    required this.crowdSourced,
  });
}

class MovieDetails {
  final String imgLink;
  final String shortBio;
  final List<FeatureHighlights> storyMoments;
  final List<FeatureHighlights> powersAbilities;

  MovieDetails({
    required this.imgLink,
    required this.shortBio,
    required this.storyMoments,
    required this.powersAbilities,
  });
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
