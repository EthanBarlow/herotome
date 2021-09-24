import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herotome/empty_biography_exception.dart';
import 'package:herotome/infrastructure/models/comic_details.dart';
import 'package:herotome/infrastructure/models/hero_bio.dart';
import 'package:herotome/infrastructure/models/movie_details.dart';
import 'package:herotome/infrastructure/models/my_hero.dart';
import 'package:herotome/mocks/hero_mock.dart';

abstract class HeroBiographyRepository {
  Future<HeroBio> fetchHeroBiography(HeroProfile hero);
}

class RealHeroBiographyRepository implements HeroBiographyRepository {
  @override
  Future<HeroBio> fetchHeroBiography(HeroProfile hero) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    var querySnapshot = await firestore
        .collection('characterBio')
        .where('link', isEqualTo: hero.link)
        .get();

    return Future(() {
      // Since we are getting all of the character data from Marvel's website based on the character page's url,
      // It should be safe to assume that there will only be one document with any given link
      if (querySnapshot.docs.isNotEmpty) {
        return HeroBio.fromJson(querySnapshot.docs[0].data());
      }
      throw EmptyBiographyException('no');
    });
  }
}

class FakeHeroBiographyRepository implements HeroBiographyRepository {
  late HeroBio bio;
  late ComicDetails comicDetails;
  late MovieDetails movieDetails;

  @override
  Future<HeroBio> fetchHeroBiography(MyHero hero) {
    return Future.delayed(Duration(seconds: 2), () {
      return Gamora();
    });
  }
}
