
import 'package:flutter/material.dart';

const Map<String, Color> powerColors = {
  "Durability": Color(0xEE43BA2B),
  "Energy": Color(0xEEB5287B),
  "Fighting Skills": Color(0xEE1795D6),
  "Intelligence": Color(0xEEFCD604),
  "Speed": Color(0xEEE62429),
  "Strength": Color(0xEEFB7600),
};

Widget buildChartRows(Map<String, double> powers, BuildContext context) {
  List<Widget> list = [];
  const int maxVal = 7;

  final double fullWidth = MediaQuery.of(context).size.width * 0.9;
  final double textWidthFactor = 0.25;
  final double powerBarWidthFactor = 0.7;

  List<Widget> labelColumnList = [];
  List<Widget> ratingColumnList = [];

  Row buildingRow;
  for (var power in powers.keys) {
    String title = power;
    double rating = powers[power]!;
    double emptyBoxSize = maxVal - rating;
    labelColumnList
        .add(Container(width: fullWidth * textWidthFactor, child: Text(title)));
    ratingColumnList.add(
      buildBarForChart(rating, fullWidth, powerBarWidthFactor, maxVal,
          emptyBoxSize, powerColors[power]!),
      // Text('Rating: $rating, remainder: $emptyBoxSize')
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

  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          offset: Offset(2,0),
          blurRadius: 2.0,
        ),
      ],
      borderRadius: BorderRadius.circular(12.0),
      color: Color(0xFF464646),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Stats',
            style: TextStyle(fontSize: 18.0),
          ),
          Divider(
            // thickness: 2.0,
            indent: 60.0,
            endIndent: 60.0,
          ),
          SizedBox(height: 10),
          ...myRows,
        ],
      ),
    ),
  );
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
