import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_image_provider.g.dart';

@Riverpod(keepAlive: true)
class SelectedImage extends _$SelectedImage {
  @override
  String? build() => null;

  void setSelectedImage(String imagePath) {
    if (imagePath == state) {
      state = null;
      return;
    }
    state = imagePath;
  }

  void clearSelectedImage() {
    state = null;
  }
}
