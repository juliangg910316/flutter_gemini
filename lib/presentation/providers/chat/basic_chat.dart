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
  late User geminiUser;
  @override
  InMemoryChatController build() {
    geminiUser = ref.read(geminiUserProvider);
    return InMemoryChatController();
  }

  void addMessage({required String text, required String authorId}) {
    _createTextResponse(text, authorId);
    _geminiTextResponseStream(text);
  }

  void _geminiTextResponse(String prompt) async {
    _setGeminiWritingStatus(true);
    final textResponse = await gemini.getResponse(prompt);
    _setGeminiWritingStatus(false);
    _createTextResponse(textResponse, geminiUser.id);
  }

  void _geminiTextResponseStream(String prompt) async {
    _createTextResponse('Gemini esta pensando ...', geminiUser.id);
    gemini.getResponseStream(prompt).listen((responseChunk) {
      if (responseChunk.isEmpty) return;
      final updateMessage =
          state.messages.lastWhere((msg) => msg.authorId == geminiUser.id)
              as TextMessage;
      final updatedMessage = updateMessage.copyWith(text: responseChunk);
      state.updateMessage(updateMessage, updatedMessage);
    });
    // _createTextResponse(textResponse, geminiUser.id);
  }

  //Helper methods
  void _setGeminiWritingStatus(bool isWriting) {
    final isGeminiWriting = ref.read(isGeminiWritingProvider.notifier);
    isWriting
        ? isGeminiWriting.setIsWriting()
        : isGeminiWriting.setIsNotWriting();
  }

  void _createTextResponse(String text, String authorId) {
    state.insertMessage(
      TextMessage(
        id: Uuid().v4(),
        authorId: authorId,
        createdAt: DateTime.now().toUtc(),
        text: text,
      ),
    );
  }
}
