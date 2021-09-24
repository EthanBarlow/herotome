import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herotome/infrastructure/models/my_hero.dart';

abstract class ProfileRepository {
  Future<List<HeroProfile>> fetchHeroProfileList();
}

class RealProfileRepository implements ProfileRepository {
  @override
  Future<List<HeroProfile>> fetchHeroProfileList() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    var querySnapshot = await firestore
        .collection('characterProfile')
        .limit(100)
        .get();

    List<HeroProfile> profiles = [];
    querySnapshot.docs
        .forEach((doc) => profiles.add(HeroProfile.fromJson(doc.data())));

    return Future(() {
      // Since we are getting all of the character data from Marvel's website based on the character page's url,
      // It should be safe to assume that there will only be one document with any given link
      return profiles;
    });
  }
}

class FakeProfileRepository implements ProfileRepository {
  @override
  Future<List<HeroProfile>> fetchHeroProfileList() {
    return Future(() {
      return heroGridList;
    });
  }
}

final heroGridList = [
  // HeroProfile(
  //   name: 'Spider Man',
  //   imgLink: '005smp_ons_crd_02.jpg',
  //   link: '/characters/spider-man-peter-parker',
  //   context: 'live_action',
  // ),
  // HeroProfile(
  //   name: 'Iron Man',
  //   imgLink: '002irm_ons_crd_03.jpg',
  //   link: 'characters/iron-man-tony-stark',
  //   context: 'live_action',
  // ),
  // HeroProfile(
  //   name: '8-ball',
  //   imgLink: '8-ball.jpg',
  //   link: 'characters/8-ball-jeff-hagees',
  //   context: 'live_action',
  // ),
  // HeroProfile(
  //   name: 'Aunt May',
  //   imgLink: 'auntmayandweirdlookingpete.jpg',
  //   link: 'characters/aunt-may-may-parker',
  //   context: 'comic',
  // ),
  HeroProfile(
    name: 'Gamora',
    imgLink: '022gam_com_mas_mob_03.jpg',
    link: 'characters/gamora',
    context: 'live_action',
  ),
];
