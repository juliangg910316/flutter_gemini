import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_gemini/presentation/providers/chat/basic_chat.dart';
import 'package:flutter_gemini/presentation/providers/chat/is_gemini_writing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/users/user_provider.dart';

class BasicPromptScreen extends ConsumerWidget {
  const BasicPromptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final geminiUser = ref.watch(geminiUserProvider);
    final user = ref.watch(userProvider);
    final isGeminiWriting = ref.watch(isGeminiWritingProvider);
    final chatController = ref.watch(basicChatProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Basic Prompt')),
      body: Chat(
        // builders: Builders(
        //   chatAnimatedListBuilder: (context, itemBuilder) {
        //       return ChatAnimatedList(
        //         scrollController: _scrollController,
        //         itemBuilder: itemBuilder,
        //         shouldScrollToEndWhenAtBottom: false,
        //       );
        //     },
        //     imageMessageBuilder:
        //         (
        //           context,
        //           message,
        //           index, {
        //           required bool isSentByMe,
        //           MessageGroupStatus? groupStatus,
        //         }) => FlyerChatImageMessage(
        //           message: message,
        //           index: index,
        //           showTime: false,
        //           showStatus: false,
        //         ),
        //     composerBuilder: (context) => CustomComposer(
        //       isStreaming: _isStreaming,
        //       onStop: _stopCurrentStream,
        //       topWidget: ComposerActionBar(
        //         buttons: [
        //           ComposerActionButton(
        //             icon: Icons.delete_sweep,
        //             title: 'Clear all',
        //             onPressed: () {
        //               _chatController.setMessages([]);
        //               _chatSession = _model.startChat();
        //             },
        //             destructive: true,
        //           ),
        //         ],
        //       ),
        //     ),
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
        // ),
        chatController: chatController,
        currentUserId: user.id,
        resolveUser: (UserID id) async {
          return geminiUser;
        },
        onMessageSend: (message) {
          ref
              .read(basicChatProvider.notifier)
              .addMessage(text: message, authorId: user.id);
        },
        theme: ChatTheme.dark(),
      ),
    );
  }
}
