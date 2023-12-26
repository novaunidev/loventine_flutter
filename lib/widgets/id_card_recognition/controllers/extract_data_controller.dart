// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'package:edge_detection/edge_detection.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_utils/qr_code_utils.dart';

class ExtractDataController extends GetxController {
  RxList<String> imagePaths = <String>[].obs;
  RxString imagePath = "".obs;
  RxInt imageCount = 0.obs;

  RxString idSerialNumber = "".obs;
  RxString idBirthdate = "".obs;
  RxString idAddress = "".obs;
  RxString idName = "".obs;

  String barcodeValue = '';

  RegExp dateRegex = RegExp(
      r'^\d{2}\.\d{2}\.\d{4}$'); // get date from picture and validate with this Regex

  //##### Region Get Image #####
  Future<void> getImage() async {
    bool isCameraGranted = await Permission.camera.request().isGranted;
    if (!isCameraGranted) {
      isCameraGranted =
          await Permission.camera.request() == PermissionStatus.granted;
    }

    if (!isCameraGranted) {
      // Have not permission to camera
      return;
    }

    // Generate filepath for saving
    imagePath.value = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpeg");

    try {
      // Make sure to await the call to detectEdge.

      bool success = await EdgeDetection.detectEdge(
        imagePath.value,
        canUseGallery: false,
        androidScanTitle: 'Scan', // use custom localizations for android
        androidCropTitle: 'Crop',
        androidCropBlackWhiteTitle: 'Black White',
        androidCropReset: 'Reset',
      );

      if (success) {
        imagePaths.add(imagePath.value);
      }
    } catch (e) {
      print(e);
    }
  }

  //##### Region Detect Image to Text #####
  Future<void> processImage() async {
    final InputImage inputImage;
    if (imagePath.value != null) {
      inputImage = InputImage.fromFilePath(imagePath.value);
      TextRecognizer textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      String text = recognizedText.text;
      List<String> lines = text.split('\n');

      ///
      final serialNumberPattern =
          RegExp(r'(Số|s6|S6)\s*:\s*(\S+)', caseSensitive: false);
      final birthDatePattern = RegExp(
          r'(Ngày, tháng, năm sinh|Ngay, tháng, năm Sinh)\s*:\s*(\S+)',
          caseSensitive: false);
      final addressPattern = RegExp(
          r'(Nơi thường trú|nơi thường tru)\s*:\s*(.+)',
          caseSensitive: false);
      final namePattern =
          RegExp(r'(Họ và tên|Ho va tên)\s*:\s*(\S+)', caseSensitive: false);

      final serialNumberMatch = serialNumberPattern.firstMatch(text);
      if (serialNumberMatch != null) {
        idSerialNumber.value = serialNumberMatch.group(2).toString();
      }

      final birthDateMatch = birthDatePattern.firstMatch(text);
      if (birthDateMatch != null) {
        idBirthdate.value = birthDateMatch.group(2).toString();
      }

      final addressMatch = addressPattern.firstMatch(text);
      if (addressMatch != null) {
        idAddress.value = addressMatch.group(2).toString();
      }

      final nameMatch = namePattern.firstMatch(text);
      if (nameMatch != null) {
        idName.value = nameMatch.group(2).toString();
      }
    }
  }

  //##### Region Detect QR #####
  Future<String?> scanFile() async {
    try {
      var response = await QrCodeUtils.decodeFrom(imagePath.value);
      barcodeValue = response.toString();

      //==== Processing CCCD data ====
      final parts = barcodeValue.split('|');
      if (parts.length >= 4) {
        idSerialNumber.value = parts[0];
        idName.value = parts[2];
        //= Định dạng lại chuỗi ngày tháng =
        final birthDateComponents = parts[3].split('');
        final formattedBirthDate =
            '${birthDateComponents[0]}${birthDateComponents[1]}/${birthDateComponents[2]}${birthDateComponents[3]}/${birthDateComponents[4]}${birthDateComponents[5]}${birthDateComponents[6]}${birthDateComponents[7]}';
        //= End =
        idBirthdate.value = formattedBirthDate;
        idAddress.value = parts[5];
      }
      //==== End =====================
    } on Exception catch (e) {
      print("There was an error: $e");
    }
    return barcodeValue;
  }
}
