import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../config/gemini/gemini_impl.dart';
import '../users/user_provider.dart';
import 'is_gemini_writing.dart';

part 'basic_chat.g.dart';

@riverpod
class BasicChat extends _$BasicChat {
  final GeminiImpl gemini = GeminiImpl();
  @override
  InMemoryChatController build() {
    return InMemoryChatController();
  }

  void addMessage({required String text, required String authorId}) {
    state.insertMessage(
      TextMessage(
        id: Uuid().v4(),
        authorId: authorId,
        createdAt: DateTime.now().toUtc(),
        text: text,
      ),
    );
    _geminiTextResponse(text);
  }

  void _geminiTextResponse(String prompt) async {
    final isGeminiWriting = ref.read(isGeminiWritingProvider.notifier);
    final geminiUser = ref.read(geminiUserProvider);
    isGeminiWriting.setIsWriting();

    final textResponse = await gemini.getResponse(prompt);

    isGeminiWriting.setIsNotWriting();

    state.insertMessage(
      TextMessage(
        id: Uuid().v4(),
        authorId: geminiUser.id,
        createdAt: DateTime.now().toUtc(),
        text: textResponse,
      ),
    );
  }
}
