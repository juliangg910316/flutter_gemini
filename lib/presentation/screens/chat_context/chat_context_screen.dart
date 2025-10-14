import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_gemini/presentation/providers/chat/chat_with_context.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flyer_chat_image_message/flyer_chat_image_message.dart';

import '../../providers/users/user_provider.dart';
import '../../widgets/chat/custom_bottom_input.dart';

class ChatContextScreen extends ConsumerWidget {
  const ChatContextScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final geminiUser = ref.watch(geminiUserProvider);
    final user = ref.watch(userProvider);
    // final isGeminiWriting = ref.watch(isGeminiWritingProvider);
    final chatController = ref.watch(chatWithContextProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat conversacional'),
        actions: [
          IconButton(
            onPressed: ref.read(chatWithContextProvider.notifier).newChat,
            icon: const Icon(Icons.clear_outlined),
          ),
        ],
      ),
      body: Chat(
        builders: Builders(
          imageMessageBuilder:
              (
                context,
                message,
                index, {
                required bool isSentByMe,
                MessageGroupStatus? groupStatus,
              }) => FlyerChatImageMessage(
                message: message,
                index: index,
                showTime: false,
                showStatus: false,
              ),
          composerBuilder: (context) => CustomBottomInput(
            onSend: (partialText, {images = const []}) {
              ref
                  .read(chatWithContextProvider.notifier)
                  .addMessage(
                    text: partialText.text,
                    authorId: user.id,
                    images: images,
                  );
            },
            onAttachmentPressed: () {
              // Handle attachment action
            },
          ),
        ),
        chatController: chatController,
        currentUserId: user.id,
        resolveUser: (UserID id) async {
          return geminiUser;
        },
        theme: ChatTheme.dark(),
      ),
    );
  }
}
