import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'linear_percent_indicator.dart';

enum SnackbarType { success, failure, warning }

class CustomSnackbar {
  static void show(
    BuildContext context, {
    String? title,
    String? message,
    String? lottiePath,
    Color? typeColor = const Color(0xff657f9a),
    bool? indicator = false,
    String? widgetIndicator = 'assets/lotties/rocket.json',
    SnackbarType? type,
    void Function()? onActionPressed,
    String? actionLabel,
    void Function(SnackBarClosedReason)? onClosed,
  }) {
    switch (type) {
      case SnackbarType.success:
        typeColor = const Color(0xff0BAA60);
        lottiePath = 'assets/lotties/snackbar_success.json';
        break;
      case SnackbarType.failure:
        typeColor = const Color(0xffF03D3D);
        lottiePath = 'assets/lotties/snackbar_failure.json';
        break;
      case SnackbarType.warning:
        typeColor = const Color(0xffE09400);
        lottiePath = 'assets/lotties/snackbar_warning.json';
        break;
      case null:
        // TODO: Handle this case.
        break;
    }

    Widget? lottie;
    if (lottiePath != null) {
      lottie = Lottie.asset(
        lottiePath,
        width: 45,
        height: 45,
        repeat: false,
      );
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            showCloseIcon: true,
            closeIconColor: const Color(0xff657f9a),
            content: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (lottiePath != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Center(child: lottie),
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (title != null)
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 17,
                                fontFamily: 'Loventine-Bold',
                                color: Color(0xff102a43),
                              ),
                            ),
                          if (message != null) const SizedBox(height: 4),
                          if (message != null)
                            Text(
                              message,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Loventine-Regular',
                                color: Color(0xff657f9a),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (indicator == true)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: LinearPercentIndicator(
                      lineHeight: 5,
                      progressColor: const Color(0xff2e79e5),
                      barRadius: const Radius.circular(10),
                      percent: 1,
                      restartAnimation: true,
                      animation: true,
                      animationDuration: 1500,
                      widgetIndicator: RotatedBox(
                          quarterTurns: 1,
                          child: Lottie.asset(widgetIndicator!, height: 50)),
                    ),
                  ),
              ],
            ),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: typeColor!.withOpacity(0.09), width: 3.5),
            ),
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            action: (onActionPressed != null)
                ? SnackBarAction(
                    label: actionLabel ?? 'Action',
                    onPressed: onActionPressed,
                  )
                : null,
          ),
        )
        .closed
        .then((SnackBarClosedReason reason) {
      onClosed?.call(reason);
    });
    ;
  }
}
