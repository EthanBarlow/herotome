class ComicHero {
  final String name;
  final String realName;
  String microDescription = '';
  final String description;
  final String link;
  final String context;
  final String profileImgUrl;

  ComicHero(
      {required this.name, required this.realName, required this.description, required this.profileImgUrl, required this.link, this.microDescription = '', this.context = ''});
  // late String _name;
}