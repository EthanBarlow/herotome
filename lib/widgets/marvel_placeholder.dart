import 'package:flutter/material.dart';
import 'package:herotome/constants.dart';

class MarvelPlaceholderCircleAvatar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: MyConstants.marvelRed,
        child: Icon(
          Icons.face_rounded,
          size: 52.0,
          color: MyConstants.marvelOffWhite,
        ),
        radius: 35.0,
      );
  }
}

class MarvelPlaceholder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        color: MyConstants.marvelRed,
        child: Icon(
          Icons.face_rounded,
          size: 82.0,
          color: MyConstants.marvelOffWhite,
        ),
      );
  }
}

