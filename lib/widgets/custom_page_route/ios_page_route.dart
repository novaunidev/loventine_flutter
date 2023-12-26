import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../cupertino_bottom_sheet/modal_bottom_sheet.dart'
    as modal_bottom_sheet;

class IosPageRoute<T> extends MaterialPageRoute<T> {
  IosPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            settings: settings,
            fullscreenDialog: fullscreenDialog,
            builder: builder,
            maintainState: maintainState);

  modal_bottom_sheet.ModalSheetRoute? _nextModalRoute;

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    return (nextRoute is MaterialPageRoute && !nextRoute.fullscreenDialog) ||
        (nextRoute is CupertinoPageRoute && !nextRoute.fullscreenDialog) ||
        (nextRoute is IosPageRoute && !nextRoute.fullscreenDialog) ||
        (nextRoute is modal_bottom_sheet.ModalSheetRoute);
  }

  @override
  void didChangeNext(Route? nextRoute) {
    if (nextRoute is modal_bottom_sheet.ModalSheetRoute) {
      _nextModalRoute = nextRoute;
    }

    super.didChangeNext(nextRoute);
  }

  @override
  bool didPop(T? result) {
    _nextModalRoute = null;
    return super.didPop(result);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const iosTransition = CupertinoPageTransitionsBuilder();
    final nextRoute = _nextModalRoute;
    if (nextRoute != null) {
      if (!secondaryAnimation.isDismissed) {
        final fakeSecondaryAnimation =
            Tween<double>(begin: 0, end: 0).animate(secondaryAnimation);
        final iosTransitionEffect = iosTransition.buildTransitions<T>(
            this, context, animation, fakeSecondaryAnimation, child);
        return nextRoute.getPreviousRouteTransition(
            context, secondaryAnimation, iosTransitionEffect);
      } else {
        _nextModalRoute = null;
      }
    }

    return iosTransition.buildTransitions<T>(
        this, context, animation, secondaryAnimation, child);
  }
}
