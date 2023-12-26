import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'spring_button.dart';

class ActionButton extends StatefulWidget {
  final bool isChange;
  final bool isLoading;
  final VoidCallback onTap;
  final Color? colorButtontl;
  final Color? colorButtonbr;
  final double? width;
  final double? height;
  final String text;
  final Color? colorText;
  final Widget? iconWidget;

  ActionButton({
    required this.isChange,
    required this.onTap,
    required this.text,
    required this.isLoading,
    this.width,
    this.colorButtontl,
    this.colorButtonbr,
    this.height,
    this.colorText,
    this.iconWidget,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return SpringButton(
      AnimatedContainer(
        duration: const Duration(milliseconds: 125),
        width: widget.isLoading ? 70 : widget.width ?? 230,
        height: widget.height ?? 50,
        curve: Curves.decelerate,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: LinearGradient(colors: [
            widget.isChange
                ? widget.colorButtontl ?? const Color(0xffff4377)
                : Colors.grey,
            widget.isChange
                ? widget.colorButtonbr ?? const Color(0xffFF4D6E)
                : Colors.grey,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Center(
          child: widget.isLoading
              ? Lottie.asset(
                  'assets/lotties/load_button.json',
                  width: 100,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.iconWidget != null) widget.iconWidget!,
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      widget.text,
                      style: TextStyle(
                        fontFamily: 'Loventine-Bold',
                        color: widget.colorText ?? Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
        ),
      ),
      useCache: false,
      onTap: () async {
        HapticFeedback.lightImpact();
        SystemSound.play(SystemSoundType.click);
        if (!widget.isLoading && widget.isChange) {
          widget.onTap();
        }
      },
    );
  }
}
// ################## For example
                // ActionButton(
                //   text: 'Thêm trường học',
                //   isChange: isChange,
                //   isLoading: isLoading,
                //   onTap: () async {
                //     setState(() {
                //       isLoading = true;
                //     });
                //     addEducation();
                //   },
                // ),
