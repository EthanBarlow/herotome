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
  var _heroProfileCards = [
    ComicHero(
        name: 'Spider Man',
        realName: 'Peter Parker',
        profileImgUrl: '005smp_ons_crd_02.jpg'),
    ComicHero(
        name: 'Iron Man',
        realName: 'Tony Stark',
        profileImgUrl: '002irm_ons_crd_03.jpg'),
  ];
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: _heroProfileCards.length,
            itemBuilder: (BuildContext context, int index) {
              return ComicHeroProfileCard(myHero: _heroProfileCards[index]);
            }),
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

  ComicHeroProfileCard({required this.myHero});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: Column(
          children: [
           Container(
             clipBehavior: Clip.hardEdge,
            child: myHero.profileImgUrl != ''
                ? Image.network(
                    _imageUrlPrefix + myHero.profileImgUrl,
                    // height: 150,                    
                  )
                : Icon(
                    Icons.bug_report,
                    size: 24,
                  ),
           ),
            Text('${myHero.name} - ${myHero.realName}'),
          ],
      ),
    );
  }
}
