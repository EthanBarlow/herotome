import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:herotome/widgets/bar_chart.dart';

void main() {
  const Map<String, int> powers = {
    "durability": 7,
    "energy": 200,
    "fighting_skills": 3,
    "intelligence": 0,
    "speed": -5,
    "strengthstrengthstrengthstrengthstrength": 22,
  };
  testWidgets('buildPowerRatingChart with map returns a widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Container(
          child: Builder(builder: (BuildContext context) {
            return buildPowerRatingChart(powers, context);
          }),
        ),
      ),
    ));

    expect(find.byKey(Key('buildPowerRatingChart-parent')), findsOneWidget);
    expect(find.byType(SizedBox), findsWidgets);
  });

  testWidgets('buildPowerRatingChart with empty map returns a widget but no bars for chart',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Container(
          child: Builder(builder: (BuildContext context) {
            return buildPowerRatingChart({}, context);
          }),
        ),
      ),
    ));

    expect(find.byKey(Key('buildPowerRatingChart-parent')), findsOneWidget);
    expect(find.byType(SizedBox), findsNothing);
  });
}
