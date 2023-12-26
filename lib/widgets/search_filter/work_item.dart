import 'package:flutter/material.dart';
import 'package:loventine_flutter/utils/enum.dart';
import 'package:loventine_flutter/values/app_color.dart';

import '../../models/work.dart';

class WorkItem extends StatefulWidget {
  final Work work;
  final Function selectWork;

  const WorkItem({Key? key, required this.work, required this.selectWork})
      : super(key: key);

  @override
  State<WorkItem> createState() => _WorkItemState();
}

class _WorkItemState extends State<WorkItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.selectWork(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.work.isSelected
              ? AppColor.mainColor
              : AppColor.mainColor.withOpacity(0.2),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                width: 8,
              ),
              Text(
                EnumHelper.getDescription(
                    EnumMap.adviseTypeValue, widget.work.type),
                style: TextStyle(
                    fontFamily: widget.work.isSelected
                        ? 'Loventine-Semibold'
                        : 'Loventine-Regular',
                    fontSize: 15,
                    color: Colors.white),
              ),
              const SizedBox(
                width: 8,
              ),
              const SizedBox(
                width: 8,
              ),
            ]),
      ),
    );
  }
}
