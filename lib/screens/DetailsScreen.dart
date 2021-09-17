import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herotome/ComicHero.dart';
import 'package:herotome/screens/comic_details_tab.dart';
import 'package:herotome/screens/movie_details_tab.dart';
import '../application/hero_bio_notifier.dart';
import 'package:herotome/providers.dart';

import '../infrastructure/models/my_hero.dart';

// const ROUTE_NAME = 'DETAIL_SCREEN';

const String _imageUrlPrefix =
    'https://terrigen-cdn-dev.marvel.com/content/prod/1x/';

class DetailScreen extends StatelessWidget {
  final ComicHero hero;

  const DetailScreen({Key? key, required this.hero}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(body: Consumer(
        builder: (context, watch, child) {
          final heroBioState = watch(heroBiographyNotifierProvider);
          if (heroBioState is HeroBioInitial) {
            return Center(child: Text('INitial'));
          } else if (heroBioState is HeroBioLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (heroBioState is HeroBioLoaded) {
            MovieDetails movieDetails = heroBioState.biography.movieDetails;
            ComicDetails comicDetails = heroBioState.biography.comicDetails;
            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    expandedHeight: 300,
                    floating: false,
                    pinned: true,
                    snap: false,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Container(
                          child: Text(
                        heroBioState.biography.name,
                      )),
                      background: Container(
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(0.0),
                          child: comicDetails.headerImg.length < 2
                              ? FlutterLogo()
                              // : Image.network(
                              //     _imageUrlPrefix + movieDetails.imgLink,
                              //     fit: BoxFit.cover,
                              //   ),
                              : Image.network(
                                  _imageUrlPrefix + comicDetails.headerImg,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: MySliverPersistantHeaderDelegate(
                      TabBar(
                        // labelColor: Colors.brown,
                        tabs: [
                          Tab(
                            // text: 'Movie',
                            // icon: Icon(Icons.flashlight_on_rounded),
                            child: Row(
                              children: [
                                Icon(Icons.local_movies_rounded),
                                SizedBox(width: 10),
                                Text('Movie'),
                              ],
                            ),
                          ),
                          Tab(
                            // text: 'Comic',
                            child: Row(
                              children: [
                                Icon(Icons.menu_book_rounded),
                                SizedBox(width: 10),
                                Text('Comic'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  MovieDetailsTab(details: movieDetails),
                  ComicDetailsTab(details: comicDetails),
                ],
              ),
            );
          } else {
            return Center(child: Text('Unknown state!!!'));
          }
        },
      )),
    );
  }
}




class MySliverPersistantHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  MySliverPersistantHeaderDelegate(this._tabBar);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Theme.of(context).canvasColor,
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}


