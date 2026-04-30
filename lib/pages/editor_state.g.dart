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
    r'8adece2da1c7780e840a503ad511b3d2c14c246c';

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
    extends $NotifierProvider<SelectedScene, Id<Scene>?> {
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
  Override overrideWithValue(Id<Scene>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Id<Scene>?>(value),
    );
  }
}

String _$selectedSceneHash() => r'820bfde5d2761131c14d25dd499600cbf572d285';

abstract class _$SelectedScene extends $Notifier<Id<Scene>?> {
  Id<Scene>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Id<Scene>?, Id<Scene>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Id<Scene>?, Id<Scene>?>,
              Id<Scene>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SelectedScenePart)
final selectedScenePartProvider = SelectedScenePartProvider._();

final class SelectedScenePartProvider
    extends
        $NotifierProvider<SelectedScenePart, FullId<Scene, OrderedScenePart>?> {
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
  Override overrideWithValue(FullId<Scene, OrderedScenePart>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FullId<Scene, OrderedScenePart>?>(
        value,
      ),
    );
  }
}

String _$selectedScenePartHash() => r'a3310bed19c9d7b97192eb47fbd9fb454efdf1c5';

abstract class _$SelectedScenePart
    extends $Notifier<FullId<Scene, OrderedScenePart>?> {
  FullId<Scene, OrderedScenePart>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              FullId<Scene, OrderedScenePart>?,
              FullId<Scene, OrderedScenePart>?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                FullId<Scene, OrderedScenePart>?,
                FullId<Scene, OrderedScenePart>?
              >,
              FullId<Scene, OrderedScenePart>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
