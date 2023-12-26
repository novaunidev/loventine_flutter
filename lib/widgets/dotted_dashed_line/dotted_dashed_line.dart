import 'package:flutter/material.dart';
import '/widgets/dotted_dashed_line/dashed_line_painter.dart';

class DottedDashedLine extends StatelessWidget {
  ///The height of the widget. Should be greater than 0 only for Axis.vertical.
  final double height;

  ///The width of the widget. Should be greater than 0 only for Axis.horizontal.
  final double width;

  ///Axis can only be either Axis.horizontal or Axis.vertical.
  final Axis axis;

  ///dashHeight default to 5. Use dashHeight with vertical axis.
  final double dashHeight;

  ///dashWidth default to 5. Use dashWidth with horizontal axis.
  final double dashWidth;

  ///The space between two dash. Defaults to 3.
  final double dashSpace;

  ///The thickness of a single dash. Defaults to 1.
  final double strokeWidth;

  ///The color of a dash. Defaults to black.
  final Color dashColor;

  ///For Horizontal dash line declare width > 0 and height can be 0.

  ///For Vertical dash line declare height > 0 and width can be 0.

  ///Create a dashed line with given parameters.

  const DottedDashedLine(
      {Key? key,
      required this.height,
      required this.width,
      required this.axis,
      this.dashHeight = 5,
      this.dashWidth = 5,
      this.dashSpace = 3,
      this.strokeWidth = 1,
      this.dashColor = const Color.fromARGB(255, 222, 226, 230)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: DashedLinePainter(
          axis: axis,
          dashHeight: dashHeight,
          dashWidth: dashWidth,
          dashSpace: dashSpace,
          dashColor: dashColor,
          strokeWidth: strokeWidth),
    );
  }
}
