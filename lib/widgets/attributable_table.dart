
import 'package:flutter/material.dart';
import 'package:herotome/extensions/string_extension.dart';

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
          0: FractionColumnWidth(0.35),
          1: FractionColumnWidth(0.65),
        },
        children: map.entries
            .map<TableRow>((entry) => TableRow(
                  children: [
                    Container(
                      child: Text(entry.key.toTitleCase()),
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