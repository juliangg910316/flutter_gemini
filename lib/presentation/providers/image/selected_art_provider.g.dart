// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_art_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedArt)
const selectedArtProvider = SelectedArtProvider._();

final class SelectedArtProvider extends $NotifierProvider<SelectedArt, String> {
  const SelectedArtProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedArtProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedArtHash();

  @$internal
  @override
  SelectedArt create() => SelectedArt();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$selectedArtHash() => r'1be8252f97452a5836e92632ff18d8804914bd5b';

abstract class _$SelectedArt extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
