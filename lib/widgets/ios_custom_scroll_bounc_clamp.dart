// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';

class IOSCustomScrollBouncClamp extends ScrollPhysics {
  const IOSCustomScrollBouncClamp({ScrollPhysics? parent})
      : super(parent: parent);

  @override
  IOSCustomScrollBouncClamp applyTo(ScrollPhysics? ancestor) {
    return IOSCustomScrollBouncClamp(parent: buildParent(ancestor));
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if (position.atEdge) {
      return ClampingScrollPhysics().applyPhysicsToUserOffset(position, offset);
    }
    return BouncingScrollPhysics().applyPhysicsToUserOffset(position, offset);
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    return ClampingScrollPhysics().applyBoundaryConditions(position, value);
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    if (position.atEdge) {
      return ClampingScrollPhysics()
          .createBallisticSimulation(position, velocity);
    }
    return BouncingScrollPhysics()
        .createBallisticSimulation(position, velocity);
  }
}
