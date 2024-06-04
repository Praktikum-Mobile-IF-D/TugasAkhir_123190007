import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  final ImagePicker _picker = ImagePicker();

  void getImageFromCamera(Function(String?) callback) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
      );
      callback(pickedFile?.path);
    } catch (e) {
      print("Eror ketika mengambil gambar");
    }
  }
}