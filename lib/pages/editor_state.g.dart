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
    r'c35696ccd9e76582d37028221d962f9d4af4c9fc';

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
    extends $NotifierProvider<SelectedScenePart, Id<OrderedScenePart>?> {
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
  Override overrideWithValue(Id<OrderedScenePart>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Id<OrderedScenePart>?>(value),
    );
  }
}

String _$selectedScenePartHash() => r'a080d2b92daeac3ca700717071e0935eea09b7bb';

abstract class _$SelectedScenePart extends $Notifier<Id<OrderedScenePart>?> {
  Id<OrderedScenePart>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Id<OrderedScenePart>?, Id<OrderedScenePart>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Id<OrderedScenePart>?, Id<OrderedScenePart>?>,
              Id<OrderedScenePart>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
