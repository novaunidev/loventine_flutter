import 'package:flutter/cupertino.dart';
import 'package:loventine_flutter/providers/page/message_page/message_page_provider.dart';
import '/modules/profile/services/service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var imageURL = '';

  Future<String> uploadImage(
      ImageSource imageSource,
      idAvatar,
      BuildContext context,
      String userId,
      MessagePageProvider messagePageProvider) async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: imageSource, imageQuality: 12);
      isLoading(true);
      if (pickedFile != null) {
        //var response = await ImageService.uploadFile(pickedFile.path, idAvatar);
        var response = await ImageService.uploadFileWithCloudinary(
            pickedFile, idAvatar, context, messagePageProvider);
        if (response.statusCode == 200) {
          // ignore: use_build_context_synchronously
          return "thành công";
        } else {
          // ignore: use_build_context_synchronously
          return "Error code: ${response.statusCode}";
        }
      } else {
        return "chưa chọn ảnh";
      }
    } finally {
      isLoading(false);
    }
  }
}
