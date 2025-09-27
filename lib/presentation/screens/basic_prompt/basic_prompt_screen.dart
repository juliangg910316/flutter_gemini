import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_gemini/presentation/providers/chat/is_gemini_writing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../providers/users/user_provider.dart';

class BasicPromptScreen extends ConsumerStatefulWidget {
  const BasicPromptScreen({super.key});

  @override
  ConsumerState<BasicPromptScreen> createState() => _BasicPromptScreenState();
}

class _BasicPromptScreenState extends ConsumerState<BasicPromptScreen> {
  final _chatController = InMemoryChatController();

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final geminiUser = ref.watch(geminiUserProvider);
    final user = ref.watch(userProvider);
    final isGeminiWriting = ref.watch(isGeminiWritingProvider);
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
        chatController: _chatController,
        currentUserId: user.id,
        resolveUser: (UserID id) async {
          return geminiUser;
        },
        onMessageSend: (message) {
          _chatController.insertMessage(
            TextMessage(
              // Better to use UUID or similar for the ID - IDs must be unique
              id: Uuid().v4(),
              authorId: user.id,
              createdAt: DateTime.now().toUtc(),
              text: message,
            ),
          );
        },
        theme: ChatTheme.dark(),
      ),
    );
  }
}
