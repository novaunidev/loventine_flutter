import 'package:flutter/material.dart';

class DragHandleBottomSheet extends StatelessWidget {
  const DragHandleBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        width: 40.0,
        height: 4.0,
        decoration: BoxDecoration(
          color: const Color(0xffdddddd),
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
    );
  }
}
