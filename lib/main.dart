import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:herotome/ComicHero.dart';
import 'package:herotome/DetailsScreen.dart';

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
      description: 'Bitten by a radioactive spider, Peter Parker’s arachnid abilities give him amazing powers he uses to help others, while his personal life continues to offer plenty of obstacles.',
      link: '/characters/spider-man-peter-parker',
      context: 'live_action',
    ),
    ComicHero(
      name: 'Iron Man',
      realName: 'Tony Stark',
      profileImgUrl: '002irm_ons_crd_03.jpg',
      description: 'Genius. Billionaire. Philanthropist. Tony Stark\'s confidence is only matched by his high-flying abilities as the hero called Iron Man.',
      link: 'characters/iron-man-tony-stark',
      context: 'live_action',
    ),
    ComicHero(
      name: 'Spider Man',
      realName: 'Peter Parker',
      profileImgUrl: '005smp_ons_crd_02.jpg',
      description: 'Bitten by a radioactive spider, Peter Parker’s arachnid abilities give him amazing powers he uses to help others, while his personal life continues to offer plenty of obstacles.',
      link: '/characters/spider-man-peter-parker',
      context: 'live_action',
    ),
    ComicHero(
      name: 'Iron Man',
      realName: 'Tony Stark',
      profileImgUrl: '002irm_ons_crd_03.jpg',
      description: 'Genius. Billionaire. Philanthropist. Tony Stark\'s confidence is only matched by his high-flying abilities as the hero called Iron Man.',
      link: 'characters/iron-man-tony-stark',
      context: 'live_action',
    ),
    ComicHero(
      name: 'Spider Man',
      realName: 'Peter Parker',
      profileImgUrl: '005smp_ons_crd_02.jpg',
      description: 'Bitten by a radioactive spider, Peter Parker’s arachnid abilities give him amazing powers he uses to help others, while his personal life continues to offer plenty of obstacles.',
      link: '/characters/spider-man-peter-parker',
      context: 'live_action',
    ),
    ComicHero(
      name: 'Iron Man',
      realName: 'Tony Stark',
      profileImgUrl: '002irm_ons_crd_03.jpg',
      description: 'Genius. Billionaire. Philanthropist. Tony Stark\'s confidence is only matched by his high-flying abilities as the hero called Iron Man.',
      link: 'characters/iron-man-tony-stark',
      context: 'live_action',
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



class ComicHeroProfileCard extends StatefulWidget {
  final ComicHero myHero;

  ComicHeroProfileCard({required this.myHero});

  @override
  _ComicHeroProfileCardState createState() => _ComicHeroProfileCardState();
}

class _ComicHeroProfileCardState extends State<ComicHeroProfileCard> {
  final BorderRadius _cornerRadius = BorderRadius.circular(10.0);
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   setState(() {
      //     _pressed = true;
      //   });
      //   print('onTap - InkWell');
      // },
      onTapDown: (TapDownDetails details) {
        setState(() {
          _pressed = true;
        });
        print('onTapDown - InkWell');
      },
      onTapUp: (TapUpDetails details) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return DetailScreen(hero: widget.myHero);
          }),
        );
        Future.delayed(Duration(milliseconds: 300), () {
          setState(() {
            _pressed = false;
          });
        });
        print('onTapUp - InkWell');
      },
      child: AnimatedOpacity(
        opacity: _pressed ? 0.5 : 1.0,
        // opacity: 1.0,
        duration: Duration(milliseconds: 200),
        child: Card(
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
                    _imageUrlPrefix + widget.myHero.profileImgUrl,
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
                      widget.myHero.name,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 6),
                    Text(
                      widget.myHero.realName,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
