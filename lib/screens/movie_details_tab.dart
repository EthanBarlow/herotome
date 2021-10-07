import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:herotome/constants.dart';
import 'package:herotome/infrastructure/models/movie_details.dart';
import 'package:herotome/widgets/custom_carousel.dart';

class MovieDetailsTab extends StatefulWidget {
  const MovieDetailsTab({
    Key? key,
    required this.details,
  }) : super(key: key);

  final MovieDetails details;

  @override
  State<MovieDetailsTab> createState() => _MovieDetailsTabState();
}

class _MovieDetailsTabState extends State<MovieDetailsTab>
    with TickerProviderStateMixin {
  late Animation _cameraAnimation;
  late AnimationController _cameraAnimationController;
  late Timer _timer;

  @override
  void initState() {
    _cameraAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _cameraAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: -pi / 6,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: -pi / 6,
          end: 0.0,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: pi / 6,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: pi / 6,
          end: 0.0,
        ),
        weight: 1,
      ),
    ]).animate(_cameraAnimationController);

    // Fix for an error I was having: found on stack overflow
    //https://stackoverflow.com/questions/62726872/flutter-delayed-animation-code-error-animationcontroller-forward-called-afte
    _timer = Timer(Duration(milliseconds: 300), () {
      _cameraAnimationController.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraAnimationController.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.details.imgLink.length == 0
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _cameraAnimationController,
                builder: (context, child) => Transform.rotate(
                  origin: Offset(0.0, 4.0),
                  angle: _cameraAnimation.value,
                  child: Icon(
                    Icons.videocam_rounded,
                    size: 50.0,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  MyConstants.movieDetailsNoMovieYet,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ))
        : SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    widget.details.shortBio,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      MyConstants.movieDetailsStoryMoments,
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: FeatureSlider(
                    highlightList: widget.details.storyMoments,
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
                      MyConstants.movieDetailsPowersAbilities,
                      style: TextStyle(fontSize: 22.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: FeatureSlider(
                    highlightList: widget.details.powersAbilities,
                  ),
                ),
                Container(height: 40),
              ],
            ),
          );
  }
}
