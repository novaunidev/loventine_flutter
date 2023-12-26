import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loventine_flutter/values/app_color.dart';

void customDatePicker(
  BuildContext context,
  TextEditingController timeController, {
  Function(DateTime?)? onDateSelected,
  DateTime? initialDate,
  DateTime? firstDate,
}) {
  showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: firstDate ?? DateTime(1930),
    lastDate: DateTime(DateTime.now().year + 1),
    locale: const Locale('vi', 'VN'),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColor.mainColor,
          ),
          textTheme: const TextTheme(
            headline4: TextStyle(
              fontFamily: 'Loventine-Regular',
            ),
            headline6: TextStyle(
              fontFamily: 'Loventine-Regular',
            ),
            headline5: TextStyle(
              fontFamily: 'Loventine-Regular',
            ),
            overline: TextStyle(
              fontFamily: 'Loventine-Regular',
            ),
            bodyText1: TextStyle(
              fontFamily: 'Loventine-Regular',
            ),
            subtitle1: TextStyle(
              fontFamily: 'Loventine-Regular',
              color: AppColor.textBlack,
              fontSize: 16.5,
            ),
            subtitle2: TextStyle(
              fontFamily: 'Loventine-Regular',
            ),
            caption: TextStyle(
                fontFamily: 'Loventine-Bold',
                fontSize: 15.5,
                color: AppColor.textBlack),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontFamily: 'Loventine-Bold',
                fontSize: 15,
              ),
            ),
          ),
          dialogTheme: const DialogTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)))),
        ),
        child: child!,
      );
    },
  ).then((value) {
    if (value != null) {
      timeController.text = DateFormat('dd/MM/yyyy').format(value);
    }
    if (onDateSelected != null) {
      onDateSelected(value);
    }
  });
}
// ################## For example:
                                    // customDatePicker(
                                    //   context,
                                    //   _startTimeController,
                                    //   initialDate: initStartDate,
                                    //   onDateSelected: (value) {
                                    //     if (value != null) {
                                    //       setState(() {
                                    //         if (DateFormat('dd/MM/yyyy')
                                    //                 .format(value) !=
                                    //             widget.works[widget.workIndex]
                                    //                 .workStartDate) {
                                    //           isChange = true;
                                    //         } else {
                                    //           isChange = false;
                                    //         }
                                    //       });
                                    //     }
                                    //   },
                                    // );
// ################## Default:
                                    //  customDatePicker(
                                    //   context,
                                    //   _startTimeController,
                                    // );