import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:image_picker/image_picker.dart';
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

  void addMessage({
    required String text,
    required String authorId,
    List<XFile> images = const [],
  }) {
    if (images.isNotEmpty) {
      _addTextMessageWithImage(text, authorId, images);
      return;
    }
    _addTextMessage(text, authorId);
  }

  void _addTextMessage(String text, String authorId) {
    _createTextResponse(text, authorId);
    _geminiTextResponseStream(text);
  }

  void _addTextMessageWithImage(
    String text,
    String authorId,
    List<XFile> images,
  ) async {
    for (final image in images) {
      _createImageResponse(image, authorId);
    }
    await Future.delayed(const Duration(milliseconds: 500));
    _createTextResponse(text, authorId);
    _geminiTextResponseStream(text, images: images);
  }

  void _geminiTextResponse(String prompt) async {
    _setGeminiWritingStatus(true);
    final textResponse = await gemini.getResponse(prompt);
    _setGeminiWritingStatus(false);
    _createTextResponse(textResponse, geminiUser.id);
  }

  void _geminiTextResponseStream(
    String prompt, {
    List<XFile> images = const [],
  }) async {
    _createTextResponse('Gemini esta pensando ...', geminiUser.id);
    gemini.getResponseStream(prompt, files: images).listen((responseChunk) {
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

  void _createImageResponse(XFile image, String authorId) async {
    state.insertMessage(
      ImageMessage(
        id: Uuid().v4(),
        authorId: authorId,
        createdAt: DateTime.now().toUtc(),
        source: image.path,
        size: await image.length(),
      ),
    );
  }
}
