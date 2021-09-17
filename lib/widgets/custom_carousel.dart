import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herotome/infrastructure/models/my_hero.dart';
import 'package:herotome/providers.dart';


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
        // height: 300,
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
                child: getNetworkImageWithConsumer(feature.image),
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
                    overflow: TextOverflow.fade,
                    maxLines: 3,
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

Widget getNetworkImageWithConsumer(String filename) {
  return Consumer(builder: (context, watch, child) {
    String prefix = watch(imageLinkPrefixProvider);
    return Image.network(prefix + filename);
  });
}
