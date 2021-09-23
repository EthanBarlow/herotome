import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herotome/infrastructure/models/comic_details.dart';
import 'package:herotome/infrastructure/models/hero_bio.dart';
import 'package:herotome/infrastructure/models/movie_details.dart';
import 'package:herotome/infrastructure/models/my_hero.dart';
import 'package:herotome/mocks/hero_mock.dart';

abstract class HeroBiographyRepository {
  Future<HeroBio> fetchHeroBiography(MyHero hero);
}

class RealHeroBiographyRepository implements HeroBiographyRepository {
  @override
  Future<HeroBio> fetchHeroBiography(MyHero hero) async {
    // TODO: implement fetchHeroBiography
    /*
      1. Set up Firebase query based on the character's page/link - check
      2. Ingest and JSONify the response - check
      3. Parse as appropriate - check-ish
        - This may take awhile depending on the bios and the depth
      4. Instantiate HeroBio object - check
    */

    List<String> data = [];

    // 1. Firebase query based on the character's page/link
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    var querySnapshot = await firestore
        .collection('characterBio')
        .where('link', isEqualTo: hero.link)
        .get();

    return Future(() {
      // Since we are getting all of the character data from Marvel's website based on the character page's url,
      // It should be safe to assume that there will only be one document with any given link
      return HeroBio.fromJson(querySnapshot.docs[0].data());
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
