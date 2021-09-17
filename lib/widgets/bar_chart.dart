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
    double emptyBoxSize = maxVal - rating.toDouble();
    labelColumnList
        .add(Container(width: fullWidth * textWidthFactor, child: Text(title)));
    ratingColumnList.add(
      buildBarForChart(rating.toDouble(), fullWidth, powerBarWidthFactor,
          maxVal, emptyBoxSize, powerColors[power.toLowerCase()]!),
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

Widget buildBarForChart(
    double rating,
    double fullWidth,
    double powerBarWidthFactor,
    int maxVal,
    double emptyBoxSize,
    Color powerBarColor) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: Colors.grey.withOpacity(0.4),
    ),
    child: Row(
      children: [
        SizedBox(
          height: 10.0,
          width: (rating * fullWidth * powerBarWidthFactor) / maxVal,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: powerBarColor,
            ),
          ),
        ),
        SizedBox(
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
