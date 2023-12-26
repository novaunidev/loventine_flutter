import 'package:flutter/material.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/providers/page/message_page/message_page_provider.dart';

import '../../../providers/chat/socket_provider.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:image_picker/image_picker.dart';

final cloudinary = Cloudinary.signedConfig(
  apiKey: '663785653612538',
  apiSecret: 'WvX9Fg1wbGyWz5IO-8NA5xtJ3HU',
  cloudName: 'dkkdavbbq',
);

class ImageService {
  static Future<dynamic> uploadFile(filePath, String idAvatar) async {
    try {
      FormData formData = new FormData.fromMap(
          {"image": await MultipartFile.fromFile(filePath)});
      Response response = await Dio().put(
        "$baseUrl/upload_image/$idAvatar",
        data: formData,
      );
      return response;
    } on DioError catch (e) {
      return e.response;
    } catch (e) {}
  }

  static Future<dynamic> uploadFileWithCloudinary(
      XFile file,
      String avatar_cloundinary_public_id,
      BuildContext context,
      MessagePageProvider messagePageProvider) async {
    try {
      // delete old avatar

      final responseCloudinary = await cloudinary.upload(
          file: file.path,
          //fileBytes: file.readAsBytesSync(),
          resourceType: CloudinaryResourceType.image,
          folder: "avatar",
          fileName: file.name,
          progressCallback: (count, total) {
            print('Uploading image from file with progress: $count/$total');
          });

      if (responseCloudinary.isSuccessful) {
        if (avatar_cloundinary_public_id != "") {
          await cloudinary.destroy("$avatar_cloundinary_public_id");
          await cloudinary.destroy("$avatar_cloundinary_public_id.jpg");
        }
        Response response = await Dio().put(
          "$baseUrl/user/edit_avatar/edit_avatar/${SocketProvider.current_user_id}",
          data: {
            "avatar": responseCloudinary.secureUrl,
            "public_id": responseCloudinary.publicId,
          },
        );
        if (response.statusCode == 200) {
          await messagePageProvider.setAvatarUrl(
              responseCloudinary.secureUrl!, responseCloudinary.publicId!);
        }
        return response;
      }
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      print(e);
    }
  }
}
