import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:herotome/widgets/bar_chart.dart';

void main() {
  testWidgets('Testing the buildBarForChart method that returns a Widget',
      (WidgetTester tester) async {
    // The character's score in a given power
    double rating = 3;
    // The width available to the entire bar
    double fullWidth = 800;
    // A number between 0 and 1 to be multiplied with the fullWidth to calculate the power bar's width
    double powerBarWidthFactor = 0.7;
    // The maximum possible score for a given power (based on Marvel's site, currently: 7)
    int maxVal = 7;
    Color powerBarColor = Color(0xEE43BA2B);

    await tester.pumpWidget(buildBarForChart(
        rating, fullWidth, powerBarWidthFactor, maxVal, powerBarColor));
    expect(
      find.byKey(ValueKey((powerBarColor.toString() + '-rating'))),
      findsOneWidget,
    );
    expect(
      find.byKey(ValueKey((powerBarColor.toString() + '-empty'))),
      findsOneWidget,
    );
  });
  testWidgets('Testing the buildBarForChart with negative rating',
      (WidgetTester tester) async {
    double rating = -1;
    double fullWidth = 800;
    double powerBarWidthFactor = 0.7;
    int maxVal = 7;
    Color powerBarColor = Color(0xEE43BA2B);

    await tester.pumpWidget(buildBarForChart(
        rating, fullWidth, powerBarWidthFactor, maxVal, powerBarColor));
    expect(
      find.byKey(ValueKey((powerBarColor.toString() + '-rating'))),
      findsOneWidget,
    );
    expect(
      find.byKey(ValueKey((powerBarColor.toString() + '-empty'))),
      findsOneWidget,
    );
  });
  testWidgets('Testing the buildBarForChart with greater than max rating',
      (WidgetTester tester) async {
    double rating = 11;
    double fullWidth = 800;
    double powerBarWidthFactor = 0.7;
    int maxVal = 7;
    Color powerBarColor = Color(0xEE43BA2B);

    await tester.pumpWidget(buildBarForChart(
        rating, fullWidth, powerBarWidthFactor, maxVal, powerBarColor));
    expect(
      find.byKey(ValueKey((powerBarColor.toString() + '-rating'))),
      findsOneWidget,
    );
    expect(
      find.byKey(ValueKey((powerBarColor.toString() + '-empty'))),
      findsOneWidget,
    );
  });
  testWidgets('Testing the buildBarForChart with negative powerBarWidthFactor',
      (WidgetTester tester) async {
    double rating = 3;
    double fullWidth = 800;
    double powerBarWidthFactor = -0.7;
    int maxVal = 7;
    Color powerBarColor = Color(0xEE43BA2B);

    await tester.pumpWidget(buildBarForChart(
        rating, fullWidth, powerBarWidthFactor, maxVal, powerBarColor));
    expect(
      find.byKey(ValueKey((powerBarColor.toString() + '-rating'))),
      findsOneWidget,
    );
    expect(
      find.byKey(ValueKey((powerBarColor.toString() + '-empty'))),
      findsOneWidget,
    );
  });
  testWidgets('Testing the buildBarForChart with powerBarWidthFactor > 1',
      (WidgetTester tester) async {
    double rating = 3;
    double fullWidth = 800;
    double powerBarWidthFactor = 1.02;
    int maxVal = 7;
    Color powerBarColor = Color(0xEE43BA2B);

    await tester.pumpWidget(buildBarForChart(
        rating, fullWidth, powerBarWidthFactor, maxVal, powerBarColor));
    expect(
      find.byKey(ValueKey((powerBarColor.toString() + '-rating'))),
      findsOneWidget,
    );
    expect(
      find.byKey(ValueKey((powerBarColor.toString() + '-empty'))),
      findsOneWidget,
    );
  });
  testWidgets('Testing the buildBarForChart with powerBarWidthFactor == 0',
      (WidgetTester tester) async {
    double rating = 3;
    double fullWidth = 800;
    double powerBarWidthFactor = 0;
    int maxVal = 7;
    Color powerBarColor = Color(0xEE43BA2B);

    await tester.pumpWidget(buildBarForChart(
        rating, fullWidth, powerBarWidthFactor, maxVal, powerBarColor));
    expect(
      find.byKey(ValueKey((powerBarColor.toString() + '-rating'))),
      findsOneWidget,
    );
    expect(
      find.byKey(ValueKey((powerBarColor.toString() + '-empty'))),
      findsOneWidget,
    );
  });
}
