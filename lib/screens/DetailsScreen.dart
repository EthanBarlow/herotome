import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herotome/infrastructure/models/comic_details.dart';
import 'package:herotome/infrastructure/models/movie_details.dart';
import 'package:herotome/screens/comic_details_tab.dart';
import 'package:herotome/screens/movie_details_tab.dart';
import '../application/hero_bio_notifier.dart';
import 'package:herotome/providers.dart';

const String _imageUrlPrefix =
    'https://terrigen-cdn-dev.marvel.com/content/prod/1x/';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _tabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
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
                          child: getConditionalImage(_tabIndex,
                              movieDetails.imgLink, comicDetails.headerImg),
                        ),
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: MySliverPersistantHeaderDelegate(
                      TabBar(
                        controller: _tabController,
                        tabs: [
                          Tab(
                            child: Container(
                              foregroundDecoration: BoxDecoration(
                                  color: heroBioState.biography.hasMovie()
                                      ? Colors.transparent
                                      : Color(0x44444444)),
                              child: Row(
                                children: [
                                  Icon(Icons.local_movies_rounded),
                                  SizedBox(width: 10),
                                  Text('Movie'),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              foregroundDecoration: BoxDecoration(
                                  color: heroBioState.biography.hasComic()
                                      ? Colors.transparent
                                      : Color(0x44444444)),
                              child: Row(
                                children: [
                                  Icon(Icons.menu_book_rounded),
                                  SizedBox(width: 10),
                                  Text('Comic'),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
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
      ),
    );
  }
}

Widget getConditionalImage(
    int index, String movieImgLink, String comicImgLink) {
  if (index == 0) {
    if (movieImgLink.isNotEmpty) {
      return CachedNetworkImage(
        key: ValueKey(movieImgLink),
        imageUrl: _imageUrlPrefix + movieImgLink,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      );
    }
  } else if (index == 1) {
    if (comicImgLink.isNotEmpty) {
      return CachedNetworkImage(
        key: ValueKey(comicImgLink),
        imageUrl: _imageUrlPrefix + comicImgLink,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      );
    }
  }
  return Center(
    key: UniqueKey(),
    child: FlutterLogo(
      size: 40,
    ),
  );
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
