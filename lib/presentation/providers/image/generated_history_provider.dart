import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated_history_provider.g.dart';

@Riverpod(keepAlive: true)
class GeneratedHistory extends _$GeneratedHistory {
  @override
  List<String> build() {
    return [];
  }

  void addToHistory(String imagePath) {
    if (!ref.mounted) return;
    if (imagePath.isEmpty) return;
    state = [imagePath, ...state];
  }

  void clearHistory() {
    state = [];
  }
}
