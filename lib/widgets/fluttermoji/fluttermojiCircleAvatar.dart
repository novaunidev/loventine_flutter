import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'fluttermojiController.dart';

class FluttermojiCircleAvatar extends StatelessWidget {
  final double radius;
  final Color? backgroundColor;
  FluttermojiCircleAvatar({Key? key, this.radius = 75.0, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (backgroundColor == null)
      CircleAvatar(radius: radius, child: buildGetX(context));
    return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        child: buildGetX(context));
  }

  //Convert SVG to PNG
  Future<Uint8List> svgToPng(String svgString, BuildContext context) async {
    final pictureInfo =
        await vg.loadPicture(SvgStringLoader(svgString), context);

    final image = await pictureInfo.picture.toImage(300, 300);
    final byteData = await image.toByteData(format: ImageByteFormat.png);

    if (byteData == null) {
      throw Exception('Unable to convert SVG to PNG');
    }

    final pngBytes = byteData.buffer.asUint8List();

    return pngBytes;
  }

  //
  GetX<FluttermojiController> buildGetX(BuildContext context) {
    return GetX<FluttermojiController>(
        init: FluttermojiController(),
        autoRemove: false,
        builder: (controller) {
          if (controller.fluttermoji.value.isEmpty) {
            return CupertinoActivityIndicator();
          }

          return FutureBuilder<Uint8List>(
            future: svgToPng(controller.fluttermoji.value, context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CupertinoActivityIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return const Text('No data');
              }
              //ImageSaver.saveImage(Uint8List.fromList(snapshot.data!), "oke");

              return SvgPicture.string(
                controller.fluttermoji.value,
                height: radius * 1.6,
                semanticsLabel: "Your Fluttermoji",
                placeholderBuilder: (context) => const Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            },
          );
        });
  }
}

// class ImageSaver {
//   // Lưu file .png từ Uint8List
//   static Future<void> saveImage(Uint8List imageBytes, String fileName) async {
//     try {
//       // Lấy đường dẫn đến thư mục lưu trữ cục bộ
//       final directory = await getApplicationDocumentsDirectory();
//       final filePath = '${directory.path}/$fileName.png';

//       // Tạo một tệp mới và ghi dữ liệu vào nó
//       final File file = File(filePath);
//       await file.writeAsBytes(imageBytes);

//       print('File $fileName.png đã được lưu tại: $filePath');
//     } catch (e) {
//       print('Lỗi khi lưu file: $e');
//     }
//   }
// }
