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
