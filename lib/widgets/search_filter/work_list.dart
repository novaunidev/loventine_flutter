import 'package:flutter/material.dart';

import './work_item.dart';
import '../../models/work.dart';

class WorkList extends StatelessWidget {
  final List<Work> works;
  final Function selectWork;

  const WorkList({Key? key, required this.works, required this.selectWork})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      children: [
        for (var work in works) ...[
          WorkItem(
            work: work,
            selectWork: () => selectWork(work),
          ),
        ]
      ],
    );
  }
}
