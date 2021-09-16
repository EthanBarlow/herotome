import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:herotome/ComicHero.dart';
import 'package:herotome/ComicHeroDetails.dart';
import 'application/hero_bio_notifier.dart';
import 'package:herotome/providers.dart';

import 'bar_chart.dart';
import 'infrastructure/models/my_hero.dart';

// const ROUTE_NAME = 'DETAIL_SCREEN';

const String _imageUrlPrefix =
    'https://terrigen-cdn-dev.marvel.com/content/prod/1x/';

final comicHeroDetailObj = Provider((ref) => ComicHeroDetailsMock());

class DetailScreen extends StatelessWidget {
  late final ComicHero hero;
  DetailScreen({required ComicHero hero}) {
    this.hero = hero;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: SingleChildScrollView(
        child: Consumer(builder: (context, watch, child) {
          final heroBioState = watch(heroBiographyNotifierProvider);
          if (heroBioState is HeroBioInitial) {
            return Center(child: Text('INitial'));
          } else if (heroBioState is HeroBioLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (heroBioState is HeroBioLoaded) {
            MovieDetails details = heroBioState.biography.movieDetails;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hero.profileImgUrl.length < 2
                    ? FlutterLogo()
                    : Image.network(_imageUrlPrefix + details.imgLink),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 12.0,
                        top: 12.0,
                      ),
                      child: Text(
                        heroBioState.biography.name,
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        details.shortBio,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          'Story Moments',
                          style: TextStyle(fontSize: 22.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: FeatureSlider(
                        highlightList: details.storyMoments,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          'Powers & Abilities',
                          style: TextStyle(fontSize: 22.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: FeatureSlider(
                        highlightList: details.powersAbilities,
                      ),
                    ),
                    Container(height: 40),
                  ],
                ),
              ],
            );
          } else {
            return Center(child: Text('Unknown state!!!'));
          }
        }),
      ),
    );
  }
}

class FeatureSlider extends StatelessWidget {
  const FeatureSlider({
    Key? key,
    required this.highlightList,
  }) : super(key: key);

  final List<FeatureHighlights> highlightList;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 0.9,
        aspectRatio: 5 / 4,
      ),
      items: highlightList.map((ability) {
        return CarouselCard(feature: ability);
      }).toList(),
    );
  }
}

class CarouselCard extends StatelessWidget {
  final FeatureHighlights feature;
  static const _radius = 10.0;
  // BorderRadius.circular(_radius); <-- My preference to make the border radius, but that expression does not work with const
  static const BorderRadius cornerRadius =
      const BorderRadius.all(const Radius.circular(_radius));
  const CarouselCard({
    Key? key,
    required this.feature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: cornerRadius),
      borderOnForeground: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Container(
              width: double.infinity,
              child: ClipRRect(
                child: Image.network(_imageUrlPrefix + feature.image),
                borderRadius: cornerRadius,
              ),
            ),
          ),
          //
          Container(
            // height: 100,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feature.title,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    feature.description,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
