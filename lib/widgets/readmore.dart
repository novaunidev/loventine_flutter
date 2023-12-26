import 'package:flutter/material.dart';
import 'package:loventine_flutter/values/app_color.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  ExpandableText({required this.text});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;
  final defaultStyle = const TextStyle(
    fontFamily: 'Loventine-Regular',
    fontSize: 16,
    color: Color(0xff3C3F42),
  );

  @override
  Widget build(BuildContext context) {
    final textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: defaultStyle),
      maxLines: _isExpanded ? null : 5, // Số dòng giới hạn
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);

    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 180),
        firstChild: textPainter.didExceedMaxLines || _isExpanded
            ? RichText(
                text: TextSpan(
                  style: defaultStyle,
                  children: <TextSpan>[
                    TextSpan(
                      text: _isExpanded
                          ? widget.text
                          : widget.text.substring(0, 150),
                    ),
                    TextSpan(
                      text: _isExpanded ? "" : "... Xem thêm",
                      style: const TextStyle(
                        fontFamily: 'Loventine-Semibold',
                        fontSize: 15,
                        color: AppColor.mainColor,
                      ),
                    ),
                  ],
                ),
              )
            : Text(widget.text, style: defaultStyle),
        secondChild: Text(widget.text, style: defaultStyle),
        crossFadeState:
            _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      ),
    );
  }
}
