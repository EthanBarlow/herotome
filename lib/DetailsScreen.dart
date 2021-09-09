import 'package:flutter/material.dart';
import 'package:herotome/ComicHero.dart';

// const ROUTE_NAME = 'DETAIL_SCREEN';

const String _imageUrlPrefix =
    'https://terrigen-cdn-dev.marvel.com/content/prod/1x/';

class DetailScreen extends StatelessWidget {
  late final ComicHero hero;
  DetailScreen({required ComicHero hero}){
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
            Image.network(_imageUrlPrefix + hero.profileImgUrl),
            Text(hero.name),
            Text(hero.realName),
          ],
        ),
      ),
    );
  }
}
