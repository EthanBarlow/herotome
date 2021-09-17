
import 'package:flutter/material.dart';

class AttributeTable extends StatelessWidget {
  const AttributeTable({
    Key? key,
    required this.map,
  }) : super(key: key);

  final Map<String, String> map;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        border: TableBorder.symmetric(
            inside: BorderSide(
          width: 2,
        )),
        columnWidths: {
          0: FractionColumnWidth(0.3),
          1: FractionColumnWidth(.7),
        },
        children: map.entries
            .map<TableRow>((entry) => TableRow(
                  children: [
                    Container(
                      //TODO: come back here and add in a helper function to convert a String to camelcase
                      child: Text(entry.key),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                    ),
                    Container(
                      child: Text(entry.value),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}