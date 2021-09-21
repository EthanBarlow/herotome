class ComicDetails {
  final String headerImg;
  final Map<String, String> physicalAttributes;
  final Map<String, String> contextualAttributes;
  final Map<String, int> powerRatings;
  final List<String> biography;
  final bool crowdSourced;

  ComicDetails({
    this.headerImg = '',
    this.physicalAttributes = const {},
    this.contextualAttributes = const {},
    this.powerRatings = const {},
    this.biography = const [],
    this.crowdSourced = false,
  });

  static ComicDetails fromJson(Map<String, dynamic> comicMap) {
    String tempHeaderImg = '';
    Map<String, String> tempPhysicalAttributes = {};
    Map<String, String> tempContextualAttributes = {};
    Map<String, int> tempPowerRatings = {};
    List<String> tempBiography = [];
    bool tempCrowdSourced = false;

    comicMap.forEach((key, value) {
      if (key.contains('header_image')) {
        tempHeaderImg = value.toString();
      } else if (key.contains('crowd_sourced')) {
        tempCrowdSourced = value;
      } else if (key.contains('biography')) {
        for (int i = 0; i < value.length; i++) {
          tempBiography.add(value[i].toString());
        }
      } else if (key.contains('contextual_attributes')) {
        List<dynamic> valueList = value as List<dynamic>;
        for (int i = 0; i < valueList.length; i++) {
          Map<String, dynamic> dynamicMap = valueList[i];
          Map<String, String> stringMap =
              dynamicMap.map((key, value) => MapEntry(key, value.toString()));
          tempContextualAttributes.addAll(stringMap);
        }
      } else if (key.contains('physical_attributes')) {
        List<dynamic> valueList = value as List<dynamic>;
        for (int i = 0; i < valueList.length; i++) {
          Map<String, dynamic> dynamicMap = valueList[i];
          Map<String, String> stringMap =
              dynamicMap.map((key, value) => MapEntry(key, value.toString()));
          tempPhysicalAttributes.addAll(stringMap);
        }
      } else if (key.contains('power_grid')) {
        List<dynamic> valueList = value as List<dynamic>;
        for (int i = 0; i < valueList.length; i++) {
          Map<String, dynamic> dynamicMap = valueList[i];
          Map<String, int> intMap =
              dynamicMap.map((key, value) => MapEntry(key, value as int));
          tempPowerRatings.addAll(intMap);
        }
      }
    });

    return ComicDetails(
      biography: tempBiography,
      contextualAttributes: tempContextualAttributes,
      crowdSourced: tempCrowdSourced,
      headerImg: tempHeaderImg,
      physicalAttributes: tempPhysicalAttributes,
      powerRatings: tempPowerRatings,
    );
  }
}
