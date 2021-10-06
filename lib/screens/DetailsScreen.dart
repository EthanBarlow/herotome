import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herotome/constants.dart';
import 'package:herotome/infrastructure/models/comic_details.dart';
import 'package:herotome/infrastructure/models/movie_details.dart';
import 'package:herotome/screens/comic_details_tab.dart';
import 'package:herotome/screens/movie_details_tab.dart';
import 'package:herotome/widgets/marvel_placeholder.dart';
import '../application/hero_bio_notifier.dart';
import 'package:herotome/providers.dart';

const String _imageUrlPrefix =
    'https://terrigen-cdn-dev.marvel.com/content/prod/1x/';

const double heightOfAppBar = 300;
const int millisForImgAnim = 600;

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
    return SafeArea(
      child: Scaffold(
        body: Consumer(
          builder: (context, watch, child) {
            final heroBioState = watch(heroBiographyNotifierProvider);
            if (heroBioState is BioInitial) {
              return Center(child: Text('Initial'));
            } else if (heroBioState is BioLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (heroBioState is BioLoaded) {
              MovieDetails movieDetails = heroBioState.biography.movieDetails;
              ComicDetails comicDetails = heroBioState.biography.comicDetails;
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: heightOfAppBar,
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
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: millisForImgAnim),
                            child: getConditionalImage(_tabIndex,
                                movieDetails.imgLink, comicDetails.headerImg),
                            transitionBuilder: (child, animation) {
                              final offsetAnimation = Tween(
                                begin: const Offset(0.0, 1.0),
                                end: const Offset(0.0, 0.0),
                              ).animate(animation);
                              return ClipRRect(
                                child: SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                ),
                              );
                            },
                            switchInCurve: Curves.easeInOutCubic,
                            switchOutCurve: Curves.easeInOutCubic,
                            layoutBuilder: (currentChild, previousChildren) {
                              /* 
                                without this layout builder the images were displaying at their original size instead of following their boxfit
                                https://www.raywenderlich.com/24345609-adding-micro-interactions-with-animatedswitcher shows this fix
                              */
                              return Stack(
                                children: [
                                  ...previousChildren,
                                  if (currentChild != null) currentChild,
                                ],
                                fit: StackFit.expand,
                              );
                            },
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
                                child: Row(
                                  children: [
                                    Icon(Icons.menu_book_rounded),
                                    SizedBox(width: 10),
                                    Text(MyConstants.detailsScreenComicTab),
                                  ],
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.local_movies_rounded),
                                    SizedBox(width: 10),
                                    Text(MyConstants.detailsScreenMovieTab),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    ComicDetailsTab(details: comicDetails),
                    MovieDetailsTab(details: movieDetails),
                  ],
                ),
              );
            } else if (heroBioState is BioError) {
              return Center(child: Text(heroBioState.message));
            } else {
              return Center(child: Text('Unknown state!!!'));
            }
          },
        ),
      ),
    );
  }
}

Widget getConditionalImage(
    int index, String movieImgLink, String comicImgLink) {
  if (index == 0) {
    if (comicImgLink.isNotEmpty && comicImgLink.length > 0) {
      return CachedNetworkImage(
        key: ValueKey(comicImgLink),
        imageUrl: _imageUrlPrefix + comicImgLink,
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
        fit: BoxFit.cover,
      );
    }
  } else if (index == 1) {
    if (movieImgLink.isNotEmpty) {
      return CachedNetworkImage(
        key: ValueKey(movieImgLink),
        imageUrl: _imageUrlPrefix + movieImgLink,
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
        fit: BoxFit.cover,
      );
    }
  }
  return Container(
    key: UniqueKey(),
    child: MarvelPlaceholder()
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
