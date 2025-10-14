import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../config/gemini/gemini_impl.dart';
import '../users/user_provider.dart';

part 'chat_with_context.g.dart';

@Riverpod(keepAlive: true)
class ChatWithContext extends _$ChatWithContext {
  final GeminiImpl gemini = GeminiImpl();
  late User geminiUser;
  late User chatUser;
  late String chatId;
  @override
  InMemoryChatController build() {
    geminiUser = ref.read(geminiUserProvider);
    chatUser = ref.read(userProvider);
    chatId = const Uuid().v4();
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

  void _geminiTextResponseStream(
    String prompt, {
    List<XFile> images = const [],
  }) async {
    _createTextResponse('Gemini esta pensando ...', geminiUser.id);
    gemini.getChatStream(prompt, chatId, files: images).listen((responseChunk) {
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
  void newChat() {
    state = InMemoryChatController();
    chatId = const Uuid().v4();
  }

  void loadPreviousMessages(String chatId) {
    //TODO: Implement loading previous messages from storage or API
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
