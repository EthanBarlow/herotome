
import 'package:flutter/material.dart';
import 'package:herotome/infrastructure/models/my_hero.dart';
import 'package:herotome/widgets/custom_carousel.dart';

class MovieDetailsTab extends StatelessWidget {
  const MovieDetailsTab({
    Key? key,
    required this.details,
  }) : super(key: key);

  final MovieDetails details;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              details.shortBio,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              width: double.infinity,
              child: Text(
                'Story Moments',
                style: TextStyle(fontSize: 22.0),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: FeatureSlider(
              highlightList: details.storyMoments,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              width: double.infinity,
              child: Text(
                'Powers & Abilities',
                style: TextStyle(fontSize: 22.0),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: FeatureSlider(
              highlightList: details.powersAbilities,
            ),
          ),
          Container(height: 40),
        ],
      ),
    );
  }
}