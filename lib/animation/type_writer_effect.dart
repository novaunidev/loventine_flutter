import 'dart:async';
import 'package:flutter/material.dart';

class TypeWriterTextEffect extends StatefulWidget {
  final String text;

  const TypeWriterTextEffect({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  _TypeWriterTextEffectState createState() => _TypeWriterTextEffectState();
}

class _TypeWriterTextEffectState extends State<TypeWriterTextEffect> {
  String _displayedString = '';
  int _stringIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _displayedString += widget.text[_stringIndex];
        _stringIndex++;
        if (_stringIndex >= widget.text.length) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedString,
      style: const TextStyle(
          fontSize: 30,
          fontFamily: "Loventine-Extrabold",
          color: Color(0xff020202)),
      textAlign: TextAlign.center,
    );
  }
}
