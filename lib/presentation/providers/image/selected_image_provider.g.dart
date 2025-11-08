// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_image_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedImage)
const selectedImageProvider = SelectedImageProvider._();

final class SelectedImageProvider
    extends $NotifierProvider<SelectedImage, String?> {
  const SelectedImageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedImageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedImageHash();

  @$internal
  @override
  SelectedImage create() => SelectedImage();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedImageHash() => r'b6bb8004fee91f3d4ecc56c6257c6a3bdd26e891';

abstract class _$SelectedImage extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
