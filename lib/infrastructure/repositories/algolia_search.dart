
import 'package:algolia/algolia.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:herotome/infrastructure/models/my_hero.dart';

class AlgoliaSearch {
   static final Algolia algolia = Algolia.init(
    applicationId: dotenv.env['ALGOLIA_APPID']!,
    apiKey: dotenv.env['ALGOLIA_SEARCH_API_KEY']!,
  );

  Future<List<HeroProfile>> fetchSearchResults(String searchQuery) async {
    print('in fetch method');

    List<HeroProfile> results = [];

    AlgoliaQuery algoliaQuery =
        algolia.instance.index('profiles').query(searchQuery);
    AlgoliaQuerySnapshot snap = await algoliaQuery.getObjects();
    print('Hits count: ${snap.nbHits}');
    snap.hits.forEach((element) {
      results.add(HeroProfile.fromJson(element.data));
      // print(element);
    });

    return Future(() {
      return results;
    });
  }
}

