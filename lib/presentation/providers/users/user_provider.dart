import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user_provider.g.dart';

@riverpod
User geminiUser(Ref ref) {
  final geminiUser = User(id: 'user_gemini', name: 'Gemini');
  return geminiUser;
}

@riverpod
User user(Ref ref) {
  final user = User(id: Uuid().v4(), name: 'Julian');
  return user;
}
