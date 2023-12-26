import 'package:flutter/material.dart';

import '/widgets/search_filter/field_item.dart';

class FieldList extends StatelessWidget {
  final List<String> fields;
  final Function deleteField;

  const FieldList({Key? key, required this.fields, required this.deleteField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return fields.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: const <Widget>[
                Text(
                  'Lĩnh vực trống',
                ),
              ],
            );
          })
        : SingleChildScrollView(
            child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                spacing: 7,
                runSpacing: 16,
                children: fields.map((item) {
                  return FieldItem(
                      content: item, deleteField: () => deleteField(item));
                }).toList()),
          );
  }
}
