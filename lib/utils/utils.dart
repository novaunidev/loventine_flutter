import 'package:image_picker/image_picker.dart';
import 'package:just_audio/just_audio.dart' as Audio;
import 'package:shared_preferences/shared_preferences.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Image Selected');
}

late Audio.AudioPlayer _audioPlayer = Audio.AudioPlayer();

playAudio(String url) async {
  await _audioPlayer.setAsset(url);
  await _audioPlayer.setLoopMode(Audio.LoopMode.one);
  await _audioPlayer.setVolume(1.0);
  _audioPlayer.play();
}

stopAudio() {
  _audioPlayer.stop();
}

Future<bool?> checkAllowShowPostVerifyOption() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? value = await prefs.getBool('isAllowShowPostVerifyOption');
  return value;
}

Future<void> setAllowShowPostVerifyOption(bool value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isAllowShowPostVerifyOption', value);
}
