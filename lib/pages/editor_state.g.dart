// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editor_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedSceneGroup)
final selectedSceneGroupProvider = SelectedSceneGroupProvider._();

final class SelectedSceneGroupProvider
    extends $NotifierProvider<SelectedSceneGroup, SceneGroup?> {
  SelectedSceneGroupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedSceneGroupProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedSceneGroupHash();

  @$internal
  @override
  SelectedSceneGroup create() => SelectedSceneGroup();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SceneGroup? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SceneGroup?>(value),
    );
  }
}

String _$selectedSceneGroupHash() =>
    r'bca756d74f1d62111b6afefe1233d2b82acb9d61';

abstract class _$SelectedSceneGroup extends $Notifier<SceneGroup?> {
  SceneGroup? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SceneGroup?, SceneGroup?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SceneGroup?, SceneGroup?>,
              SceneGroup?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SelectedScene)
final selectedSceneProvider = SelectedSceneProvider._();

final class SelectedSceneProvider
    extends $NotifierProvider<SelectedScene, SceneId?> {
  SelectedSceneProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedSceneProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedSceneHash();

  @$internal
  @override
  SelectedScene create() => SelectedScene();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SceneId? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SceneId?>(value),
    );
  }
}

String _$selectedSceneHash() => r'6c0282f44b462bc3f820731ff9549a3d6df761e3';

abstract class _$SelectedScene extends $Notifier<SceneId?> {
  SceneId? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SceneId?, SceneId?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SceneId?, SceneId?>,
              SceneId?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SelectedScenePart)
final selectedScenePartProvider = SelectedScenePartProvider._();

final class SelectedScenePartProvider
    extends $NotifierProvider<SelectedScenePart, ScenePartId?> {
  SelectedScenePartProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedScenePartProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedScenePartHash();

  @$internal
  @override
  SelectedScenePart create() => SelectedScenePart();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScenePartId? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScenePartId?>(value),
    );
  }
}

String _$selectedScenePartHash() => r'099e6038558dfbbe3c02f1552719eb35d967d731';

abstract class _$SelectedScenePart extends $Notifier<ScenePartId?> {
  ScenePartId? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ScenePartId?, ScenePartId?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ScenePartId?, ScenePartId?>,
              ScenePartId?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
