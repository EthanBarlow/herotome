
import 'package:flutter/material.dart';
import 'package:herotome/infrastructure/models/my_hero.dart';
import 'package:herotome/widgets/attributable_table.dart';
import 'package:herotome/widgets/bar_chart.dart';
import 'package:herotome/widgets/custom_card.dart';

class ComicDetailsTab extends StatelessWidget {
  const ComicDetailsTab({
    Key? key,
    required this.details,
  }) : super(key: key);

  final ComicDetails details;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          if (details.powerRatings.length != 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              // child: buildPowerRatingChart(details.powerRatings, context),
              child: CustomCard(
                child: Column(
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
                    buildPowerRatingChart(details.powerRatings, context),
                  ],
                ),
              ),
            ),

          // const SizedBox(height: 20.0),
          // Text(details.physicalAttributes.toString()),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: CustomCard(
              child: Column(
                children: [
                  Text(
                    'Physical Attributes',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Divider(
                    // thickness: 2.0,
                    indent: 60.0,
                    endIndent: 60.0,
                  ),
                  AttributeTable(map: details.physicalAttributes),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: CustomCard(
              child: Column(
                children: [
                  Text(
                    'Other Attributes',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Divider(
                    // thickness: 2.0,
                    indent: 60.0,
                    endIndent: 60.0,
                  ),
                  AttributeTable(map: details.contextualAttributes),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              details.biography.toString(),
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}