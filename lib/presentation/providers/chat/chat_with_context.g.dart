// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_with_context.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatWithContext)
const chatWithContextProvider = ChatWithContextProvider._();

final class ChatWithContextProvider
    extends $NotifierProvider<ChatWithContext, InMemoryChatController> {
  const ChatWithContextProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatWithContextProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatWithContextHash();

  @$internal
  @override
  ChatWithContext create() => ChatWithContext();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InMemoryChatController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InMemoryChatController>(value),
    );
  }
}

String _$chatWithContextHash() => r'cad5bf028440f29638dc356d03c83018c42d023d';

abstract class _$ChatWithContext extends $Notifier<InMemoryChatController> {
  InMemoryChatController build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<InMemoryChatController, InMemoryChatController>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<InMemoryChatController, InMemoryChatController>,
              InMemoryChatController,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
