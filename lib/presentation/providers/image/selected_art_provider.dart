import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_art_provider.g.dart';

@riverpod
class SelectedArt extends _$SelectedArt {
  @override
  String build() {
    return '';
  }

  void setSelectedArt(String artPath) {
    if (artPath == state) {
      state = '';
      return;
    }
    state = artPath;
  }

  void clearSelectedArt() {
    state = '';
  }
}
