import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herotome/ComicHero.dart';
import 'package:herotome/application/hero_profile_notifier.dart';
import 'package:herotome/screens/DetailsScreen.dart';
import 'package:herotome/providers.dart';

import 'infrastructure/models/my_hero.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    context.read(profileNotifierProvider.notifier).getProfileList();
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
  // var _heroProfiles =
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference characters = firestore.collection('characters');
    List<ComicHero> heroList = [];
    return Scaffold(
      appBar: AppBar(
        title: Text('HeroTome'),
      ),
      body: Container(
        // child: buildGrid(characters, heroList),
        child: buildGrid(),
      ),
    );
  }

  Widget buildGrid() {
    return Consumer(
      builder: (context, watch, child) {
        final profileState = watch(profileNotifierProvider);
        if (profileState is ProfileInitial) {
          return Center(child: Text('initial state'));
        } else if (profileState is ProfileLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (profileState is ProfileLoaded) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 4 / 7,
            padding: const EdgeInsets.all(5),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: profileState.profiles
                .map((item) => ComicHeroProfileCard(myHero: item))
                .toList(),
          );
        } else {
          return Center(child: Text('Unknown state!!!'));
        }
      },
    );
  }

  // FutureBuilder<QuerySnapshot> buildGrid(CollectionReference characters, List<ComicHero> heroList) {
  //   return FutureBuilder<QuerySnapshot>(
  //         future: characters.limit(100).get(),
  //         builder:
  //             (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //           if (snapshot.hasError) {
  //             return Text('ERROR...!');
  //           }

  //           if (snapshot.hasData && !snapshot.data!.docs.first.exists) {
  //             return Text('Document not existing');
  //           }

  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return Center(child: CircularProgressIndicator());
  //           }

  //           if (snapshot.connectionState == ConnectionState.done) {
  //             // Map<String, dynamic> data =
  //             //     snapshot.data!.data() as Map<String, dynamic>;
  //             // return Text(data['headline']);
  //             List<QueryDocumentSnapshot>? docsList = snapshot.data?.docs;
  //             if (docsList != null) {
  //               for (var doc in docsList) {
  //                 Map<String, dynamic> data = doc.data();
  //                 ComicHero hero = getHeroFromDocData(data);
  //                 heroList.add(hero);
  //               }
  //               return GridView.count(
  //                 crossAxisCount: 2,
  //                 childAspectRatio: 4 / 7,
  //                 padding: const EdgeInsets.all(5),
  //                 crossAxisSpacing: 10,
  //                 mainAxisSpacing: 10,
  //                 children: heroList
  //                     .toList()
  //                     .map((item) => ComicHeroProfileCard(myHero: item))
  //                     .toList(),
  //               );
  //             } else {
  //               return Text('Looks like they took the day off');
  //             }
  //           }
  //           return Center(child: Text('No one is home'));
  //         });
  // }

}

ComicHero getHeroFromDocData(Map<String, dynamic> data) {
  ComicHero tempHero = new ComicHero(
    name: data['headline'] ?? '',
    realName: data['secondary_text'] ?? '',
    description: data['description'] ?? '',
    profileImgUrl: data['image']['filename'] ?? '',
    link: data['link']['link'] ?? '',
  );
  return tempHero;
}

const String _imageUrlPrefix =
    'https://terrigen-cdn-dev.marvel.com/content/prod/1x/';

class ComicHeroProfileCard extends StatefulWidget {
  final HeroProfile myHero;

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
        context.read(heroBiographyNotifierProvider.notifier).getBiography(
            // MyHero(name: widget.myHero.name, link: widget.myHero.link));
            // MyHero(name: 'Aunty May', link: 'characters/aunt-may-may-parker'));
            widget.myHero);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return DetailScreen();
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
                  child: widget.myHero.imgLink.length < 2
                      ? FlutterLogo()
                      : Image.network(
                          _imageUrlPrefix + widget.myHero.imgLink,
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
                    // SizedBox(height: 6),
                    // Text(
                    //   widget.myHero.realName,
                    //   style: TextStyle(fontSize: 14.0),
                    // ),
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
