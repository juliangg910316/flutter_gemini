// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_generating_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IsGenerating)
const isGeneratingProvider = IsGeneratingProvider._();

final class IsGeneratingProvider extends $NotifierProvider<IsGenerating, bool> {
  const IsGeneratingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isGeneratingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isGeneratingHash();

  @$internal
  @override
  IsGenerating create() => IsGenerating();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isGeneratingHash() => r'eea04ffdb9684bd71c8bd0d6892771cfbaf7582a';

abstract class _$IsGenerating extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
