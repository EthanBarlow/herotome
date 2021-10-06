import 'package:flutter/material.dart';
import 'package:herotome/infrastructure/models/my_hero.dart';
import 'package:herotome/infrastructure/repositories/algolia_search.dart';
import 'package:herotome/widgets/my_list_tile.dart';

class CustomSearchDelegate extends SearchDelegate {
  final AlgoliaSearch _algoliaSearch = new AlgoliaSearch();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Text(
            'Search term must be longer than two letters.',
          ))
        ],
      );
    }
    Future<List<HeroProfile>> results =
        _algoliaSearch.fetchSearchResults(query);
    return FutureBuilder(
        future: results,
        builder: (context, AsyncSnapshot<List<HeroProfile>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('Error or no heroes...'),
            );
          } else {
            return ListView(
              children: snapshot.data!
                  .map((e) =>
                      MyListTile(result: e, close: () => close(context, null)))
                  .toList(),
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
