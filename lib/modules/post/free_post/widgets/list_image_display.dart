// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ListImageDisplay extends StatelessWidget {
  final List<String> image;
  ListImageDisplay({super.key, required this.image});
  List<int> column1 = [1, 1, 1, 2, 2];
  List<int> column2 = [0, 1, 2, 2, 3];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                for (int i = 0; i < column1[image.length - 1]; i++)
                  Expanded(
                    child: _containerImage(image[i],
                        250 / column1[image.length - 1], double.infinity),
                  ),
              ],
            ),
          ),
          (image.length >= 2)
              ? Expanded(
                  child: Column(
                    children: [
                      for (int i = column1[image.length - 1];
                          i < image.length;
                          i++)
                        Expanded(
                          child: _containerImage(image[i],
                              250 / column2[image.length - 1], double.infinity),
                        ),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _containerImage(String image, double height, double width) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(image)),
      ),
    );
  }
}
