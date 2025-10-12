import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomComposer extends StatefulWidget {
  const CustomComposer({super.key});

  @override
  State<CustomComposer> createState() => _CustomComposerState();
}

class _CustomComposerState extends State<CustomComposer> {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.onKeyEvent = _handleKeyEvent;
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    // Check for Shift+Enter
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.enter &&
        HardwareKeyboard.instance.isShiftPressed) {
      _handleSubmitted(_textController.text);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomSafeArea = MediaQuery.of(context).padding.bottom;
    // final theme = context.select(
    //   (ChatTheme t) => (
    //     bodyMedium: t.typography.bodyMedium,
    //     onSurface: t.colors.onSurface,
    //     primary: t.colors.primary,
    //     surfaceContainerHigh: t.colors.surfaceContainerHigh,
    //     surfaceContainerLow: t.colors.surfaceContainerLow,
    //   ),
    // );

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: ClipRect(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: bottomSafeArea,
          ).add(const EdgeInsets.all(8.0)),
          child: Row(
            spacing: 8,
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Escreva uma mensagem...',
                    // hintStyle: theme.bodyMedium.copyWith(
                    //   color: theme.onSurface.withValues(alpha: 0.5),
                    // ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                    ),
                    filled: true,
                    // fillColor: theme.surfaceContainerHigh.withValues(
                    //   alpha: 0.8,
                    // ),
                    hoverColor: Colors.transparent,
                  ),
                  // style: theme.bodyMedium.copyWith(
                  //   color: theme.onSurface,
                  // ),
                  onSubmitted: _handleSubmitted,
                  textInputAction: TextInputAction.newline,
                  autocorrect: true,
                  autofocus: false,
                  textCapitalization: TextCapitalization.sentences,
                  focusNode: _focusNode,
                  minLines: 1,
                  maxLines: 3,
                ),
              ),
              FloatingActionButton(
                onPressed: () => _handleSubmitted(_textController.text),
                backgroundColor: Theme.of(context).primaryColor,
                child: const Icon(
                  Icons.send, // Puedes cambiar el icono
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      // context.read<ChatCubit>().sendMessage(text);
      _textController.clear();
    }
  }
}
