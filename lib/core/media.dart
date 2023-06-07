import 'package:image_picker/image_picker.dart';

class AppMedia {
  final ImagePicker imagePicker;
  const AppMedia({required this.imagePicker});

  Future<XFile?> pickImage() async {
    return imagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<XFile?> takeImage() async {
    return imagePicker.pickImage(source: ImageSource.camera);
  }

  Future<XFile?> pickVideo() async {
    return imagePicker.pickVideo(source: ImageSource.gallery);
  }

  Future<XFile?> takeVideo() async {
    return imagePicker.pickVideo(source: ImageSource.camera);
  }
}
