// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_status_pod.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Le résultat du dernier scan, affiché dans la barre du haut de chaque page. Il reste
/// jusqu'au scan suivant, y compris en changeant de page ; `null` tant que rien n'a été scanné.

@ProviderFor(ScanStatusPod)
final scanStatusPodProvider = ScanStatusPodProvider._();

/// Le résultat du dernier scan, affiché dans la barre du haut de chaque page. Il reste
/// jusqu'au scan suivant, y compris en changeant de page ; `null` tant que rien n'a été scanné.
final class ScanStatusPodProvider
    extends $NotifierProvider<ScanStatusPod, ScanResult?> {
  /// Le résultat du dernier scan, affiché dans la barre du haut de chaque page. Il reste
  /// jusqu'au scan suivant, y compris en changeant de page ; `null` tant que rien n'a été scanné.
  ScanStatusPodProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scanStatusPodProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scanStatusPodHash();

  @$internal
  @override
  ScanStatusPod create() => ScanStatusPod();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScanResult? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScanResult?>(value),
    );
  }
}

String _$scanStatusPodHash() => r'196ad58489b55bb20bd9a3b7c8a04a696ffda4bd';

/// Le résultat du dernier scan, affiché dans la barre du haut de chaque page. Il reste
/// jusqu'au scan suivant, y compris en changeant de page ; `null` tant que rien n'a été scanné.

abstract class _$ScanStatusPod extends $Notifier<ScanResult?> {
  ScanResult? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ScanResult?, ScanResult?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ScanResult?, ScanResult?>,
              ScanResult?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
