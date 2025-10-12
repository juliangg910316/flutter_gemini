import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_gemini/presentation/providers/chat/basic_chat.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flyer_chat_image_message/flyer_chat_image_message.dart';

import '../../providers/users/user_provider.dart';
import '../../widgets/chat/custom_bottom_input.dart';

class BasicPromptScreen extends ConsumerWidget {
  const BasicPromptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final geminiUser = ref.watch(geminiUserProvider);
    final user = ref.watch(userProvider);
    // final isGeminiWriting = ref.watch(isGeminiWritingProvider);
    final chatController = ref.watch(basicChatProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Basic Prompt')),
      body: Chat(
        builders: Builders(
          //   chatAnimatedListBuilder: (context, itemBuilder) {
          //       return ChatAnimatedList(
          //         scrollController: _scrollController,
          //         itemBuilder: itemBuilder,
          //         shouldScrollToEndWhenAtBottom: false,
          //       );
          //     },
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
                  .read(basicChatProvider.notifier)
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
          //     textMessageBuilder:
          //         (
          //           context,
          //           message,
          //           index, {
          //           required bool isSentByMe,
          //           MessageGroupStatus? groupStatus,
          //         }) => FlyerChatTextMessage(
          //           message: message,
          //           index: index,
          //           showTime: false,
          //           showStatus: false,
          //           receivedBackgroundColor: Colors.transparent,
          //           padding: message.authorId == _agent.id
          //               ? EdgeInsets.zero
          //               : const EdgeInsets.symmetric(
          //                   horizontal: 16,
          //                   vertical: 10,
          //                 ),
          //         ),
          //     textStreamMessageBuilder:
          //         (
          //           context,
          //           message,
          //           index, {
          //           required bool isSentByMe,
          //           MessageGroupStatus? groupStatus,
          //         }) {
          //           // Watch the manager for state updates
          //           final streamState = context
          //               .watch<GeminiStreamManager>()
          //               .getState(message.streamId);
          //           // Return the stream message widget, passing the state
          //           return FlyerChatTextStreamMessage(
          //             message: message,
          //             index: index,
          //             streamState: streamState,
          //             chunkAnimationDuration: _kChunkAnimationDuration,
          //             showTime: false,
          //             showStatus: false,
          //             receivedBackgroundColor: Colors.transparent,
          //             padding: message.authorId == _agent.id
          //                 ? EdgeInsets.zero
          //                 : const EdgeInsets.symmetric(
          //                     horizontal: 16,
          //                     vertical: 10,
          //                   ),
          //           );
          //         },
        ),
        chatController: chatController,
        currentUserId: user.id,

        // onAttachmentTap: () async {
        //   ImagePicker picker = ImagePicker();
        //   final List<XFile> images = await picker.pickMultiImage(limit: 4);
        //   if (images.isEmpty) return;
        //   print(images);
        // },
        resolveUser: (UserID id) async {
          return geminiUser;
        },
        // onMessageSend: (message) {
        //   ref
        //       .read(basicChatProvider.notifier)
        //       .addMessage(text: message, authorId: user.id);
        // },
        theme: ChatTheme.dark(),
      ),
    );
  }
}
