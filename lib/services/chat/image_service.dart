import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:photo_manager/photo_manager.dart';

// final cloudinary = Cloudinary.signedConfig(
//   apiKey: '692676895115767',
//   apiSecret: 'h1Ndj6maDQnyaNDx6ZxBX2HHON4',
//   cloudName: 'du7jhlk4c',
// );

final cloudinaryPublic =
    CloudinaryPublic('dkkdavbbq', 'mtrkthmf', cache: false);
List<File> files = [];
List<CloudinaryFile> cloudinaryList = [];

class ImageService {
  // static Future<String> uploadFile(XFile file) async {
  //   final response = await cloudinary.upload(
  //       file: file.path,
  //       //fileBytes: file.readAsBytesSync(),
  //       resourceType: CloudinaryResourceType.image,
  //       //folder: cloudinaryCustomFolder,
  //       fileName: file.name,
  //       progressCallback: (count, total) {
  //         print('Uploading image from file with progress: $count/$total');
  //       });

  //   if (response.isSuccessful) {
  //     print('Get your image from with ${response.secureUrl}');
  //     return response.secureUrl as String;
  //   }
  //   return "error";
  // }

  static Future<String> uploadFiles(List<AssetEntity> assets) async {
    files = [];
    cloudinaryList = [];
    try {
      await convertAssetsToCloudinaryFiles(assets);
      final responses = await cloudinaryPublic.uploadFiles(cloudinaryList);
      String urlimages = "";
      for (var response in responses) {
        urlimages = "$urlimages${response.secureUrl} ";
      }
      for (var file in files) {
        file.delete();
      }
      return urlimages;
    } catch (e) {
      print(e);
      return "error";
    }
  }

  static Future<File?> compressFile(File? file) async {
    const minKb = 150 * 1024;
    File? result = file;
    if (result!.lengthSync() < minKb) {
      return result;
    } else {
      try {
        int quality = (100 -
                (((result.lengthSync() - minKb) / result.lengthSync()) * 100))
            .toInt();
        result = await FlutterImageCompress.compressAndGetFile(
          result.absolute.path,
          "${result.path}.jpg",
          quality: quality > 50 ? quality : (quality * 2) + 1,
        );

        return result;
      } catch (e) {
        print(e);
        print("object");
        return result;
      }
    }
  }

  static Future convertAssetsToCloudinaryFiles(
      List<AssetEntity> assetEntities) async {
    for (var i = 0; i < assetEntities.length; i++) {
      final File? _file = await assetEntities[i].file;
      final file = await compressFile(_file!);
      final cloudinaryFile = CloudinaryFile.fromFile(file!.path,
          resourceType: CloudinaryResourceType.Image, folder: "message");
      files.add(file);
      cloudinaryList.add(cloudinaryFile);
    }
  }
}
