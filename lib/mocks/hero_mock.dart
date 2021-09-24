import 'package:herotome/infrastructure/models/comic_details.dart';
import 'package:herotome/infrastructure/models/hero_bio.dart';
import 'package:herotome/infrastructure/models/movie_details.dart';
import 'package:herotome/infrastructure/models/my_hero.dart';

final ComicDetails comicDetails = new ComicDetails(
  headerImg: '022gam_com_mas_mob_03.jpg',
  physicalAttributes: {
    'height': "6'",
    'weight': '170 lbs.',
    'gender': 'Female',
    'eyes': 'Yellow (formerly green)',
    'hair': 'Black'
  },
  contextualAttributes: {
    'universe': "Marvel Universe",
    'Other aliases':
        'Bambi Long, Astral Samuri, The Most Dangerous Woman in the Universe, The Most Dangerous Woman in the Galaxy',
    'education':
        'Private instruction by Thanos and study of multiple combat techniques',
    'place of origin':
        'The planet Zen-Whoberi , Silican system, Milky Way Galaxy',
    'identity': 'No dual identity',
    'powers':
        'Precognition, Superhuman Durability, Superhuman Speed, Superhuman Strength, Sword-Fighting, Hand-to-Hand Combat',
    'group affiliation': 'guardians of the galaxy',
  },
  powerRatings: {
    'durability': 3,
    'energy': 1,
    'fighting_skills': 6,
    'intelligence': 3,
    'speed': 4,
    'strength': 3,
  },
  biography: [
    'As the last surviving member of the Zen-Whoberi, Gamora was adopted, raised and enhanced by the Mad Titan Thanos to be the deadliest warrior in the galaxy. Turning against her father, Gamora now uses her elite abilities to fight on the side of good.'
  ],
  crowdSourced: false,
);

final MovieDetails movieDetails = new MovieDetails(
  imgLink: '022gam_ons_mas_mob_02_0.jpg',
  shortBio:
      "'Gamora is a trained warrior assassin, whose life under her adoptive father Thanos’ torturous wrath leads her to turn against him. Realizing the universe is threatened by powerful Infinity Stones, she takes up the mantle of Guardian of the Galaxy.'",
  storyMoments: [
    FeatureHighlights(
      title: 'Power Stone',
      description:
          'Alongside her new teammates, Gamora made a stand against Ronan, harnessing the Power Stone against him.',
      image: '022gam_ons_mnt_02_0.jpg',
    ),
    FeatureHighlights(
      title: 'Gamora Saves Nebula',
      description:
          'When Nebula came after Gamora on Ego’s planet, Gamora ended up saving her, leading to reconciliation between the sisters.',
      image: '022gam_ons_mnt_03_0.jpg',
    ),
    FeatureHighlights(
      title: 'Thanos Tricks Gamora',
      description:
          'Gamora believed she had fatally wounded Thanos on Knowhere, only for him to reveal it was all a ruse.',
      image: '022gam_ons_mnt_04_0.jpg',
    ),
    FeatureHighlights(
      title: 'Soul Stone',
      description:
          'On Vormir, Gamora and Thanos learned the price to pay to gain the Soul Stone, as Gamora discovered what Thanos truly felt about her. ',
      image: '022gam_ons_mnt_05_1.jpg',
    ),
  ],
  powersAbilities: [
    FeatureHighlights(
      title: 'Space Survival',
      description:
          'Thanks to the bionic upgrades given to her by Thanos, Gamora is able to survive in the vacuum of space for a short amount of time.',
      image: '022gam_ons_pwr_02_0.jpg',
    ),
    FeatureHighlights(
      title: 'Deadly Assassin',
      description:
          'Given the moniker “the deadliest woman in the galaxy,” Gamora is a feared and skilled assassin.',
      image: '022gam_ons_pwr_03_0.jpg',
    ),
    FeatureHighlights(
      title: 'Skilled Swordswoman',
      description:
          'Gamora is a skilled swordswoman, expertly wielding her blade in combat.',
      image: '022gam_ons_pwr_04_0.jpg',
    ),
  ],
);

class Gamora extends HeroBio {
  Gamora()
      : super(
          name: 'Gamora',
          link: '/characters/gamora',
          miniBio:
              'Gamora is a trained warrior assassin, whose life under her adoptive father Thanos’ torturous wrath leads her to turn against him. Realizing the universe is threatened by powerful Infinity Stones, she takes up the mantle of Guardian of the Galaxy.',
          comicDetails: comicDetails,
          movieDetails: movieDetails,
        );
}

class GamoraProfile extends HeroProfile {
  GamoraProfile()
      : super(
          name: 'Gamora',
          imgLink: '022gam_com_mas_mob_03.jpg',
          link: 'characters/gamora',
          context: 'live_action',
        );
}
