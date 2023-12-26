import 'package:flutter/material.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Help Center"),
      ),
      body: Center(
        child: Text(
          "Này để design rồi code sau nha mấy ní",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
