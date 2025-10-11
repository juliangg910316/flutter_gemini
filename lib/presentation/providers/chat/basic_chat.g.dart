// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_chat.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BasicChat)
const basicChatProvider = BasicChatProvider._();

final class BasicChatProvider
    extends $NotifierProvider<BasicChat, InMemoryChatController> {
  const BasicChatProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'basicChatProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$basicChatHash();

  @$internal
  @override
  BasicChat create() => BasicChat();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InMemoryChatController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InMemoryChatController>(value),
    );
  }
}

String _$basicChatHash() => r'fe4ec2d8355c705bcb445f557406d1365473a46d';

abstract class _$BasicChat extends $Notifier<InMemoryChatController> {
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
