import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:herotome/ComicHero.dart';
import 'package:herotome/ComicHeroDetails.dart';

// const ROUTE_NAME = 'DETAIL_SCREEN';

const String _imageUrlPrefix =
    'https://terrigen-cdn-dev.marvel.com/content/prod/1x/';

final comicHeroDetailObj = Provider((ref) => ComicHeroDetailsMock());
const List<RadarEntry> maxValues = [
  RadarEntry(value: 7),
  RadarEntry(value: 7),
  RadarEntry(value: 7),
  RadarEntry(value: 7),
  RadarEntry(value: 7),
  RadarEntry(value: 7),
];

const Map<String, Color> powerColors = {
  "Durability": Color(0xEE43BA2B),
  "Energy": Color(0xEEB5287B),
  "Fighting Skills": Color(0xEE1795D6),
  "Intelligence": Color(0xEEFCD604),
  "Speed": Color(0xEEE62429),
  "Strength": Color(0xEEFB7600),
};

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
            Text(hero.name),
            Text(hero.realName),
            Consumer(
              builder: (context, watch, child) {
                final details = watch(comicHeroDetailObj);
                return buildChartRows(details.powers, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildChartRows(Map<String, double> powers, BuildContext context) {
  List<Widget> list = [];
  const int maxVal = 7;

  final double fullWidth = MediaQuery.of(context).size.width * 0.9;
  final double textWidthFactor = 0.25;
  final double powerBarWidthFactor = 0.7;

  List<Widget> labelColumnList = [];
  List<Widget> ratingColumnList = [];

  Row buildingRow;
  for (var power in powers.keys) {
    String title = power;
    double rating = powers[power]!;
    double emptyBoxSize = maxVal - rating;
    labelColumnList
        .add(Container(width: fullWidth * textWidthFactor, child: Text(title)));
    ratingColumnList.add(
      buildBarForChart(rating, fullWidth, powerBarWidthFactor, maxVal,
          emptyBoxSize, powerColors[power]!),
      // Text('Rating: $rating, remainder: $emptyBoxSize')
    );
  }

  List<Widget> myRows = [];
  for (int i = 0; i < labelColumnList.length; i++) {
    myRows.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          labelColumnList[i],
          ratingColumnList[i],
        ],
      ),
    ));
  }

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey.withOpacity(0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: myRows,
        ),
      ),
    ),
  );
}

Widget buildBarForChart(
    double rating,
    double fullWidth,
    double powerBarWidthFactor,
    int maxVal,
    double emptyBoxSize,
    Color powerBarColor) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: Colors.grey.withOpacity(0.4),
    ),
    child: Row(
      children: [
        SizedBox(
          height: 10.0,
          width: (rating * fullWidth * powerBarWidthFactor) / maxVal,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: powerBarColor,
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
          width: (emptyBoxSize * fullWidth * powerBarWidthFactor) / maxVal,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    ),
  );
}

