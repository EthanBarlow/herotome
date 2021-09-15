import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:herotome/ComicHero.dart';
import 'package:herotome/ComicHeroDetails.dart';

import 'bar_chart.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hero.profileImgUrl.length < 2
                ? FlutterLogo()
                : Image.network(_imageUrlPrefix + hero.profileImgUrl),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    hero.name,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    hero.description,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  // Divider(),
                  // Text(hero.realName),
                  SizedBox(height: 20),
                  Consumer(
                    builder: (context, watch, child) {
                      final details = watch(comicHeroDetailObj);
                      return buildChartRows(details.powers, context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

