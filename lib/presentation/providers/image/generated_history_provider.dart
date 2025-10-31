import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated_history_provider.g.dart';

@riverpod
class GeneratedHistory extends _$GeneratedHistory {
  @override
  List<String> build() {
    return [];
  }

  void addToHistory(String imagePath) {
    state = [imagePath, ...state];
  }

  void clearHistory() {
    state = [];
  }
}
