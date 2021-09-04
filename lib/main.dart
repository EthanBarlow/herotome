import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _heroProfiles = [
    ComicHero(
      name: 'Spider Man',
      realName: 'Peter Parker',
      profileImgUrl: '005smp_ons_crd_02.jpg',
    ),
    ComicHero(
      name: 'Iron Man',
      realName: 'Tony Stark',
      profileImgUrl: '002irm_ons_crd_03.jpg',
    ),
    ComicHero(
      name: 'Spider Man2',
      realName: 'Peter Parker',
      profileImgUrl: '005smp_ons_crd_02.jpg',
    ),
    ComicHero(
      name: 'Iron Man2',
      realName: 'Tony Stark',
      profileImgUrl: '002irm_ons_crd_03.jpg',
    ),
    ComicHero(
      name: 'Spider Man3',
      realName: 'Peter Parker',
      profileImgUrl: '005smp_ons_crd_02.jpg',
    ),
    ComicHero(
      name: 'Iron Man3',
      realName: 'Tony Stark',
      profileImgUrl: '002irm_ons_crd_03.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 4 / 7,
          padding: const EdgeInsets.all(5),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: _heroProfiles
              .map((item) => ComicHeroProfileCard(myHero: item))
              .toList(),
        ),
      ),
    );
  }
}

const String _imageUrlPrefix =
    'https://terrigen-cdn-dev.marvel.com/content/prod/1x/';

class ComicHero {
  final String name;
  final String realName;
  String profileImgUrl = '';

  ComicHero(
      {required this.name, required this.realName, this.profileImgUrl = ''});
  // late String _name;
}

class ComicHeroProfileCard extends Container {
  final ComicHero myHero;
  final BorderRadius _cornerRadius = BorderRadius.circular(10.0);

  ComicHeroProfileCard({required this.myHero});

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.pinkAccent,
      shape: RoundedRectangleBorder(borderRadius: _cornerRadius),
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AspectRatio(
            aspectRatio: 7 / 10,
            child: ClipRRect(
              borderRadius: _cornerRadius,
              child: Image.network(
                _imageUrlPrefix + myHero.profileImgUrl,
                // height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  myHero.name,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 6),
                Text(
                  myHero.realName,
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
