import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
User geminiUser(Ref ref) {
  final geminiUser = User(id: 'user_123', name: 'John Doe');
  return geminiUser;
}
