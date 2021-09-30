import 'package:flutter/material.dart';

const Map<String, Color> powerColors = {
  "durability": Color(0xEE43BA2B),
  "energy": Color(0xEEB5287B),
  "fighting_skills": Color(0xEE1795D6),
  "intelligence": Color(0xEEFCD604),
  "speed": Color(0xEEE62429),
  "strength": Color(0xEEFB7600),
};

const Map<String, String> powerTitles = {
  "durability": 'Durability',
  "energy": 'Energy',
  "fighting_skills": 'Fighting Skills',
  "intelligence": 'Intelligence',
  "speed": 'Speed',
  "strength": 'Strength',
};

Widget buildPowerRatingChart(Map<String, int> powers, BuildContext context) {
  const double horizontalParentPadding = 12.0 * 2;
  const int maxVal = 7;

  final double fullWidth =
      (MediaQuery.of(context).size.width - horizontalParentPadding) * 0.9;
  final double textWidthFactor = 0.25;
  final double powerBarWidthFactor = 0.7;

  List<Widget> labelColumnList = [];
  List<Widget> ratingColumnList = [];

  for (var power in powers.keys) {
    String title = powerTitles[power]!;
    int rating = powers[power]!;
    labelColumnList
        .add(Container(width: fullWidth * textWidthFactor, child: Text(title)));
    ratingColumnList.add(
      buildBarForChart(rating.toDouble(), fullWidth, powerBarWidthFactor,
          maxVal, powerColors[power.toLowerCase()]!),
    );
  }

  List<Widget> myRows = [];
  for (int i = 0; i < labelColumnList.length; i++) {
    myRows.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          labelColumnList[i],
          ratingColumnList[i],
        ],
      ),
    ));
  }

  return Column(children: myRows);
}

Widget buildBarForChart(double rating, double fullWidth,
    double powerBarWidthFactor, int maxVal, Color powerBarColor) {
  if (maxVal <= 0) {
    maxVal = 1;
  }
  if (rating < 0) {
    rating = 0;
  } else if (rating > maxVal) {
    rating = maxVal.toDouble();
  }
  if (powerBarWidthFactor < 0) {
    powerBarWidthFactor = 1;
  } else if (powerBarWidthFactor > 1) {
    powerBarWidthFactor = 1;
  }
  double emptyBoxSize = maxVal - rating;
  return Container(
    // Grey bar/background
    key: ValueKey(powerBarColor.toString() + '-parent'),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: Colors.grey.withOpacity(0.4),
    ),
    child: Row(
      textDirection: TextDirection.ltr,
      children: [
        // Colored bar to show value
        SizedBox(
          key: ValueKey(powerBarColor.toString() + '-rating'),
          height: 10.0,
          width: (rating * fullWidth * powerBarWidthFactor) / maxVal,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: powerBarColor,
            ),
          ),
        ),
        // Transparent bar to show remaining space after colored bar
        SizedBox(
          key: ValueKey(powerBarColor.toString() + '-empty'),
          height: 10.0,
          width: (emptyBoxSize * fullWidth * powerBarWidthFactor) / maxVal,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.transparent,
            ),
          ),
        ),
      ],
    ),
  );
}
