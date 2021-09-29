import 'package:flutter/cupertino.dart';

// Found this solution to constants in the following stack overflow answers: https://stackoverflow.com/questions/54069239/whats-the-best-practice-to-keep-all-the-constants-in-flutter
class MyConstants extends InheritedWidget {
  static MyConstants of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyConstants>()!;

  const MyConstants({
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  static const String heroBioErrorMessage =
      'Couldn\'t get a hold of this hero\'s secretary. Leave a message...';
  static const String heroProfileErrorMessage =
      'The directory is not working at the moment';

  static const String headerImageKey = 'header_image';
  static const String crowdSourcedKey = 'crowd_sourced';
  static const String biographyKey = 'biography';
  static const String contextualAttributesKey = 'contextual_attributes';
  static const String physicalAttributesKey = 'physical_attributes';
  static const String powerGridKey = 'power_grid';

  static const String headlineKey = 'headline';
  static const String linkKey = 'link';
  static const String miniBioKey = 'miniBio';
  static const String comicKey = 'comic';
  static const String liveActionKey = 'live_action';

  static const String descriptionKey = 'description';
  static const String imageKey = 'image';
  static const String titleKey = 'title';
  static const String contextKey = 'context';

  static const String comicDetailsTabPhysicalAttr = 'Physical Attributes';
  static const String comicDetailsTabContextAttr = 'Other Attributes';

  static const String detailsScreenMovieTab = 'Movie';
  static const String detailsScreenComicTab = 'Comic';

  static const String movieDetailsNoMovieYet =
      'This character is still fighting for their place in the MCU';
  static const String movieDetailsStoryMoments = 'Story Moments';
  static const String movieDetailsPowersAbilities = 'Powers & Abilities';

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
