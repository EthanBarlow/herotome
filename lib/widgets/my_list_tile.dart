import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:herotome/infrastructure/models/my_hero.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herotome/screens/DetailsScreen.dart';

import '../providers.dart';

class MyListTile extends StatelessWidget {
  final HeroProfile result;
  final Function close;
  const MyListTile({
    Key? key,
    required this.result,
    required this.close,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final notifier = watch(heroBiographyNotifierProvider.notifier);
        return GestureDetector(
          onTap: () {
            print('printing result');
            print(result.toString());
            // this.close();
            notifier.getBiography(result);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return DetailScreen();
              }),
            );
          },
          child: Container(
            color: Colors.orange,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Consumer(
                    builder: (context, watch, child) {
                      String imageUrlPrefix = watch(imageLinkPrefixProvider);
                      return CircleAvatar(
                        radius: 35.0,
                        foregroundImage: result.imgLink.contains('null') == true
                            ? NetworkImage(
                                'https://cdn.epicstream.com/assets/uploads/ckeditor/images/1625689604_Loki%20The%20Void%201.jpg')
                            : CachedNetworkImageProvider(
                                    imageUrlPrefix + result.imgLink)
                                as ImageProvider,
                      );
                    },
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: Text(
                      result.name,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ),
                  // SizedBox(width: 20.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
