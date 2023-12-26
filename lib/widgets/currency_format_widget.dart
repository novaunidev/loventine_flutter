import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loventine_flutter/widgets/app_text.dart';

String formatCurrency(double amount) {
  final formatter = NumberFormat('###,###,###', 'vi_VN');
  return formatter.format(amount);
}

class CurrencyFormatWidget extends StatelessWidget {
  final int amount;
  final TextStyle? style;
  final TextStyle? styleSymbol;

  const CurrencyFormatWidget({
    Key? key,
    required this.amount,
    this.style,
    this.styleSymbol,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          formatCurrency(amount.toDouble()),
          style: style ?? AppText.contentSemibold(),
        ),
        Text(
          "đ",
          style: styleSymbol ??
              AppText.contentSemibold(fontSize: 20, color: Colors.white),
        ),
      ],
    );
  }
}
