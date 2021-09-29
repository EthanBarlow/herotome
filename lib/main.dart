import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herotome/application/hero_profile_notifier.dart';
import 'package:herotome/screens/DetailsScreen.dart';
import 'package:herotome/providers.dart';

import 'infrastructure/models/my_hero.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final ScrollController _scrollController;
  _scrollListener() {
    print(_scrollController.position.extentAfter);
    if (_scrollController.position.extentAfter < 500) {
      context.read(profileNotifierProvider.notifier).getProfileList();
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('HeroTome'),
        ),
        body: Container(
          // child: buildGrid(characters, heroList),
          child: buildGrid(),
        ),
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
          return GridView.builder(
              key: PageStorageKey<String>('controllerA'),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4 / 7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              controller: _scrollController,
              itemCount: profileState.profiles.length,
              padding: const EdgeInsets.all(5),
              itemBuilder: (BuildContext context, int elementIndex) {
                return ComicHeroProfileCard(
                    myHero: profileState.profiles.elementAt(elementIndex));
              });
        } else {
          return Center(child: Text('Unknown state!!!'));
        }
      },
    );
  }
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
      onTapCancel: () {
        setState(() {
          _pressed = false;
        });
      },
      onTapUp: (TapUpDetails details) {
        context
            .read(heroBiographyNotifierProvider.notifier)
            .getBiography(widget.myHero);

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
                  child: widget.myHero.imgLink.length < 2 ||
                          widget.myHero.imgLink.contains('null')
                      ? FlutterLogo()
                      : CachedNetworkImage(
                          imageUrl: _imageUrlPrefix + widget.myHero.imgLink,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
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
