import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herotome/infrastructure/models/my_hero.dart';
import 'package:herotome/mocks/hero_mock.dart';

abstract class ProfileRepository {
  Future<List<HeroProfile>> fetchHeroProfileList();
}

class RealProfileRepository implements ProfileRepository {
  QueryDocumentSnapshot? _lastInCurrentList;
  late QuerySnapshot _currentQuerySnapshot;
  List<HeroProfile> profiles = [];
  @override
  Future<List<HeroProfile>> fetchHeroProfileList() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    // var querySnapshot;
    if (_lastInCurrentList == null) {
      _currentQuerySnapshot =
          await firestore.collection('characterProfile').limit(100).get();
      _lastInCurrentList = _currentQuerySnapshot.docs
          .elementAt(_currentQuerySnapshot.docs.length - 1);
    } else {
      _currentQuerySnapshot = await firestore
          .collection('characterProfile')
          .limit(100)
          .startAfterDocument(_lastInCurrentList!)
          .get();
      _lastInCurrentList = _currentQuerySnapshot.docs
          .elementAt(_currentQuerySnapshot.docs.length - 1);
    }
    // querySnapshot.docs.elementAt(querySnapshot.docs.length-1)
    // List<HeroProfile> profiles = [];
    _currentQuerySnapshot.docs
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

final heroGridList = [GamoraProfile()];
