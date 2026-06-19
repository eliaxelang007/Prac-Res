// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// ignore_for_file: type=lint
class $ScenesTable extends Scenes with TableInfo<$ScenesTable, Scene> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScenesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scenes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Scene> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Scene map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Scene(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $ScenesTable createAlias(String alias) {
    return $ScenesTable(attachedDatabase, alias);
  }
}

class Scene extends DataClass implements Insertable<Scene>, Group {
  final int id;
  final String name;
  const Scene({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  ScenesCompanion toCompanion(bool nullToAbsent) {
    return ScenesCompanion(id: Value(id), name: Value(name));
  }

  factory Scene.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Scene(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Scene copyWith({int? id, String? name}) =>
      Scene(id: id ?? this.id, name: name ?? this.name);
  Scene copyWithCompanion(ScenesCompanion data) {
    return Scene(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Scene(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Scene && other.id == this.id && other.name == this.name);
}

class ScenesCompanion extends UpdateCompanion<Scene> {
  final Value<int> id;
  final Value<String> name;
  const ScenesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  ScenesCompanion.insert({this.id = const Value.absent(), required String name})
    : name = Value(name);
  static Insertable<Scene> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  ScenesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return ScenesCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScenesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ScenePartsTable extends SceneParts
    with TableInfo<$ScenePartsTable, ScenePart> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScenePartsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sceneIdMeta = const VerificationMeta(
    'sceneId',
  );
  @override
  late final GeneratedColumn<int> sceneId = GeneratedColumn<int>(
    'scene_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES scenes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<double> order = GeneratedColumn<double>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _partTypeMeta = const VerificationMeta(
    'partType',
  );
  @override
  late final GeneratedColumn<String> partType = GeneratedColumn<String>(
    'part_type',
    aliasedName,
    false,
    check: () => partType.isIn(ScenePartType.values.map((value) => value.name)),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, sceneId, order, partType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scene_parts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScenePart> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('scene_id')) {
      context.handle(
        _sceneIdMeta,
        sceneId.isAcceptableOrUnknown(data['scene_id']!, _sceneIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sceneIdMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    if (data.containsKey('part_type')) {
      context.handle(
        _partTypeMeta,
        partType.isAcceptableOrUnknown(data['part_type']!, _partTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_partTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScenePart map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScenePart(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sceneId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scene_id'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}order'],
      )!,
      partType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_type'],
      )!,
    );
  }

  @override
  $ScenePartsTable createAlias(String alias) {
    return $ScenePartsTable(attachedDatabase, alias);
  }
}

class ScenePart extends DataClass implements Insertable<ScenePart> {
  final int id;
  final int sceneId;
  final double order;
  final String partType;
  const ScenePart({
    required this.id,
    required this.sceneId,
    required this.order,
    required this.partType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['scene_id'] = Variable<int>(sceneId);
    map['order'] = Variable<double>(order);
    map['part_type'] = Variable<String>(partType);
    return map;
  }

  ScenePartsCompanion toCompanion(bool nullToAbsent) {
    return ScenePartsCompanion(
      id: Value(id),
      sceneId: Value(sceneId),
      order: Value(order),
      partType: Value(partType),
    );
  }

  factory ScenePart.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScenePart(
      id: serializer.fromJson<int>(json['id']),
      sceneId: serializer.fromJson<int>(json['sceneId']),
      order: serializer.fromJson<double>(json['order']),
      partType: serializer.fromJson<String>(json['partType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sceneId': serializer.toJson<int>(sceneId),
      'order': serializer.toJson<double>(order),
      'partType': serializer.toJson<String>(partType),
    };
  }

  ScenePart copyWith({
    int? id,
    int? sceneId,
    double? order,
    String? partType,
  }) => ScenePart(
    id: id ?? this.id,
    sceneId: sceneId ?? this.sceneId,
    order: order ?? this.order,
    partType: partType ?? this.partType,
  );
  ScenePart copyWithCompanion(ScenePartsCompanion data) {
    return ScenePart(
      id: data.id.present ? data.id.value : this.id,
      sceneId: data.sceneId.present ? data.sceneId.value : this.sceneId,
      order: data.order.present ? data.order.value : this.order,
      partType: data.partType.present ? data.partType.value : this.partType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScenePart(')
          ..write('id: $id, ')
          ..write('sceneId: $sceneId, ')
          ..write('order: $order, ')
          ..write('partType: $partType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sceneId, order, partType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScenePart &&
          other.id == this.id &&
          other.sceneId == this.sceneId &&
          other.order == this.order &&
          other.partType == this.partType);
}

class ScenePartsCompanion extends UpdateCompanion<ScenePart> {
  final Value<int> id;
  final Value<int> sceneId;
  final Value<double> order;
  final Value<String> partType;
  const ScenePartsCompanion({
    this.id = const Value.absent(),
    this.sceneId = const Value.absent(),
    this.order = const Value.absent(),
    this.partType = const Value.absent(),
  });
  ScenePartsCompanion.insert({
    this.id = const Value.absent(),
    required int sceneId,
    required double order,
    required String partType,
  }) : sceneId = Value(sceneId),
       order = Value(order),
       partType = Value(partType);
  static Insertable<ScenePart> custom({
    Expression<int>? id,
    Expression<int>? sceneId,
    Expression<double>? order,
    Expression<String>? partType,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sceneId != null) 'scene_id': sceneId,
      if (order != null) 'order': order,
      if (partType != null) 'part_type': partType,
    });
  }

  ScenePartsCompanion copyWith({
    Value<int>? id,
    Value<int>? sceneId,
    Value<double>? order,
    Value<String>? partType,
  }) {
    return ScenePartsCompanion(
      id: id ?? this.id,
      sceneId: sceneId ?? this.sceneId,
      order: order ?? this.order,
      partType: partType ?? this.partType,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sceneId.present) {
      map['scene_id'] = Variable<int>(sceneId.value);
    }
    if (order.present) {
      map['order'] = Variable<double>(order.value);
    }
    if (partType.present) {
      map['part_type'] = Variable<String>(partType.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScenePartsCompanion(')
          ..write('id: $id, ')
          ..write('sceneId: $sceneId, ')
          ..write('order: $order, ')
          ..write('partType: $partType')
          ..write(')'))
        .toString();
  }
}

class $PlacesTable extends Places with TableInfo<$PlacesTable, Place> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'places';
  @override
  VerificationContext validateIntegrity(
    Insertable<Place> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Place map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Place(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $PlacesTable createAlias(String alias) {
    return $PlacesTable(attachedDatabase, alias);
  }
}

class Place extends DataClass implements Insertable<Place>, Group {
  final int id;
  final String name;
  const Place({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  PlacesCompanion toCompanion(bool nullToAbsent) {
    return PlacesCompanion(id: Value(id), name: Value(name));
  }

  factory Place.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Place(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Place copyWith({int? id, String? name}) =>
      Place(id: id ?? this.id, name: name ?? this.name);
  Place copyWithCompanion(PlacesCompanion data) {
    return Place(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Place(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Place && other.id == this.id && other.name == this.name);
}

class PlacesCompanion extends UpdateCompanion<Place> {
  final Value<int> id;
  final Value<String> name;
  const PlacesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  PlacesCompanion.insert({this.id = const Value.absent(), required String name})
    : name = Value(name);
  static Insertable<Place> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  PlacesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return PlacesCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlacesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $BackgroundMetadatasTable extends BackgroundMetadatas
    with TableInfo<$BackgroundMetadatasTable, BackgroundMetadata> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackgroundMetadatasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES places (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, groupId, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'background_metadatas';
  @override
  VerificationContext validateIntegrity(
    Insertable<BackgroundMetadata> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BackgroundMetadata map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackgroundMetadata(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $BackgroundMetadatasTable createAlias(String alias) {
    return $BackgroundMetadatasTable(attachedDatabase, alias);
  }
}

class BackgroundMetadata extends DataClass
    implements Insertable<BackgroundMetadata>, ImageMetadata {
  final int id;
  final int groupId;
  final String name;
  const BackgroundMetadata({
    required this.id,
    required this.groupId,
    required this.name,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_id'] = Variable<int>(groupId);
    map['name'] = Variable<String>(name);
    return map;
  }

  BackgroundMetadatasCompanion toCompanion(bool nullToAbsent) {
    return BackgroundMetadatasCompanion(
      id: Value(id),
      groupId: Value(groupId),
      name: Value(name),
    );
  }

  factory BackgroundMetadata.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackgroundMetadata(
      id: serializer.fromJson<int>(json['id']),
      groupId: serializer.fromJson<int>(json['groupId']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'groupId': serializer.toJson<int>(groupId),
      'name': serializer.toJson<String>(name),
    };
  }

  BackgroundMetadata copyWith({int? id, int? groupId, String? name}) =>
      BackgroundMetadata(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        name: name ?? this.name,
      );
  BackgroundMetadata copyWithCompanion(BackgroundMetadatasCompanion data) {
    return BackgroundMetadata(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackgroundMetadata(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackgroundMetadata &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.name == this.name);
}

class BackgroundMetadatasCompanion extends UpdateCompanion<BackgroundMetadata> {
  final Value<int> id;
  final Value<int> groupId;
  final Value<String> name;
  const BackgroundMetadatasCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.name = const Value.absent(),
  });
  BackgroundMetadatasCompanion.insert({
    this.id = const Value.absent(),
    required int groupId,
    required String name,
  }) : groupId = Value(groupId),
       name = Value(name);
  static Insertable<BackgroundMetadata> custom({
    Expression<int>? id,
    Expression<int>? groupId,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (name != null) 'name': name,
    });
  }

  BackgroundMetadatasCompanion copyWith({
    Value<int>? id,
    Value<int>? groupId,
    Value<String>? name,
  }) {
    return BackgroundMetadatasCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackgroundMetadatasCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $FramesTable extends Frames with TableInfo<$FramesTable, Frame> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FramesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _scenePartIdMeta = const VerificationMeta(
    'scenePartId',
  );
  @override
  late final GeneratedColumn<int> scenePartId = GeneratedColumn<int>(
    'scene_part_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES scene_parts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _backgroundIdMeta = const VerificationMeta(
    'backgroundId',
  );
  @override
  late final GeneratedColumn<int> backgroundId = GeneratedColumn<int>(
    'background_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES background_metadatas (id) ON DELETE SET NULL',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [scenePartId, backgroundId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'frames';
  @override
  VerificationContext validateIntegrity(
    Insertable<Frame> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('scene_part_id')) {
      context.handle(
        _scenePartIdMeta,
        scenePartId.isAcceptableOrUnknown(
          data['scene_part_id']!,
          _scenePartIdMeta,
        ),
      );
    }
    if (data.containsKey('background_id')) {
      context.handle(
        _backgroundIdMeta,
        backgroundId.isAcceptableOrUnknown(
          data['background_id']!,
          _backgroundIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {scenePartId};
  @override
  Frame map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Frame(
      scenePartId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scene_part_id'],
      )!,
      backgroundId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}background_id'],
      ),
    );
  }

  @override
  $FramesTable createAlias(String alias) {
    return $FramesTable(attachedDatabase, alias);
  }
}

class Frame extends DataClass implements Insertable<Frame> {
  final int scenePartId;
  final int? backgroundId;
  const Frame({required this.scenePartId, this.backgroundId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['scene_part_id'] = Variable<int>(scenePartId);
    if (!nullToAbsent || backgroundId != null) {
      map['background_id'] = Variable<int>(backgroundId);
    }
    return map;
  }

  FramesCompanion toCompanion(bool nullToAbsent) {
    return FramesCompanion(
      scenePartId: Value(scenePartId),
      backgroundId: backgroundId == null && nullToAbsent
          ? const Value.absent()
          : Value(backgroundId),
    );
  }

  factory Frame.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Frame(
      scenePartId: serializer.fromJson<int>(json['scenePartId']),
      backgroundId: serializer.fromJson<int?>(json['backgroundId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'scenePartId': serializer.toJson<int>(scenePartId),
      'backgroundId': serializer.toJson<int?>(backgroundId),
    };
  }

  Frame copyWith({
    int? scenePartId,
    Value<int?> backgroundId = const Value.absent(),
  }) => Frame(
    scenePartId: scenePartId ?? this.scenePartId,
    backgroundId: backgroundId.present ? backgroundId.value : this.backgroundId,
  );
  Frame copyWithCompanion(FramesCompanion data) {
    return Frame(
      scenePartId: data.scenePartId.present
          ? data.scenePartId.value
          : this.scenePartId,
      backgroundId: data.backgroundId.present
          ? data.backgroundId.value
          : this.backgroundId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Frame(')
          ..write('scenePartId: $scenePartId, ')
          ..write('backgroundId: $backgroundId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(scenePartId, backgroundId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Frame &&
          other.scenePartId == this.scenePartId &&
          other.backgroundId == this.backgroundId);
}

class FramesCompanion extends UpdateCompanion<Frame> {
  final Value<int> scenePartId;
  final Value<int?> backgroundId;
  const FramesCompanion({
    this.scenePartId = const Value.absent(),
    this.backgroundId = const Value.absent(),
  });
  FramesCompanion.insert({
    this.scenePartId = const Value.absent(),
    this.backgroundId = const Value.absent(),
  });
  static Insertable<Frame> custom({
    Expression<int>? scenePartId,
    Expression<int>? backgroundId,
  }) {
    return RawValuesInsertable({
      if (scenePartId != null) 'scene_part_id': scenePartId,
      if (backgroundId != null) 'background_id': backgroundId,
    });
  }

  FramesCompanion copyWith({
    Value<int>? scenePartId,
    Value<int?>? backgroundId,
  }) {
    return FramesCompanion(
      scenePartId: scenePartId ?? this.scenePartId,
      backgroundId: backgroundId ?? this.backgroundId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (scenePartId.present) {
      map['scene_part_id'] = Variable<int>(scenePartId.value);
    }
    if (backgroundId.present) {
      map['background_id'] = Variable<int>(backgroundId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FramesCompanion(')
          ..write('scenePartId: $scenePartId, ')
          ..write('backgroundId: $backgroundId')
          ..write(')'))
        .toString();
  }
}

class $ScenePartResolversTable extends ScenePartResolvers
    with TableInfo<$ScenePartResolversTable, ScenePartResolver> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScenePartResolversTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _scenePartIdMeta = const VerificationMeta(
    'scenePartId',
  );
  @override
  late final GeneratedColumn<int> scenePartId = GeneratedColumn<int>(
    'scene_part_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES scene_parts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dartResolverScriptMeta =
      const VerificationMeta('dartResolverScript');
  @override
  late final GeneratedColumn<String> dartResolverScript =
      GeneratedColumn<String>(
        'dart_resolver_script',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [scenePartId, dartResolverScript];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scene_part_resolvers';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScenePartResolver> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('scene_part_id')) {
      context.handle(
        _scenePartIdMeta,
        scenePartId.isAcceptableOrUnknown(
          data['scene_part_id']!,
          _scenePartIdMeta,
        ),
      );
    }
    if (data.containsKey('dart_resolver_script')) {
      context.handle(
        _dartResolverScriptMeta,
        dartResolverScript.isAcceptableOrUnknown(
          data['dart_resolver_script']!,
          _dartResolverScriptMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dartResolverScriptMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {scenePartId};
  @override
  ScenePartResolver map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScenePartResolver(
      scenePartId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scene_part_id'],
      )!,
      dartResolverScript: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dart_resolver_script'],
      )!,
    );
  }

  @override
  $ScenePartResolversTable createAlias(String alias) {
    return $ScenePartResolversTable(attachedDatabase, alias);
  }
}

class ScenePartResolver extends DataClass
    implements Insertable<ScenePartResolver> {
  final int scenePartId;
  final String dartResolverScript;
  const ScenePartResolver({
    required this.scenePartId,
    required this.dartResolverScript,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['scene_part_id'] = Variable<int>(scenePartId);
    map['dart_resolver_script'] = Variable<String>(dartResolverScript);
    return map;
  }

  ScenePartResolversCompanion toCompanion(bool nullToAbsent) {
    return ScenePartResolversCompanion(
      scenePartId: Value(scenePartId),
      dartResolverScript: Value(dartResolverScript),
    );
  }

  factory ScenePartResolver.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScenePartResolver(
      scenePartId: serializer.fromJson<int>(json['scenePartId']),
      dartResolverScript: serializer.fromJson<String>(
        json['dartResolverScript'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'scenePartId': serializer.toJson<int>(scenePartId),
      'dartResolverScript': serializer.toJson<String>(dartResolverScript),
    };
  }

  ScenePartResolver copyWith({int? scenePartId, String? dartResolverScript}) =>
      ScenePartResolver(
        scenePartId: scenePartId ?? this.scenePartId,
        dartResolverScript: dartResolverScript ?? this.dartResolverScript,
      );
  ScenePartResolver copyWithCompanion(ScenePartResolversCompanion data) {
    return ScenePartResolver(
      scenePartId: data.scenePartId.present
          ? data.scenePartId.value
          : this.scenePartId,
      dartResolverScript: data.dartResolverScript.present
          ? data.dartResolverScript.value
          : this.dartResolverScript,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScenePartResolver(')
          ..write('scenePartId: $scenePartId, ')
          ..write('dartResolverScript: $dartResolverScript')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(scenePartId, dartResolverScript);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScenePartResolver &&
          other.scenePartId == this.scenePartId &&
          other.dartResolverScript == this.dartResolverScript);
}

class ScenePartResolversCompanion extends UpdateCompanion<ScenePartResolver> {
  final Value<int> scenePartId;
  final Value<String> dartResolverScript;
  const ScenePartResolversCompanion({
    this.scenePartId = const Value.absent(),
    this.dartResolverScript = const Value.absent(),
  });
  ScenePartResolversCompanion.insert({
    this.scenePartId = const Value.absent(),
    required String dartResolverScript,
  }) : dartResolverScript = Value(dartResolverScript);
  static Insertable<ScenePartResolver> custom({
    Expression<int>? scenePartId,
    Expression<String>? dartResolverScript,
  }) {
    return RawValuesInsertable({
      if (scenePartId != null) 'scene_part_id': scenePartId,
      if (dartResolverScript != null)
        'dart_resolver_script': dartResolverScript,
    });
  }

  ScenePartResolversCompanion copyWith({
    Value<int>? scenePartId,
    Value<String>? dartResolverScript,
  }) {
    return ScenePartResolversCompanion(
      scenePartId: scenePartId ?? this.scenePartId,
      dartResolverScript: dartResolverScript ?? this.dartResolverScript,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (scenePartId.present) {
      map['scene_part_id'] = Variable<int>(scenePartId.value);
    }
    if (dartResolverScript.present) {
      map['dart_resolver_script'] = Variable<String>(dartResolverScript.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScenePartResolversCompanion(')
          ..write('scenePartId: $scenePartId, ')
          ..write('dartResolverScript: $dartResolverScript')
          ..write(')'))
        .toString();
  }
}

class $CustomScenePartsTable extends CustomSceneParts
    with TableInfo<$CustomScenePartsTable, CustomScenePart> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomScenePartsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _scenePartIdMeta = const VerificationMeta(
    'scenePartId',
  );
  @override
  late final GeneratedColumn<int> scenePartId = GeneratedColumn<int>(
    'scene_part_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES scene_parts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [scenePartId, eventId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_scene_parts';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomScenePart> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('scene_part_id')) {
      context.handle(
        _scenePartIdMeta,
        scenePartId.isAcceptableOrUnknown(
          data['scene_part_id']!,
          _scenePartIdMeta,
        ),
      );
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {scenePartId};
  @override
  CustomScenePart map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomScenePart(
      scenePartId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scene_part_id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
    );
  }

  @override
  $CustomScenePartsTable createAlias(String alias) {
    return $CustomScenePartsTable(attachedDatabase, alias);
  }
}

class CustomScenePart extends DataClass implements Insertable<CustomScenePart> {
  final int scenePartId;
  final String eventId;
  const CustomScenePart({required this.scenePartId, required this.eventId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['scene_part_id'] = Variable<int>(scenePartId);
    map['event_id'] = Variable<String>(eventId);
    return map;
  }

  CustomScenePartsCompanion toCompanion(bool nullToAbsent) {
    return CustomScenePartsCompanion(
      scenePartId: Value(scenePartId),
      eventId: Value(eventId),
    );
  }

  factory CustomScenePart.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomScenePart(
      scenePartId: serializer.fromJson<int>(json['scenePartId']),
      eventId: serializer.fromJson<String>(json['eventId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'scenePartId': serializer.toJson<int>(scenePartId),
      'eventId': serializer.toJson<String>(eventId),
    };
  }

  CustomScenePart copyWith({int? scenePartId, String? eventId}) =>
      CustomScenePart(
        scenePartId: scenePartId ?? this.scenePartId,
        eventId: eventId ?? this.eventId,
      );
  CustomScenePart copyWithCompanion(CustomScenePartsCompanion data) {
    return CustomScenePart(
      scenePartId: data.scenePartId.present
          ? data.scenePartId.value
          : this.scenePartId,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomScenePart(')
          ..write('scenePartId: $scenePartId, ')
          ..write('eventId: $eventId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(scenePartId, eventId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomScenePart &&
          other.scenePartId == this.scenePartId &&
          other.eventId == this.eventId);
}

class CustomScenePartsCompanion extends UpdateCompanion<CustomScenePart> {
  final Value<int> scenePartId;
  final Value<String> eventId;
  const CustomScenePartsCompanion({
    this.scenePartId = const Value.absent(),
    this.eventId = const Value.absent(),
  });
  CustomScenePartsCompanion.insert({
    this.scenePartId = const Value.absent(),
    required String eventId,
  }) : eventId = Value(eventId);
  static Insertable<CustomScenePart> custom({
    Expression<int>? scenePartId,
    Expression<String>? eventId,
  }) {
    return RawValuesInsertable({
      if (scenePartId != null) 'scene_part_id': scenePartId,
      if (eventId != null) 'event_id': eventId,
    });
  }

  CustomScenePartsCompanion copyWith({
    Value<int>? scenePartId,
    Value<String>? eventId,
  }) {
    return CustomScenePartsCompanion(
      scenePartId: scenePartId ?? this.scenePartId,
      eventId: eventId ?? this.eventId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (scenePartId.present) {
      map['scene_part_id'] = Variable<int>(scenePartId.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomScenePartsCompanion(')
          ..write('scenePartId: $scenePartId, ')
          ..write('eventId: $eventId')
          ..write(')'))
        .toString();
  }
}

class SceneTimelineViewData extends DataClass {
  final int id;
  final int sceneId;
  final double order;
  final String partType;
  final int? backgroundId;
  final String? dartResolverScript;
  final String? eventId;
  const SceneTimelineViewData({
    required this.id,
    required this.sceneId,
    required this.order,
    required this.partType,
    this.backgroundId,
    this.dartResolverScript,
    this.eventId,
  });
  factory SceneTimelineViewData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SceneTimelineViewData(
      id: serializer.fromJson<int>(json['id']),
      sceneId: serializer.fromJson<int>(json['scene_id']),
      order: serializer.fromJson<double>(json['order']),
      partType: serializer.fromJson<String>(json['part_type']),
      backgroundId: serializer.fromJson<int?>(json['background_id']),
      dartResolverScript: serializer.fromJson<String?>(
        json['dart_resolver_script'],
      ),
      eventId: serializer.fromJson<String?>(json['event_id']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'scene_id': serializer.toJson<int>(sceneId),
      'order': serializer.toJson<double>(order),
      'part_type': serializer.toJson<String>(partType),
      'background_id': serializer.toJson<int?>(backgroundId),
      'dart_resolver_script': serializer.toJson<String?>(dartResolverScript),
      'event_id': serializer.toJson<String?>(eventId),
    };
  }

  SceneTimelineViewData copyWith({
    int? id,
    int? sceneId,
    double? order,
    String? partType,
    Value<int?> backgroundId = const Value.absent(),
    Value<String?> dartResolverScript = const Value.absent(),
    Value<String?> eventId = const Value.absent(),
  }) => SceneTimelineViewData(
    id: id ?? this.id,
    sceneId: sceneId ?? this.sceneId,
    order: order ?? this.order,
    partType: partType ?? this.partType,
    backgroundId: backgroundId.present ? backgroundId.value : this.backgroundId,
    dartResolverScript: dartResolverScript.present
        ? dartResolverScript.value
        : this.dartResolverScript,
    eventId: eventId.present ? eventId.value : this.eventId,
  );
  @override
  String toString() {
    return (StringBuffer('SceneTimelineViewData(')
          ..write('id: $id, ')
          ..write('sceneId: $sceneId, ')
          ..write('order: $order, ')
          ..write('partType: $partType, ')
          ..write('backgroundId: $backgroundId, ')
          ..write('dartResolverScript: $dartResolverScript, ')
          ..write('eventId: $eventId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sceneId,
    order,
    partType,
    backgroundId,
    dartResolverScript,
    eventId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SceneTimelineViewData &&
          other.id == this.id &&
          other.sceneId == this.sceneId &&
          other.order == this.order &&
          other.partType == this.partType &&
          other.backgroundId == this.backgroundId &&
          other.dartResolverScript == this.dartResolverScript &&
          other.eventId == this.eventId);
}

class SceneTimelineView
    extends ViewInfo<SceneTimelineView, SceneTimelineViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$SceneGroup attachedDatabase;
  SceneTimelineView(this.attachedDatabase, [this._alias]);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sceneId,
    order,
    partType,
    backgroundId,
    dartResolverScript,
    eventId,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'scene_timeline_view';
  @override
  Map<SqlDialect, String> get createViewStatements => {
    SqlDialect.sqlite:
        'CREATE VIEW scene_timeline_view AS SELECT scene_parts.id, scene_parts.scene_id, scene_parts."order", scene_parts.part_type, frames.background_id, scene_part_resolvers.dart_resolver_script, custom_scene_parts.event_id FROM scene_parts LEFT OUTER JOIN frames ON frames.scene_part_id = scene_parts.id LEFT OUTER JOIN scene_part_resolvers ON scene_part_resolvers.scene_part_id = scene_parts.id LEFT OUTER JOIN custom_scene_parts ON custom_scene_parts.scene_part_id = scene_parts.id',
  };
  @override
  SceneTimelineView get asDslTable => this;
  @override
  SceneTimelineViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SceneTimelineViewData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sceneId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scene_id'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}order'],
      )!,
      partType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}part_type'],
      )!,
      backgroundId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}background_id'],
      ),
      dartResolverScript: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dart_resolver_script'],
      ),
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      ),
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<int> sceneId = GeneratedColumn<int>(
    'scene_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<double> order = GeneratedColumn<double>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.double,
  );
  late final GeneratedColumn<String> partType = GeneratedColumn<String>(
    'part_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<int> backgroundId = GeneratedColumn<int>(
    'background_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<String> dartResolverScript =
      GeneratedColumn<String>(
        'dart_resolver_script',
        aliasedName,
        true,
        type: DriftSqlType.string,
      );
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
  );
  @override
  SceneTimelineView createAlias(String alias) {
    return SceneTimelineView(attachedDatabase, alias);
  }

  @override
  Query? get query => null;
  @override
  Set<String> get readTables => const {
    'scene_parts',
    'frames',
    'scene_part_resolvers',
    'custom_scene_parts',
  };
}

class $ActorsTable extends Actors with TableInfo<$ActorsTable, Actor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'actors';
  @override
  VerificationContext validateIntegrity(
    Insertable<Actor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Actor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Actor(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $ActorsTable createAlias(String alias) {
    return $ActorsTable(attachedDatabase, alias);
  }
}

class Actor extends DataClass implements Insertable<Actor>, Group {
  final int id;
  final String name;
  const Actor({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  ActorsCompanion toCompanion(bool nullToAbsent) {
    return ActorsCompanion(id: Value(id), name: Value(name));
  }

  factory Actor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Actor(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Actor copyWith({int? id, String? name}) =>
      Actor(id: id ?? this.id, name: name ?? this.name);
  Actor copyWithCompanion(ActorsCompanion data) {
    return Actor(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Actor(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Actor && other.id == this.id && other.name == this.name);
}

class ActorsCompanion extends UpdateCompanion<Actor> {
  final Value<int> id;
  final Value<String> name;
  const ActorsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  ActorsCompanion.insert({this.id = const Value.absent(), required String name})
    : name = Value(name);
  static Insertable<Actor> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  ActorsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return ActorsCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActorsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $PoseMetadatasTable extends PoseMetadatas
    with TableInfo<$PoseMetadatasTable, PoseMetadata> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PoseMetadatasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES actors (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, groupId, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pose_metadatas';
  @override
  VerificationContext validateIntegrity(
    Insertable<PoseMetadata> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PoseMetadata map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PoseMetadata(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $PoseMetadatasTable createAlias(String alias) {
    return $PoseMetadatasTable(attachedDatabase, alias);
  }
}

class PoseMetadata extends DataClass
    implements Insertable<PoseMetadata>, ImageMetadata {
  final int id;
  final int groupId;
  final String name;
  const PoseMetadata({
    required this.id,
    required this.groupId,
    required this.name,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['group_id'] = Variable<int>(groupId);
    map['name'] = Variable<String>(name);
    return map;
  }

  PoseMetadatasCompanion toCompanion(bool nullToAbsent) {
    return PoseMetadatasCompanion(
      id: Value(id),
      groupId: Value(groupId),
      name: Value(name),
    );
  }

  factory PoseMetadata.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PoseMetadata(
      id: serializer.fromJson<int>(json['id']),
      groupId: serializer.fromJson<int>(json['groupId']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'groupId': serializer.toJson<int>(groupId),
      'name': serializer.toJson<String>(name),
    };
  }

  PoseMetadata copyWith({int? id, int? groupId, String? name}) => PoseMetadata(
    id: id ?? this.id,
    groupId: groupId ?? this.groupId,
    name: name ?? this.name,
  );
  PoseMetadata copyWithCompanion(PoseMetadatasCompanion data) {
    return PoseMetadata(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PoseMetadata(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, groupId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PoseMetadata &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.name == this.name);
}

class PoseMetadatasCompanion extends UpdateCompanion<PoseMetadata> {
  final Value<int> id;
  final Value<int> groupId;
  final Value<String> name;
  const PoseMetadatasCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.name = const Value.absent(),
  });
  PoseMetadatasCompanion.insert({
    this.id = const Value.absent(),
    required int groupId,
    required String name,
  }) : groupId = Value(groupId),
       name = Value(name);
  static Insertable<PoseMetadata> custom({
    Expression<int>? id,
    Expression<int>? groupId,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (name != null) 'name': name,
    });
  }

  PoseMetadatasCompanion copyWith({
    Value<int>? id,
    Value<int>? groupId,
    Value<String>? name,
  }) {
    return PoseMetadatasCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<int>(groupId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PoseMetadatasCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $FramePosesTable extends FramePoses
    with TableInfo<$FramePosesTable, FramePose> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FramePosesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _frameScenePartIdMeta = const VerificationMeta(
    'frameScenePartId',
  );
  @override
  late final GeneratedColumn<int> frameScenePartId = GeneratedColumn<int>(
    'frame_scene_part_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES frames (scene_part_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _poseIdMeta = const VerificationMeta('poseId');
  @override
  late final GeneratedColumn<int> poseId = GeneratedColumn<int>(
    'pose_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pose_metadatas (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<double> order = GeneratedColumn<double>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, frameScenePartId, poseId, order];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'frame_poses';
  @override
  VerificationContext validateIntegrity(
    Insertable<FramePose> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('frame_scene_part_id')) {
      context.handle(
        _frameScenePartIdMeta,
        frameScenePartId.isAcceptableOrUnknown(
          data['frame_scene_part_id']!,
          _frameScenePartIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_frameScenePartIdMeta);
    }
    if (data.containsKey('pose_id')) {
      context.handle(
        _poseIdMeta,
        poseId.isAcceptableOrUnknown(data['pose_id']!, _poseIdMeta),
      );
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FramePose map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FramePose(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      frameScenePartId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}frame_scene_part_id'],
      )!,
      poseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pose_id'],
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}order'],
      )!,
    );
  }

  @override
  $FramePosesTable createAlias(String alias) {
    return $FramePosesTable(attachedDatabase, alias);
  }
}

class FramePose extends DataClass implements Insertable<FramePose> {
  final int id;
  final int frameScenePartId;
  final int? poseId;
  final double order;
  const FramePose({
    required this.id,
    required this.frameScenePartId,
    this.poseId,
    required this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['frame_scene_part_id'] = Variable<int>(frameScenePartId);
    if (!nullToAbsent || poseId != null) {
      map['pose_id'] = Variable<int>(poseId);
    }
    map['order'] = Variable<double>(order);
    return map;
  }

  FramePosesCompanion toCompanion(bool nullToAbsent) {
    return FramePosesCompanion(
      id: Value(id),
      frameScenePartId: Value(frameScenePartId),
      poseId: poseId == null && nullToAbsent
          ? const Value.absent()
          : Value(poseId),
      order: Value(order),
    );
  }

  factory FramePose.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FramePose(
      id: serializer.fromJson<int>(json['id']),
      frameScenePartId: serializer.fromJson<int>(json['frameScenePartId']),
      poseId: serializer.fromJson<int?>(json['poseId']),
      order: serializer.fromJson<double>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'frameScenePartId': serializer.toJson<int>(frameScenePartId),
      'poseId': serializer.toJson<int?>(poseId),
      'order': serializer.toJson<double>(order),
    };
  }

  FramePose copyWith({
    int? id,
    int? frameScenePartId,
    Value<int?> poseId = const Value.absent(),
    double? order,
  }) => FramePose(
    id: id ?? this.id,
    frameScenePartId: frameScenePartId ?? this.frameScenePartId,
    poseId: poseId.present ? poseId.value : this.poseId,
    order: order ?? this.order,
  );
  FramePose copyWithCompanion(FramePosesCompanion data) {
    return FramePose(
      id: data.id.present ? data.id.value : this.id,
      frameScenePartId: data.frameScenePartId.present
          ? data.frameScenePartId.value
          : this.frameScenePartId,
      poseId: data.poseId.present ? data.poseId.value : this.poseId,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FramePose(')
          ..write('id: $id, ')
          ..write('frameScenePartId: $frameScenePartId, ')
          ..write('poseId: $poseId, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, frameScenePartId, poseId, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FramePose &&
          other.id == this.id &&
          other.frameScenePartId == this.frameScenePartId &&
          other.poseId == this.poseId &&
          other.order == this.order);
}

class FramePosesCompanion extends UpdateCompanion<FramePose> {
  final Value<int> id;
  final Value<int> frameScenePartId;
  final Value<int?> poseId;
  final Value<double> order;
  const FramePosesCompanion({
    this.id = const Value.absent(),
    this.frameScenePartId = const Value.absent(),
    this.poseId = const Value.absent(),
    this.order = const Value.absent(),
  });
  FramePosesCompanion.insert({
    this.id = const Value.absent(),
    required int frameScenePartId,
    this.poseId = const Value.absent(),
    required double order,
  }) : frameScenePartId = Value(frameScenePartId),
       order = Value(order);
  static Insertable<FramePose> custom({
    Expression<int>? id,
    Expression<int>? frameScenePartId,
    Expression<int>? poseId,
    Expression<double>? order,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (frameScenePartId != null) 'frame_scene_part_id': frameScenePartId,
      if (poseId != null) 'pose_id': poseId,
      if (order != null) 'order': order,
    });
  }

  FramePosesCompanion copyWith({
    Value<int>? id,
    Value<int>? frameScenePartId,
    Value<int?>? poseId,
    Value<double>? order,
  }) {
    return FramePosesCompanion(
      id: id ?? this.id,
      frameScenePartId: frameScenePartId ?? this.frameScenePartId,
      poseId: poseId ?? this.poseId,
      order: order ?? this.order,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (frameScenePartId.present) {
      map['frame_scene_part_id'] = Variable<int>(frameScenePartId.value);
    }
    if (poseId.present) {
      map['pose_id'] = Variable<int>(poseId.value);
    }
    if (order.present) {
      map['order'] = Variable<double>(order.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FramePosesCompanion(')
          ..write('id: $id, ')
          ..write('frameScenePartId: $frameScenePartId, ')
          ..write('poseId: $poseId, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }
}

class FramePosesViewData extends DataClass {
  final int id;
  final int frameScenePartId;
  final int? poseId;
  final double order;
  final int? groupId;
  final String? name;
  const FramePosesViewData({
    required this.id,
    required this.frameScenePartId,
    this.poseId,
    required this.order,
    this.groupId,
    this.name,
  });
  factory FramePosesViewData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FramePosesViewData(
      id: serializer.fromJson<int>(json['id']),
      frameScenePartId: serializer.fromJson<int>(json['frame_scene_part_id']),
      poseId: serializer.fromJson<int?>(json['pose_id']),
      order: serializer.fromJson<double>(json['order']),
      groupId: serializer.fromJson<int?>(json['group_id']),
      name: serializer.fromJson<String?>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'frame_scene_part_id': serializer.toJson<int>(frameScenePartId),
      'pose_id': serializer.toJson<int?>(poseId),
      'order': serializer.toJson<double>(order),
      'group_id': serializer.toJson<int?>(groupId),
      'name': serializer.toJson<String?>(name),
    };
  }

  FramePosesViewData copyWith({
    int? id,
    int? frameScenePartId,
    Value<int?> poseId = const Value.absent(),
    double? order,
    Value<int?> groupId = const Value.absent(),
    Value<String?> name = const Value.absent(),
  }) => FramePosesViewData(
    id: id ?? this.id,
    frameScenePartId: frameScenePartId ?? this.frameScenePartId,
    poseId: poseId.present ? poseId.value : this.poseId,
    order: order ?? this.order,
    groupId: groupId.present ? groupId.value : this.groupId,
    name: name.present ? name.value : this.name,
  );
  @override
  String toString() {
    return (StringBuffer('FramePosesViewData(')
          ..write('id: $id, ')
          ..write('frameScenePartId: $frameScenePartId, ')
          ..write('poseId: $poseId, ')
          ..write('order: $order, ')
          ..write('groupId: $groupId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, frameScenePartId, poseId, order, groupId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FramePosesViewData &&
          other.id == this.id &&
          other.frameScenePartId == this.frameScenePartId &&
          other.poseId == this.poseId &&
          other.order == this.order &&
          other.groupId == this.groupId &&
          other.name == this.name);
}

class FramePosesView extends ViewInfo<FramePosesView, FramePosesViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$SceneGroup attachedDatabase;
  FramePosesView(this.attachedDatabase, [this._alias]);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    frameScenePartId,
    poseId,
    order,
    groupId,
    name,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'frame_poses_view';
  @override
  Map<SqlDialect, String> get createViewStatements => {
    SqlDialect.sqlite:
        'CREATE VIEW frame_poses_view AS SELECT frame_poses.id, frame_poses.frame_scene_part_id, frame_poses.pose_id, frame_poses."order", pose_metadatas.group_id, pose_metadatas.name FROM frame_poses LEFT OUTER JOIN pose_metadatas ON pose_metadatas.id = frame_poses.pose_id',
  };
  @override
  FramePosesView get asDslTable => this;
  @override
  FramePosesViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FramePosesViewData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      frameScenePartId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}frame_scene_part_id'],
      )!,
      poseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pose_id'],
      ),
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}order'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}group_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<int> frameScenePartId = GeneratedColumn<int>(
    'frame_scene_part_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<int> poseId = GeneratedColumn<int>(
    'pose_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<double> order = GeneratedColumn<double>(
    'order',
    aliasedName,
    false,
    type: DriftSqlType.double,
  );
  late final GeneratedColumn<int> groupId = GeneratedColumn<int>(
    'group_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
  );
  @override
  FramePosesView createAlias(String alias) {
    return FramePosesView(attachedDatabase, alias);
  }

  @override
  Query? get query => null;
  @override
  Set<String> get readTables => const {'frame_poses', 'pose_metadatas'};
}

class $ChoicesTable extends Choices with TableInfo<$ChoicesTable, Choice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'choices';
  @override
  VerificationContext validateIntegrity(
    Insertable<Choice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Choice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Choice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $ChoicesTable createAlias(String alias) {
    return $ChoicesTable(attachedDatabase, alias);
  }
}

class Choice extends DataClass implements Insertable<Choice> {
  final int id;
  final String name;
  const Choice({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  ChoicesCompanion toCompanion(bool nullToAbsent) {
    return ChoicesCompanion(id: Value(id), name: Value(name));
  }

  factory Choice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Choice(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Choice copyWith({int? id, String? name}) =>
      Choice(id: id ?? this.id, name: name ?? this.name);
  Choice copyWithCompanion(ChoicesCompanion data) {
    return Choice(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Choice(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Choice && other.id == this.id && other.name == this.name);
}

class ChoicesCompanion extends UpdateCompanion<Choice> {
  final Value<int> id;
  final Value<String> name;
  const ChoicesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  ChoicesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Choice> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  ChoicesCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return ChoicesCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChoicesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $FrameChoicesTable extends FrameChoices
    with TableInfo<$FrameChoicesTable, FrameChoice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FrameChoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _frameScenePartIdMeta = const VerificationMeta(
    'frameScenePartId',
  );
  @override
  late final GeneratedColumn<int> frameScenePartId = GeneratedColumn<int>(
    'frame_scene_part_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES frames (scene_part_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _choiceIdMeta = const VerificationMeta(
    'choiceId',
  );
  @override
  late final GeneratedColumn<int> choiceId = GeneratedColumn<int>(
    'choice_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES choices (id) ON DELETE SET NULL',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [frameScenePartId, choiceId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'frame_choices';
  @override
  VerificationContext validateIntegrity(
    Insertable<FrameChoice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('frame_scene_part_id')) {
      context.handle(
        _frameScenePartIdMeta,
        frameScenePartId.isAcceptableOrUnknown(
          data['frame_scene_part_id']!,
          _frameScenePartIdMeta,
        ),
      );
    }
    if (data.containsKey('choice_id')) {
      context.handle(
        _choiceIdMeta,
        choiceId.isAcceptableOrUnknown(data['choice_id']!, _choiceIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {frameScenePartId};
  @override
  FrameChoice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FrameChoice(
      frameScenePartId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}frame_scene_part_id'],
      )!,
      choiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}choice_id'],
      ),
    );
  }

  @override
  $FrameChoicesTable createAlias(String alias) {
    return $FrameChoicesTable(attachedDatabase, alias);
  }
}

class FrameChoice extends DataClass implements Insertable<FrameChoice> {
  final int frameScenePartId;
  final int? choiceId;
  const FrameChoice({required this.frameScenePartId, this.choiceId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['frame_scene_part_id'] = Variable<int>(frameScenePartId);
    if (!nullToAbsent || choiceId != null) {
      map['choice_id'] = Variable<int>(choiceId);
    }
    return map;
  }

  FrameChoicesCompanion toCompanion(bool nullToAbsent) {
    return FrameChoicesCompanion(
      frameScenePartId: Value(frameScenePartId),
      choiceId: choiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(choiceId),
    );
  }

  factory FrameChoice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FrameChoice(
      frameScenePartId: serializer.fromJson<int>(json['frameScenePartId']),
      choiceId: serializer.fromJson<int?>(json['choiceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'frameScenePartId': serializer.toJson<int>(frameScenePartId),
      'choiceId': serializer.toJson<int?>(choiceId),
    };
  }

  FrameChoice copyWith({
    int? frameScenePartId,
    Value<int?> choiceId = const Value.absent(),
  }) => FrameChoice(
    frameScenePartId: frameScenePartId ?? this.frameScenePartId,
    choiceId: choiceId.present ? choiceId.value : this.choiceId,
  );
  FrameChoice copyWithCompanion(FrameChoicesCompanion data) {
    return FrameChoice(
      frameScenePartId: data.frameScenePartId.present
          ? data.frameScenePartId.value
          : this.frameScenePartId,
      choiceId: data.choiceId.present ? data.choiceId.value : this.choiceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FrameChoice(')
          ..write('frameScenePartId: $frameScenePartId, ')
          ..write('choiceId: $choiceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(frameScenePartId, choiceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FrameChoice &&
          other.frameScenePartId == this.frameScenePartId &&
          other.choiceId == this.choiceId);
}

class FrameChoicesCompanion extends UpdateCompanion<FrameChoice> {
  final Value<int> frameScenePartId;
  final Value<int?> choiceId;
  const FrameChoicesCompanion({
    this.frameScenePartId = const Value.absent(),
    this.choiceId = const Value.absent(),
  });
  FrameChoicesCompanion.insert({
    this.frameScenePartId = const Value.absent(),
    this.choiceId = const Value.absent(),
  });
  static Insertable<FrameChoice> custom({
    Expression<int>? frameScenePartId,
    Expression<int>? choiceId,
  }) {
    return RawValuesInsertable({
      if (frameScenePartId != null) 'frame_scene_part_id': frameScenePartId,
      if (choiceId != null) 'choice_id': choiceId,
    });
  }

  FrameChoicesCompanion copyWith({
    Value<int>? frameScenePartId,
    Value<int?>? choiceId,
  }) {
    return FrameChoicesCompanion(
      frameScenePartId: frameScenePartId ?? this.frameScenePartId,
      choiceId: choiceId ?? this.choiceId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (frameScenePartId.present) {
      map['frame_scene_part_id'] = Variable<int>(frameScenePartId.value);
    }
    if (choiceId.present) {
      map['choice_id'] = Variable<int>(choiceId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FrameChoicesCompanion(')
          ..write('frameScenePartId: $frameScenePartId, ')
          ..write('choiceId: $choiceId')
          ..write(')'))
        .toString();
  }
}

class FrameChoicesViewData extends DataClass {
  final int frameScenePartId;
  final int? choiceId;
  final String? name;
  const FrameChoicesViewData({
    required this.frameScenePartId,
    this.choiceId,
    this.name,
  });
  factory FrameChoicesViewData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FrameChoicesViewData(
      frameScenePartId: serializer.fromJson<int>(json['frame_scene_part_id']),
      choiceId: serializer.fromJson<int?>(json['choice_id']),
      name: serializer.fromJson<String?>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'frame_scene_part_id': serializer.toJson<int>(frameScenePartId),
      'choice_id': serializer.toJson<int?>(choiceId),
      'name': serializer.toJson<String?>(name),
    };
  }

  FrameChoicesViewData copyWith({
    int? frameScenePartId,
    Value<int?> choiceId = const Value.absent(),
    Value<String?> name = const Value.absent(),
  }) => FrameChoicesViewData(
    frameScenePartId: frameScenePartId ?? this.frameScenePartId,
    choiceId: choiceId.present ? choiceId.value : this.choiceId,
    name: name.present ? name.value : this.name,
  );
  @override
  String toString() {
    return (StringBuffer('FrameChoicesViewData(')
          ..write('frameScenePartId: $frameScenePartId, ')
          ..write('choiceId: $choiceId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(frameScenePartId, choiceId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FrameChoicesViewData &&
          other.frameScenePartId == this.frameScenePartId &&
          other.choiceId == this.choiceId &&
          other.name == this.name);
}

class FrameChoicesView extends ViewInfo<FrameChoicesView, FrameChoicesViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$SceneGroup attachedDatabase;
  FrameChoicesView(this.attachedDatabase, [this._alias]);
  @override
  List<GeneratedColumn> get $columns => [frameScenePartId, choiceId, name];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'frame_choices_view';
  @override
  Map<SqlDialect, String> get createViewStatements => {
    SqlDialect.sqlite:
        'CREATE VIEW frame_choices_view AS SELECT frame_choices.frame_scene_part_id, frame_choices.choice_id, choices.name FROM frame_choices LEFT OUTER JOIN choices ON choices.id = frame_choices.choice_id',
  };
  @override
  FrameChoicesView get asDslTable => this;
  @override
  FrameChoicesViewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FrameChoicesViewData(
      frameScenePartId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}frame_scene_part_id'],
      )!,
      choiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}choice_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
    );
  }

  late final GeneratedColumn<int> frameScenePartId = GeneratedColumn<int>(
    'frame_scene_part_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<int> choiceId = GeneratedColumn<int>(
    'choice_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
  );
  @override
  FrameChoicesView createAlias(String alias) {
    return FrameChoicesView(attachedDatabase, alias);
  }

  @override
  Query? get query => null;
  @override
  Set<String> get readTables => const {'frame_choices', 'choices'};
}

class $BackgroundImagesTable extends BackgroundImages
    with TableInfo<$BackgroundImagesTable, BackgroundImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackgroundImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _metadataIdMeta = const VerificationMeta(
    'metadataId',
  );
  @override
  late final GeneratedColumn<int> metadataId = GeneratedColumn<int>(
    'metadata_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES background_metadatas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _imageDataMeta = const VerificationMeta(
    'imageData',
  );
  @override
  late final GeneratedColumn<Uint8List> imageData = GeneratedColumn<Uint8List>(
    'image_data',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [metadataId, imageData];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'background_images';
  @override
  VerificationContext validateIntegrity(
    Insertable<BackgroundImage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('metadata_id')) {
      context.handle(
        _metadataIdMeta,
        metadataId.isAcceptableOrUnknown(data['metadata_id']!, _metadataIdMeta),
      );
    }
    if (data.containsKey('image_data')) {
      context.handle(
        _imageDataMeta,
        imageData.isAcceptableOrUnknown(data['image_data']!, _imageDataMeta),
      );
    } else if (isInserting) {
      context.missing(_imageDataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {metadataId};
  @override
  BackgroundImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackgroundImage(
      metadataId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}metadata_id'],
      )!,
      imageData: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}image_data'],
      )!,
    );
  }

  @override
  $BackgroundImagesTable createAlias(String alias) {
    return $BackgroundImagesTable(attachedDatabase, alias);
  }
}

class BackgroundImage extends DataClass
    implements Insertable<BackgroundImage>, ImageData {
  final int metadataId;
  final Uint8List imageData;
  const BackgroundImage({required this.metadataId, required this.imageData});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['metadata_id'] = Variable<int>(metadataId);
    map['image_data'] = Variable<Uint8List>(imageData);
    return map;
  }

  BackgroundImagesCompanion toCompanion(bool nullToAbsent) {
    return BackgroundImagesCompanion(
      metadataId: Value(metadataId),
      imageData: Value(imageData),
    );
  }

  factory BackgroundImage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackgroundImage(
      metadataId: serializer.fromJson<int>(json['metadataId']),
      imageData: serializer.fromJson<Uint8List>(json['imageData']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'metadataId': serializer.toJson<int>(metadataId),
      'imageData': serializer.toJson<Uint8List>(imageData),
    };
  }

  BackgroundImage copyWith({int? metadataId, Uint8List? imageData}) =>
      BackgroundImage(
        metadataId: metadataId ?? this.metadataId,
        imageData: imageData ?? this.imageData,
      );
  BackgroundImage copyWithCompanion(BackgroundImagesCompanion data) {
    return BackgroundImage(
      metadataId: data.metadataId.present
          ? data.metadataId.value
          : this.metadataId,
      imageData: data.imageData.present ? data.imageData.value : this.imageData,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackgroundImage(')
          ..write('metadataId: $metadataId, ')
          ..write('imageData: $imageData')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(metadataId, $driftBlobEquality.hash(imageData));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackgroundImage &&
          other.metadataId == this.metadataId &&
          $driftBlobEquality.equals(other.imageData, this.imageData));
}

class BackgroundImagesCompanion extends UpdateCompanion<BackgroundImage> {
  final Value<int> metadataId;
  final Value<Uint8List> imageData;
  const BackgroundImagesCompanion({
    this.metadataId = const Value.absent(),
    this.imageData = const Value.absent(),
  });
  BackgroundImagesCompanion.insert({
    this.metadataId = const Value.absent(),
    required Uint8List imageData,
  }) : imageData = Value(imageData);
  static Insertable<BackgroundImage> custom({
    Expression<int>? metadataId,
    Expression<Uint8List>? imageData,
  }) {
    return RawValuesInsertable({
      if (metadataId != null) 'metadata_id': metadataId,
      if (imageData != null) 'image_data': imageData,
    });
  }

  BackgroundImagesCompanion copyWith({
    Value<int>? metadataId,
    Value<Uint8List>? imageData,
  }) {
    return BackgroundImagesCompanion(
      metadataId: metadataId ?? this.metadataId,
      imageData: imageData ?? this.imageData,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (metadataId.present) {
      map['metadata_id'] = Variable<int>(metadataId.value);
    }
    if (imageData.present) {
      map['image_data'] = Variable<Uint8List>(imageData.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackgroundImagesCompanion(')
          ..write('metadataId: $metadataId, ')
          ..write('imageData: $imageData')
          ..write(')'))
        .toString();
  }
}

class $PoseImagesTable extends PoseImages
    with TableInfo<$PoseImagesTable, PoseImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PoseImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _metadataIdMeta = const VerificationMeta(
    'metadataId',
  );
  @override
  late final GeneratedColumn<int> metadataId = GeneratedColumn<int>(
    'metadata_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pose_metadatas (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _imageDataMeta = const VerificationMeta(
    'imageData',
  );
  @override
  late final GeneratedColumn<Uint8List> imageData = GeneratedColumn<Uint8List>(
    'image_data',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [metadataId, imageData];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pose_images';
  @override
  VerificationContext validateIntegrity(
    Insertable<PoseImage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('metadata_id')) {
      context.handle(
        _metadataIdMeta,
        metadataId.isAcceptableOrUnknown(data['metadata_id']!, _metadataIdMeta),
      );
    }
    if (data.containsKey('image_data')) {
      context.handle(
        _imageDataMeta,
        imageData.isAcceptableOrUnknown(data['image_data']!, _imageDataMeta),
      );
    } else if (isInserting) {
      context.missing(_imageDataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {metadataId};
  @override
  PoseImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PoseImage(
      metadataId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}metadata_id'],
      )!,
      imageData: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}image_data'],
      )!,
    );
  }

  @override
  $PoseImagesTable createAlias(String alias) {
    return $PoseImagesTable(attachedDatabase, alias);
  }
}

class PoseImage extends DataClass implements Insertable<PoseImage>, ImageData {
  final int metadataId;
  final Uint8List imageData;
  const PoseImage({required this.metadataId, required this.imageData});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['metadata_id'] = Variable<int>(metadataId);
    map['image_data'] = Variable<Uint8List>(imageData);
    return map;
  }

  PoseImagesCompanion toCompanion(bool nullToAbsent) {
    return PoseImagesCompanion(
      metadataId: Value(metadataId),
      imageData: Value(imageData),
    );
  }

  factory PoseImage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PoseImage(
      metadataId: serializer.fromJson<int>(json['metadataId']),
      imageData: serializer.fromJson<Uint8List>(json['imageData']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'metadataId': serializer.toJson<int>(metadataId),
      'imageData': serializer.toJson<Uint8List>(imageData),
    };
  }

  PoseImage copyWith({int? metadataId, Uint8List? imageData}) => PoseImage(
    metadataId: metadataId ?? this.metadataId,
    imageData: imageData ?? this.imageData,
  );
  PoseImage copyWithCompanion(PoseImagesCompanion data) {
    return PoseImage(
      metadataId: data.metadataId.present
          ? data.metadataId.value
          : this.metadataId,
      imageData: data.imageData.present ? data.imageData.value : this.imageData,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PoseImage(')
          ..write('metadataId: $metadataId, ')
          ..write('imageData: $imageData')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(metadataId, $driftBlobEquality.hash(imageData));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PoseImage &&
          other.metadataId == this.metadataId &&
          $driftBlobEquality.equals(other.imageData, this.imageData));
}

class PoseImagesCompanion extends UpdateCompanion<PoseImage> {
  final Value<int> metadataId;
  final Value<Uint8List> imageData;
  const PoseImagesCompanion({
    this.metadataId = const Value.absent(),
    this.imageData = const Value.absent(),
  });
  PoseImagesCompanion.insert({
    this.metadataId = const Value.absent(),
    required Uint8List imageData,
  }) : imageData = Value(imageData);
  static Insertable<PoseImage> custom({
    Expression<int>? metadataId,
    Expression<Uint8List>? imageData,
  }) {
    return RawValuesInsertable({
      if (metadataId != null) 'metadata_id': metadataId,
      if (imageData != null) 'image_data': imageData,
    });
  }

  PoseImagesCompanion copyWith({
    Value<int>? metadataId,
    Value<Uint8List>? imageData,
  }) {
    return PoseImagesCompanion(
      metadataId: metadataId ?? this.metadataId,
      imageData: imageData ?? this.imageData,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (metadataId.present) {
      map['metadata_id'] = Variable<int>(metadataId.value);
    }
    if (imageData.present) {
      map['image_data'] = Variable<Uint8List>(imageData.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PoseImagesCompanion(')
          ..write('metadataId: $metadataId, ')
          ..write('imageData: $imageData')
          ..write(')'))
        .toString();
  }
}

class $ChoiceOptionsTable extends ChoiceOptions
    with TableInfo<$ChoiceOptionsTable, ChoiceOption> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChoiceOptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _choiceIdMeta = const VerificationMeta(
    'choiceId',
  );
  @override
  late final GeneratedColumn<int> choiceId = GeneratedColumn<int>(
    'choice_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES choices (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _isSelectedMeta = const VerificationMeta(
    'isSelected',
  );
  @override
  late final GeneratedColumn<bool> isSelected = GeneratedColumn<bool>(
    'is_selected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_selected" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, choiceId, isSelected];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'choice_options';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChoiceOption> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('choice_id')) {
      context.handle(
        _choiceIdMeta,
        choiceId.isAcceptableOrUnknown(data['choice_id']!, _choiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_choiceIdMeta);
    }
    if (data.containsKey('is_selected')) {
      context.handle(
        _isSelectedMeta,
        isSelected.isAcceptableOrUnknown(data['is_selected']!, _isSelectedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChoiceOption map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChoiceOption(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      choiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}choice_id'],
      )!,
      isSelected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_selected'],
      )!,
    );
  }

  @override
  $ChoiceOptionsTable createAlias(String alias) {
    return $ChoiceOptionsTable(attachedDatabase, alias);
  }
}

class ChoiceOption extends DataClass
    implements Insertable<ChoiceOption>, Group {
  final int id;
  final String name;
  final int choiceId;
  final bool isSelected;
  const ChoiceOption({
    required this.id,
    required this.name,
    required this.choiceId,
    required this.isSelected,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['choice_id'] = Variable<int>(choiceId);
    map['is_selected'] = Variable<bool>(isSelected);
    return map;
  }

  ChoiceOptionsCompanion toCompanion(bool nullToAbsent) {
    return ChoiceOptionsCompanion(
      id: Value(id),
      name: Value(name),
      choiceId: Value(choiceId),
      isSelected: Value(isSelected),
    );
  }

  factory ChoiceOption.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChoiceOption(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      choiceId: serializer.fromJson<int>(json['choiceId']),
      isSelected: serializer.fromJson<bool>(json['isSelected']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'choiceId': serializer.toJson<int>(choiceId),
      'isSelected': serializer.toJson<bool>(isSelected),
    };
  }

  ChoiceOption copyWith({
    int? id,
    String? name,
    int? choiceId,
    bool? isSelected,
  }) => ChoiceOption(
    id: id ?? this.id,
    name: name ?? this.name,
    choiceId: choiceId ?? this.choiceId,
    isSelected: isSelected ?? this.isSelected,
  );
  ChoiceOption copyWithCompanion(ChoiceOptionsCompanion data) {
    return ChoiceOption(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      choiceId: data.choiceId.present ? data.choiceId.value : this.choiceId,
      isSelected: data.isSelected.present
          ? data.isSelected.value
          : this.isSelected,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChoiceOption(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('choiceId: $choiceId, ')
          ..write('isSelected: $isSelected')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, choiceId, isSelected);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChoiceOption &&
          other.id == this.id &&
          other.name == this.name &&
          other.choiceId == this.choiceId &&
          other.isSelected == this.isSelected);
}

class ChoiceOptionsCompanion extends UpdateCompanion<ChoiceOption> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> choiceId;
  final Value<bool> isSelected;
  const ChoiceOptionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.choiceId = const Value.absent(),
    this.isSelected = const Value.absent(),
  });
  ChoiceOptionsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int choiceId,
    this.isSelected = const Value.absent(),
  }) : name = Value(name),
       choiceId = Value(choiceId);
  static Insertable<ChoiceOption> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? choiceId,
    Expression<bool>? isSelected,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (choiceId != null) 'choice_id': choiceId,
      if (isSelected != null) 'is_selected': isSelected,
    });
  }

  ChoiceOptionsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? choiceId,
    Value<bool>? isSelected,
  }) {
    return ChoiceOptionsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      choiceId: choiceId ?? this.choiceId,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (choiceId.present) {
      map['choice_id'] = Variable<int>(choiceId.value);
    }
    if (isSelected.present) {
      map['is_selected'] = Variable<bool>(isSelected.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChoiceOptionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('choiceId: $choiceId, ')
          ..write('isSelected: $isSelected')
          ..write(')'))
        .toString();
  }
}

class $DialogueBoxesTable extends DialogueBoxes
    with TableInfo<$DialogueBoxesTable, DialogueBox> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DialogueBoxesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _frameScenePartIdMeta = const VerificationMeta(
    'frameScenePartId',
  );
  @override
  late final GeneratedColumn<int> frameScenePartId = GeneratedColumn<int>(
    'frame_scene_part_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES frames (scene_part_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dialogueMeta = const VerificationMeta(
    'dialogue',
  );
  @override
  late final GeneratedColumn<String> dialogue = GeneratedColumn<String>(
    'dialogue',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [frameScenePartId, name, dialogue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dialogue_boxes';
  @override
  VerificationContext validateIntegrity(
    Insertable<DialogueBox> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('frame_scene_part_id')) {
      context.handle(
        _frameScenePartIdMeta,
        frameScenePartId.isAcceptableOrUnknown(
          data['frame_scene_part_id']!,
          _frameScenePartIdMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('dialogue')) {
      context.handle(
        _dialogueMeta,
        dialogue.isAcceptableOrUnknown(data['dialogue']!, _dialogueMeta),
      );
    } else if (isInserting) {
      context.missing(_dialogueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {frameScenePartId};
  @override
  DialogueBox map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DialogueBox(
      frameScenePartId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}frame_scene_part_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      dialogue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dialogue'],
      )!,
    );
  }

  @override
  $DialogueBoxesTable createAlias(String alias) {
    return $DialogueBoxesTable(attachedDatabase, alias);
  }
}

class DialogueBox extends DataClass implements Insertable<DialogueBox> {
  final int frameScenePartId;
  final String? name;
  final String dialogue;
  const DialogueBox({
    required this.frameScenePartId,
    this.name,
    required this.dialogue,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['frame_scene_part_id'] = Variable<int>(frameScenePartId);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['dialogue'] = Variable<String>(dialogue);
    return map;
  }

  DialogueBoxesCompanion toCompanion(bool nullToAbsent) {
    return DialogueBoxesCompanion(
      frameScenePartId: Value(frameScenePartId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      dialogue: Value(dialogue),
    );
  }

  factory DialogueBox.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DialogueBox(
      frameScenePartId: serializer.fromJson<int>(json['frameScenePartId']),
      name: serializer.fromJson<String?>(json['name']),
      dialogue: serializer.fromJson<String>(json['dialogue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'frameScenePartId': serializer.toJson<int>(frameScenePartId),
      'name': serializer.toJson<String?>(name),
      'dialogue': serializer.toJson<String>(dialogue),
    };
  }

  DialogueBox copyWith({
    int? frameScenePartId,
    Value<String?> name = const Value.absent(),
    String? dialogue,
  }) => DialogueBox(
    frameScenePartId: frameScenePartId ?? this.frameScenePartId,
    name: name.present ? name.value : this.name,
    dialogue: dialogue ?? this.dialogue,
  );
  DialogueBox copyWithCompanion(DialogueBoxesCompanion data) {
    return DialogueBox(
      frameScenePartId: data.frameScenePartId.present
          ? data.frameScenePartId.value
          : this.frameScenePartId,
      name: data.name.present ? data.name.value : this.name,
      dialogue: data.dialogue.present ? data.dialogue.value : this.dialogue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DialogueBox(')
          ..write('frameScenePartId: $frameScenePartId, ')
          ..write('name: $name, ')
          ..write('dialogue: $dialogue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(frameScenePartId, name, dialogue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DialogueBox &&
          other.frameScenePartId == this.frameScenePartId &&
          other.name == this.name &&
          other.dialogue == this.dialogue);
}

class DialogueBoxesCompanion extends UpdateCompanion<DialogueBox> {
  final Value<int> frameScenePartId;
  final Value<String?> name;
  final Value<String> dialogue;
  const DialogueBoxesCompanion({
    this.frameScenePartId = const Value.absent(),
    this.name = const Value.absent(),
    this.dialogue = const Value.absent(),
  });
  DialogueBoxesCompanion.insert({
    this.frameScenePartId = const Value.absent(),
    this.name = const Value.absent(),
    required String dialogue,
  }) : dialogue = Value(dialogue);
  static Insertable<DialogueBox> custom({
    Expression<int>? frameScenePartId,
    Expression<String>? name,
    Expression<String>? dialogue,
  }) {
    return RawValuesInsertable({
      if (frameScenePartId != null) 'frame_scene_part_id': frameScenePartId,
      if (name != null) 'name': name,
      if (dialogue != null) 'dialogue': dialogue,
    });
  }

  DialogueBoxesCompanion copyWith({
    Value<int>? frameScenePartId,
    Value<String?>? name,
    Value<String>? dialogue,
  }) {
    return DialogueBoxesCompanion(
      frameScenePartId: frameScenePartId ?? this.frameScenePartId,
      name: name ?? this.name,
      dialogue: dialogue ?? this.dialogue,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (frameScenePartId.present) {
      map['frame_scene_part_id'] = Variable<int>(frameScenePartId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dialogue.present) {
      map['dialogue'] = Variable<String>(dialogue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DialogueBoxesCompanion(')
          ..write('frameScenePartId: $frameScenePartId, ')
          ..write('name: $name, ')
          ..write('dialogue: $dialogue')
          ..write(')'))
        .toString();
  }
}

abstract class _$SceneGroup extends GeneratedDatabase {
  _$SceneGroup(QueryExecutor e) : super(e);
  $SceneGroupManager get managers => $SceneGroupManager(this);
  late final $ScenesTable scenes = $ScenesTable(this);
  late final $ScenePartsTable sceneParts = $ScenePartsTable(this);
  late final $PlacesTable places = $PlacesTable(this);
  late final $BackgroundMetadatasTable backgroundMetadatas =
      $BackgroundMetadatasTable(this);
  late final $FramesTable frames = $FramesTable(this);
  late final $ScenePartResolversTable scenePartResolvers =
      $ScenePartResolversTable(this);
  late final $CustomScenePartsTable customSceneParts = $CustomScenePartsTable(
    this,
  );
  late final SceneTimelineView sceneTimelineView = SceneTimelineView(this);
  late final $ActorsTable actors = $ActorsTable(this);
  late final $PoseMetadatasTable poseMetadatas = $PoseMetadatasTable(this);
  late final $FramePosesTable framePoses = $FramePosesTable(this);
  late final FramePosesView framePosesView = FramePosesView(this);
  late final $ChoicesTable choices = $ChoicesTable(this);
  late final $FrameChoicesTable frameChoices = $FrameChoicesTable(this);
  late final FrameChoicesView frameChoicesView = FrameChoicesView(this);
  late final $BackgroundImagesTable backgroundImages = $BackgroundImagesTable(
    this,
  );
  late final $PoseImagesTable poseImages = $PoseImagesTable(this);
  late final $ChoiceOptionsTable choiceOptions = $ChoiceOptionsTable(this);
  late final $DialogueBoxesTable dialogueBoxes = $DialogueBoxesTable(this);
  late final Index oneSelectedPerChoice = Index(
    'one_selected_per_choice',
    'CREATE UNIQUE INDEX IF NOT EXISTS one_selected_per_choice ON choice_options (choice_id) WHERE is_selected = 1',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    scenes,
    sceneParts,
    places,
    backgroundMetadatas,
    frames,
    scenePartResolvers,
    customSceneParts,
    sceneTimelineView,
    actors,
    poseMetadatas,
    framePoses,
    framePosesView,
    choices,
    frameChoices,
    frameChoicesView,
    backgroundImages,
    poseImages,
    choiceOptions,
    dialogueBoxes,
    oneSelectedPerChoice,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'scenes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('scene_parts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'places',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('background_metadatas', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'scene_parts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('frames', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'background_metadatas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('frames', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'scene_parts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('scene_part_resolvers', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'scene_parts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('custom_scene_parts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'actors',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pose_metadatas', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'frames',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('frame_poses', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pose_metadatas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('frame_poses', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'frames',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('frame_choices', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'choices',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('frame_choices', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'background_metadatas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('background_images', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pose_metadatas',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pose_images', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'choices',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('choice_options', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'frames',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('dialogue_boxes', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ScenesTableCreateCompanionBuilder =
    ScenesCompanion Function({Value<int> id, required String name});
typedef $$ScenesTableUpdateCompanionBuilder =
    ScenesCompanion Function({Value<int> id, Value<String> name});

final class $$ScenesTableReferences
    extends BaseReferences<_$SceneGroup, $ScenesTable, Scene> {
  $$ScenesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ScenePartsTable, List<ScenePart>>
  _scenePartsRefsTable(_$SceneGroup db) => MultiTypedResultKey.fromTable(
    db.sceneParts,
    aliasName: $_aliasNameGenerator(db.scenes.id, db.sceneParts.sceneId),
  );

  $$ScenePartsTableProcessedTableManager get scenePartsRefs {
    final manager = $$ScenePartsTableTableManager(
      $_db,
      $_db.sceneParts,
    ).filter((f) => f.sceneId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_scenePartsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ScenesTableFilterComposer extends Composer<_$SceneGroup, $ScenesTable> {
  $$ScenesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> scenePartsRefs(
    Expression<bool> Function($$ScenePartsTableFilterComposer f) f,
  ) {
    final $$ScenePartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sceneParts,
      getReferencedColumn: (t) => t.sceneId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenePartsTableFilterComposer(
            $db: $db,
            $table: $db.sceneParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ScenesTableOrderingComposer
    extends Composer<_$SceneGroup, $ScenesTable> {
  $$ScenesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScenesTableAnnotationComposer
    extends Composer<_$SceneGroup, $ScenesTable> {
  $$ScenesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> scenePartsRefs<T extends Object>(
    Expression<T> Function($$ScenePartsTableAnnotationComposer a) f,
  ) {
    final $$ScenePartsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sceneParts,
      getReferencedColumn: (t) => t.sceneId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenePartsTableAnnotationComposer(
            $db: $db,
            $table: $db.sceneParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ScenesTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $ScenesTable,
          Scene,
          $$ScenesTableFilterComposer,
          $$ScenesTableOrderingComposer,
          $$ScenesTableAnnotationComposer,
          $$ScenesTableCreateCompanionBuilder,
          $$ScenesTableUpdateCompanionBuilder,
          (Scene, $$ScenesTableReferences),
          Scene,
          PrefetchHooks Function({bool scenePartsRefs})
        > {
  $$ScenesTableTableManager(_$SceneGroup db, $ScenesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScenesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScenesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScenesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => ScenesCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  ScenesCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ScenesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({scenePartsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (scenePartsRefs) db.sceneParts],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (scenePartsRefs)
                    await $_getPrefetchedData<Scene, $ScenesTable, ScenePart>(
                      currentTable: table,
                      referencedTable: $$ScenesTableReferences
                          ._scenePartsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ScenesTableReferences(db, table, p0).scenePartsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sceneId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ScenesTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $ScenesTable,
      Scene,
      $$ScenesTableFilterComposer,
      $$ScenesTableOrderingComposer,
      $$ScenesTableAnnotationComposer,
      $$ScenesTableCreateCompanionBuilder,
      $$ScenesTableUpdateCompanionBuilder,
      (Scene, $$ScenesTableReferences),
      Scene,
      PrefetchHooks Function({bool scenePartsRefs})
    >;
typedef $$ScenePartsTableCreateCompanionBuilder =
    ScenePartsCompanion Function({
      Value<int> id,
      required int sceneId,
      required double order,
      required String partType,
    });
typedef $$ScenePartsTableUpdateCompanionBuilder =
    ScenePartsCompanion Function({
      Value<int> id,
      Value<int> sceneId,
      Value<double> order,
      Value<String> partType,
    });

final class $$ScenePartsTableReferences
    extends BaseReferences<_$SceneGroup, $ScenePartsTable, ScenePart> {
  $$ScenePartsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ScenesTable _sceneIdTable(_$SceneGroup db) => db.scenes.createAlias(
    $_aliasNameGenerator(db.sceneParts.sceneId, db.scenes.id),
  );

  $$ScenesTableProcessedTableManager get sceneId {
    final $_column = $_itemColumn<int>('scene_id')!;

    final manager = $$ScenesTableTableManager(
      $_db,
      $_db.scenes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sceneIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FramesTable, List<Frame>> _framesRefsTable(
    _$SceneGroup db,
  ) => MultiTypedResultKey.fromTable(
    db.frames,
    aliasName: $_aliasNameGenerator(db.sceneParts.id, db.frames.scenePartId),
  );

  $$FramesTableProcessedTableManager get framesRefs {
    final manager = $$FramesTableTableManager(
      $_db,
      $_db.frames,
    ).filter((f) => f.scenePartId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_framesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ScenePartResolversTable, List<ScenePartResolver>>
  _scenePartResolversRefsTable(_$SceneGroup db) =>
      MultiTypedResultKey.fromTable(
        db.scenePartResolvers,
        aliasName: $_aliasNameGenerator(
          db.sceneParts.id,
          db.scenePartResolvers.scenePartId,
        ),
      );

  $$ScenePartResolversTableProcessedTableManager get scenePartResolversRefs {
    final manager = $$ScenePartResolversTableTableManager(
      $_db,
      $_db.scenePartResolvers,
    ).filter((f) => f.scenePartId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _scenePartResolversRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CustomScenePartsTable, List<CustomScenePart>>
  _customScenePartsRefsTable(_$SceneGroup db) => MultiTypedResultKey.fromTable(
    db.customSceneParts,
    aliasName: $_aliasNameGenerator(
      db.sceneParts.id,
      db.customSceneParts.scenePartId,
    ),
  );

  $$CustomScenePartsTableProcessedTableManager get customScenePartsRefs {
    final manager = $$CustomScenePartsTableTableManager(
      $_db,
      $_db.customSceneParts,
    ).filter((f) => f.scenePartId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _customScenePartsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ScenePartsTableFilterComposer
    extends Composer<_$SceneGroup, $ScenePartsTable> {
  $$ScenePartsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get partType => $composableBuilder(
    column: $table.partType,
    builder: (column) => ColumnFilters(column),
  );

  $$ScenesTableFilterComposer get sceneId {
    final $$ScenesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sceneId,
      referencedTable: $db.scenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenesTableFilterComposer(
            $db: $db,
            $table: $db.scenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> framesRefs(
    Expression<bool> Function($$FramesTableFilterComposer f) f,
  ) {
    final $$FramesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.frames,
      getReferencedColumn: (t) => t.scenePartId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FramesTableFilterComposer(
            $db: $db,
            $table: $db.frames,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scenePartResolversRefs(
    Expression<bool> Function($$ScenePartResolversTableFilterComposer f) f,
  ) {
    final $$ScenePartResolversTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scenePartResolvers,
      getReferencedColumn: (t) => t.scenePartId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenePartResolversTableFilterComposer(
            $db: $db,
            $table: $db.scenePartResolvers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> customScenePartsRefs(
    Expression<bool> Function($$CustomScenePartsTableFilterComposer f) f,
  ) {
    final $$CustomScenePartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customSceneParts,
      getReferencedColumn: (t) => t.scenePartId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomScenePartsTableFilterComposer(
            $db: $db,
            $table: $db.customSceneParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ScenePartsTableOrderingComposer
    extends Composer<_$SceneGroup, $ScenePartsTable> {
  $$ScenePartsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get partType => $composableBuilder(
    column: $table.partType,
    builder: (column) => ColumnOrderings(column),
  );

  $$ScenesTableOrderingComposer get sceneId {
    final $$ScenesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sceneId,
      referencedTable: $db.scenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenesTableOrderingComposer(
            $db: $db,
            $table: $db.scenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScenePartsTableAnnotationComposer
    extends Composer<_$SceneGroup, $ScenePartsTable> {
  $$ScenePartsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<String> get partType =>
      $composableBuilder(column: $table.partType, builder: (column) => column);

  $$ScenesTableAnnotationComposer get sceneId {
    final $$ScenesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sceneId,
      referencedTable: $db.scenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenesTableAnnotationComposer(
            $db: $db,
            $table: $db.scenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> framesRefs<T extends Object>(
    Expression<T> Function($$FramesTableAnnotationComposer a) f,
  ) {
    final $$FramesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.frames,
      getReferencedColumn: (t) => t.scenePartId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FramesTableAnnotationComposer(
            $db: $db,
            $table: $db.frames,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> scenePartResolversRefs<T extends Object>(
    Expression<T> Function($$ScenePartResolversTableAnnotationComposer a) f,
  ) {
    final $$ScenePartResolversTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.scenePartResolvers,
          getReferencedColumn: (t) => t.scenePartId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ScenePartResolversTableAnnotationComposer(
                $db: $db,
                $table: $db.scenePartResolvers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> customScenePartsRefs<T extends Object>(
    Expression<T> Function($$CustomScenePartsTableAnnotationComposer a) f,
  ) {
    final $$CustomScenePartsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customSceneParts,
      getReferencedColumn: (t) => t.scenePartId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomScenePartsTableAnnotationComposer(
            $db: $db,
            $table: $db.customSceneParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ScenePartsTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $ScenePartsTable,
          ScenePart,
          $$ScenePartsTableFilterComposer,
          $$ScenePartsTableOrderingComposer,
          $$ScenePartsTableAnnotationComposer,
          $$ScenePartsTableCreateCompanionBuilder,
          $$ScenePartsTableUpdateCompanionBuilder,
          (ScenePart, $$ScenePartsTableReferences),
          ScenePart,
          PrefetchHooks Function({
            bool sceneId,
            bool framesRefs,
            bool scenePartResolversRefs,
            bool customScenePartsRefs,
          })
        > {
  $$ScenePartsTableTableManager(_$SceneGroup db, $ScenePartsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScenePartsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScenePartsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScenePartsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sceneId = const Value.absent(),
                Value<double> order = const Value.absent(),
                Value<String> partType = const Value.absent(),
              }) => ScenePartsCompanion(
                id: id,
                sceneId: sceneId,
                order: order,
                partType: partType,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sceneId,
                required double order,
                required String partType,
              }) => ScenePartsCompanion.insert(
                id: id,
                sceneId: sceneId,
                order: order,
                partType: partType,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ScenePartsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                sceneId = false,
                framesRefs = false,
                scenePartResolversRefs = false,
                customScenePartsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (framesRefs) db.frames,
                    if (scenePartResolversRefs) db.scenePartResolvers,
                    if (customScenePartsRefs) db.customSceneParts,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (sceneId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sceneId,
                                    referencedTable: $$ScenePartsTableReferences
                                        ._sceneIdTable(db),
                                    referencedColumn:
                                        $$ScenePartsTableReferences
                                            ._sceneIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (framesRefs)
                        await $_getPrefetchedData<
                          ScenePart,
                          $ScenePartsTable,
                          Frame
                        >(
                          currentTable: table,
                          referencedTable: $$ScenePartsTableReferences
                              ._framesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ScenePartsTableReferences(
                                db,
                                table,
                                p0,
                              ).framesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.scenePartId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (scenePartResolversRefs)
                        await $_getPrefetchedData<
                          ScenePart,
                          $ScenePartsTable,
                          ScenePartResolver
                        >(
                          currentTable: table,
                          referencedTable: $$ScenePartsTableReferences
                              ._scenePartResolversRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ScenePartsTableReferences(
                                db,
                                table,
                                p0,
                              ).scenePartResolversRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.scenePartId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (customScenePartsRefs)
                        await $_getPrefetchedData<
                          ScenePart,
                          $ScenePartsTable,
                          CustomScenePart
                        >(
                          currentTable: table,
                          referencedTable: $$ScenePartsTableReferences
                              ._customScenePartsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ScenePartsTableReferences(
                                db,
                                table,
                                p0,
                              ).customScenePartsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.scenePartId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ScenePartsTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $ScenePartsTable,
      ScenePart,
      $$ScenePartsTableFilterComposer,
      $$ScenePartsTableOrderingComposer,
      $$ScenePartsTableAnnotationComposer,
      $$ScenePartsTableCreateCompanionBuilder,
      $$ScenePartsTableUpdateCompanionBuilder,
      (ScenePart, $$ScenePartsTableReferences),
      ScenePart,
      PrefetchHooks Function({
        bool sceneId,
        bool framesRefs,
        bool scenePartResolversRefs,
        bool customScenePartsRefs,
      })
    >;
typedef $$PlacesTableCreateCompanionBuilder =
    PlacesCompanion Function({Value<int> id, required String name});
typedef $$PlacesTableUpdateCompanionBuilder =
    PlacesCompanion Function({Value<int> id, Value<String> name});

final class $$PlacesTableReferences
    extends BaseReferences<_$SceneGroup, $PlacesTable, Place> {
  $$PlacesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $BackgroundMetadatasTable,
    List<BackgroundMetadata>
  >
  _backgroundMetadatasRefsTable(_$SceneGroup db) =>
      MultiTypedResultKey.fromTable(
        db.backgroundMetadatas,
        aliasName: $_aliasNameGenerator(
          db.places.id,
          db.backgroundMetadatas.groupId,
        ),
      );

  $$BackgroundMetadatasTableProcessedTableManager get backgroundMetadatasRefs {
    final manager = $$BackgroundMetadatasTableTableManager(
      $_db,
      $_db.backgroundMetadatas,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _backgroundMetadatasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlacesTableFilterComposer extends Composer<_$SceneGroup, $PlacesTable> {
  $$PlacesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> backgroundMetadatasRefs(
    Expression<bool> Function($$BackgroundMetadatasTableFilterComposer f) f,
  ) {
    final $$BackgroundMetadatasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.backgroundMetadatas,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BackgroundMetadatasTableFilterComposer(
            $db: $db,
            $table: $db.backgroundMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlacesTableOrderingComposer
    extends Composer<_$SceneGroup, $PlacesTable> {
  $$PlacesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlacesTableAnnotationComposer
    extends Composer<_$SceneGroup, $PlacesTable> {
  $$PlacesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> backgroundMetadatasRefs<T extends Object>(
    Expression<T> Function($$BackgroundMetadatasTableAnnotationComposer a) f,
  ) {
    final $$BackgroundMetadatasTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.backgroundMetadatas,
          getReferencedColumn: (t) => t.groupId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BackgroundMetadatasTableAnnotationComposer(
                $db: $db,
                $table: $db.backgroundMetadatas,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PlacesTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $PlacesTable,
          Place,
          $$PlacesTableFilterComposer,
          $$PlacesTableOrderingComposer,
          $$PlacesTableAnnotationComposer,
          $$PlacesTableCreateCompanionBuilder,
          $$PlacesTableUpdateCompanionBuilder,
          (Place, $$PlacesTableReferences),
          Place,
          PrefetchHooks Function({bool backgroundMetadatasRefs})
        > {
  $$PlacesTableTableManager(_$SceneGroup db, $PlacesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlacesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlacesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlacesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => PlacesCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  PlacesCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PlacesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({backgroundMetadatasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (backgroundMetadatasRefs) db.backgroundMetadatas,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (backgroundMetadatasRefs)
                    await $_getPrefetchedData<
                      Place,
                      $PlacesTable,
                      BackgroundMetadata
                    >(
                      currentTable: table,
                      referencedTable: $$PlacesTableReferences
                          ._backgroundMetadatasRefsTable(db),
                      managerFromTypedResult: (p0) => $$PlacesTableReferences(
                        db,
                        table,
                        p0,
                      ).backgroundMetadatasRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.groupId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PlacesTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $PlacesTable,
      Place,
      $$PlacesTableFilterComposer,
      $$PlacesTableOrderingComposer,
      $$PlacesTableAnnotationComposer,
      $$PlacesTableCreateCompanionBuilder,
      $$PlacesTableUpdateCompanionBuilder,
      (Place, $$PlacesTableReferences),
      Place,
      PrefetchHooks Function({bool backgroundMetadatasRefs})
    >;
typedef $$BackgroundMetadatasTableCreateCompanionBuilder =
    BackgroundMetadatasCompanion Function({
      Value<int> id,
      required int groupId,
      required String name,
    });
typedef $$BackgroundMetadatasTableUpdateCompanionBuilder =
    BackgroundMetadatasCompanion Function({
      Value<int> id,
      Value<int> groupId,
      Value<String> name,
    });

final class $$BackgroundMetadatasTableReferences
    extends
        BaseReferences<
          _$SceneGroup,
          $BackgroundMetadatasTable,
          BackgroundMetadata
        > {
  $$BackgroundMetadatasTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlacesTable _groupIdTable(_$SceneGroup db) => db.places.createAlias(
    $_aliasNameGenerator(db.backgroundMetadatas.groupId, db.places.id),
  );

  $$PlacesTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<int>('group_id')!;

    final manager = $$PlacesTableTableManager(
      $_db,
      $_db.places,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FramesTable, List<Frame>> _framesRefsTable(
    _$SceneGroup db,
  ) => MultiTypedResultKey.fromTable(
    db.frames,
    aliasName: $_aliasNameGenerator(
      db.backgroundMetadatas.id,
      db.frames.backgroundId,
    ),
  );

  $$FramesTableProcessedTableManager get framesRefs {
    final manager = $$FramesTableTableManager(
      $_db,
      $_db.frames,
    ).filter((f) => f.backgroundId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_framesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BackgroundImagesTable, List<BackgroundImage>>
  _backgroundImagesRefsTable(_$SceneGroup db) => MultiTypedResultKey.fromTable(
    db.backgroundImages,
    aliasName: $_aliasNameGenerator(
      db.backgroundMetadatas.id,
      db.backgroundImages.metadataId,
    ),
  );

  $$BackgroundImagesTableProcessedTableManager get backgroundImagesRefs {
    final manager = $$BackgroundImagesTableTableManager(
      $_db,
      $_db.backgroundImages,
    ).filter((f) => f.metadataId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _backgroundImagesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BackgroundMetadatasTableFilterComposer
    extends Composer<_$SceneGroup, $BackgroundMetadatasTable> {
  $$BackgroundMetadatasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  $$PlacesTableFilterComposer get groupId {
    final $$PlacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.places,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlacesTableFilterComposer(
            $db: $db,
            $table: $db.places,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> framesRefs(
    Expression<bool> Function($$FramesTableFilterComposer f) f,
  ) {
    final $$FramesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.frames,
      getReferencedColumn: (t) => t.backgroundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FramesTableFilterComposer(
            $db: $db,
            $table: $db.frames,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> backgroundImagesRefs(
    Expression<bool> Function($$BackgroundImagesTableFilterComposer f) f,
  ) {
    final $$BackgroundImagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.backgroundImages,
      getReferencedColumn: (t) => t.metadataId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BackgroundImagesTableFilterComposer(
            $db: $db,
            $table: $db.backgroundImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BackgroundMetadatasTableOrderingComposer
    extends Composer<_$SceneGroup, $BackgroundMetadatasTable> {
  $$BackgroundMetadatasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlacesTableOrderingComposer get groupId {
    final $$PlacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.places,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlacesTableOrderingComposer(
            $db: $db,
            $table: $db.places,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BackgroundMetadatasTableAnnotationComposer
    extends Composer<_$SceneGroup, $BackgroundMetadatasTable> {
  $$BackgroundMetadatasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$PlacesTableAnnotationComposer get groupId {
    final $$PlacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.places,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlacesTableAnnotationComposer(
            $db: $db,
            $table: $db.places,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> framesRefs<T extends Object>(
    Expression<T> Function($$FramesTableAnnotationComposer a) f,
  ) {
    final $$FramesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.frames,
      getReferencedColumn: (t) => t.backgroundId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FramesTableAnnotationComposer(
            $db: $db,
            $table: $db.frames,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> backgroundImagesRefs<T extends Object>(
    Expression<T> Function($$BackgroundImagesTableAnnotationComposer a) f,
  ) {
    final $$BackgroundImagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.backgroundImages,
      getReferencedColumn: (t) => t.metadataId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BackgroundImagesTableAnnotationComposer(
            $db: $db,
            $table: $db.backgroundImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BackgroundMetadatasTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $BackgroundMetadatasTable,
          BackgroundMetadata,
          $$BackgroundMetadatasTableFilterComposer,
          $$BackgroundMetadatasTableOrderingComposer,
          $$BackgroundMetadatasTableAnnotationComposer,
          $$BackgroundMetadatasTableCreateCompanionBuilder,
          $$BackgroundMetadatasTableUpdateCompanionBuilder,
          (BackgroundMetadata, $$BackgroundMetadatasTableReferences),
          BackgroundMetadata,
          PrefetchHooks Function({
            bool groupId,
            bool framesRefs,
            bool backgroundImagesRefs,
          })
        > {
  $$BackgroundMetadatasTableTableManager(
    _$SceneGroup db,
    $BackgroundMetadatasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackgroundMetadatasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BackgroundMetadatasTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BackgroundMetadatasTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> groupId = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => BackgroundMetadatasCompanion(
                id: id,
                groupId: groupId,
                name: name,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int groupId,
                required String name,
              }) => BackgroundMetadatasCompanion.insert(
                id: id,
                groupId: groupId,
                name: name,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BackgroundMetadatasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                groupId = false,
                framesRefs = false,
                backgroundImagesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (framesRefs) db.frames,
                    if (backgroundImagesRefs) db.backgroundImages,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (groupId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.groupId,
                                    referencedTable:
                                        $$BackgroundMetadatasTableReferences
                                            ._groupIdTable(db),
                                    referencedColumn:
                                        $$BackgroundMetadatasTableReferences
                                            ._groupIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (framesRefs)
                        await $_getPrefetchedData<
                          BackgroundMetadata,
                          $BackgroundMetadatasTable,
                          Frame
                        >(
                          currentTable: table,
                          referencedTable: $$BackgroundMetadatasTableReferences
                              ._framesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BackgroundMetadatasTableReferences(
                                db,
                                table,
                                p0,
                              ).framesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.backgroundId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (backgroundImagesRefs)
                        await $_getPrefetchedData<
                          BackgroundMetadata,
                          $BackgroundMetadatasTable,
                          BackgroundImage
                        >(
                          currentTable: table,
                          referencedTable: $$BackgroundMetadatasTableReferences
                              ._backgroundImagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BackgroundMetadatasTableReferences(
                                db,
                                table,
                                p0,
                              ).backgroundImagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.metadataId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BackgroundMetadatasTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $BackgroundMetadatasTable,
      BackgroundMetadata,
      $$BackgroundMetadatasTableFilterComposer,
      $$BackgroundMetadatasTableOrderingComposer,
      $$BackgroundMetadatasTableAnnotationComposer,
      $$BackgroundMetadatasTableCreateCompanionBuilder,
      $$BackgroundMetadatasTableUpdateCompanionBuilder,
      (BackgroundMetadata, $$BackgroundMetadatasTableReferences),
      BackgroundMetadata,
      PrefetchHooks Function({
        bool groupId,
        bool framesRefs,
        bool backgroundImagesRefs,
      })
    >;
typedef $$FramesTableCreateCompanionBuilder =
    FramesCompanion Function({
      Value<int> scenePartId,
      Value<int?> backgroundId,
    });
typedef $$FramesTableUpdateCompanionBuilder =
    FramesCompanion Function({
      Value<int> scenePartId,
      Value<int?> backgroundId,
    });

final class $$FramesTableReferences
    extends BaseReferences<_$SceneGroup, $FramesTable, Frame> {
  $$FramesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ScenePartsTable _scenePartIdTable(_$SceneGroup db) =>
      db.sceneParts.createAlias(
        $_aliasNameGenerator(db.frames.scenePartId, db.sceneParts.id),
      );

  $$ScenePartsTableProcessedTableManager get scenePartId {
    final $_column = $_itemColumn<int>('scene_part_id')!;

    final manager = $$ScenePartsTableTableManager(
      $_db,
      $_db.sceneParts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_scenePartIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BackgroundMetadatasTable _backgroundIdTable(_$SceneGroup db) =>
      db.backgroundMetadatas.createAlias(
        $_aliasNameGenerator(db.frames.backgroundId, db.backgroundMetadatas.id),
      );

  $$BackgroundMetadatasTableProcessedTableManager? get backgroundId {
    final $_column = $_itemColumn<int>('background_id');
    if ($_column == null) return null;
    final manager = $$BackgroundMetadatasTableTableManager(
      $_db,
      $_db.backgroundMetadatas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_backgroundIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FramesTableFilterComposer extends Composer<_$SceneGroup, $FramesTable> {
  $$FramesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ScenePartsTableFilterComposer get scenePartId {
    final $$ScenePartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scenePartId,
      referencedTable: $db.sceneParts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenePartsTableFilterComposer(
            $db: $db,
            $table: $db.sceneParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BackgroundMetadatasTableFilterComposer get backgroundId {
    final $$BackgroundMetadatasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.backgroundId,
      referencedTable: $db.backgroundMetadatas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BackgroundMetadatasTableFilterComposer(
            $db: $db,
            $table: $db.backgroundMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FramesTableOrderingComposer
    extends Composer<_$SceneGroup, $FramesTable> {
  $$FramesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ScenePartsTableOrderingComposer get scenePartId {
    final $$ScenePartsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scenePartId,
      referencedTable: $db.sceneParts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenePartsTableOrderingComposer(
            $db: $db,
            $table: $db.sceneParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BackgroundMetadatasTableOrderingComposer get backgroundId {
    final $$BackgroundMetadatasTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.backgroundId,
          referencedTable: $db.backgroundMetadatas,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BackgroundMetadatasTableOrderingComposer(
                $db: $db,
                $table: $db.backgroundMetadatas,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$FramesTableAnnotationComposer
    extends Composer<_$SceneGroup, $FramesTable> {
  $$FramesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ScenePartsTableAnnotationComposer get scenePartId {
    final $$ScenePartsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scenePartId,
      referencedTable: $db.sceneParts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenePartsTableAnnotationComposer(
            $db: $db,
            $table: $db.sceneParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BackgroundMetadatasTableAnnotationComposer get backgroundId {
    final $$BackgroundMetadatasTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.backgroundId,
          referencedTable: $db.backgroundMetadatas,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BackgroundMetadatasTableAnnotationComposer(
                $db: $db,
                $table: $db.backgroundMetadatas,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$FramesTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $FramesTable,
          Frame,
          $$FramesTableFilterComposer,
          $$FramesTableOrderingComposer,
          $$FramesTableAnnotationComposer,
          $$FramesTableCreateCompanionBuilder,
          $$FramesTableUpdateCompanionBuilder,
          (Frame, $$FramesTableReferences),
          Frame,
          PrefetchHooks Function({bool scenePartId, bool backgroundId})
        > {
  $$FramesTableTableManager(_$SceneGroup db, $FramesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FramesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FramesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FramesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> scenePartId = const Value.absent(),
                Value<int?> backgroundId = const Value.absent(),
              }) => FramesCompanion(
                scenePartId: scenePartId,
                backgroundId: backgroundId,
              ),
          createCompanionCallback:
              ({
                Value<int> scenePartId = const Value.absent(),
                Value<int?> backgroundId = const Value.absent(),
              }) => FramesCompanion.insert(
                scenePartId: scenePartId,
                backgroundId: backgroundId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$FramesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({scenePartId = false, backgroundId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (scenePartId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.scenePartId,
                                referencedTable: $$FramesTableReferences
                                    ._scenePartIdTable(db),
                                referencedColumn: $$FramesTableReferences
                                    ._scenePartIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (backgroundId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.backgroundId,
                                referencedTable: $$FramesTableReferences
                                    ._backgroundIdTable(db),
                                referencedColumn: $$FramesTableReferences
                                    ._backgroundIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FramesTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $FramesTable,
      Frame,
      $$FramesTableFilterComposer,
      $$FramesTableOrderingComposer,
      $$FramesTableAnnotationComposer,
      $$FramesTableCreateCompanionBuilder,
      $$FramesTableUpdateCompanionBuilder,
      (Frame, $$FramesTableReferences),
      Frame,
      PrefetchHooks Function({bool scenePartId, bool backgroundId})
    >;
typedef $$ScenePartResolversTableCreateCompanionBuilder =
    ScenePartResolversCompanion Function({
      Value<int> scenePartId,
      required String dartResolverScript,
    });
typedef $$ScenePartResolversTableUpdateCompanionBuilder =
    ScenePartResolversCompanion Function({
      Value<int> scenePartId,
      Value<String> dartResolverScript,
    });

final class $$ScenePartResolversTableReferences
    extends
        BaseReferences<
          _$SceneGroup,
          $ScenePartResolversTable,
          ScenePartResolver
        > {
  $$ScenePartResolversTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ScenePartsTable _scenePartIdTable(_$SceneGroup db) =>
      db.sceneParts.createAlias(
        $_aliasNameGenerator(
          db.scenePartResolvers.scenePartId,
          db.sceneParts.id,
        ),
      );

  $$ScenePartsTableProcessedTableManager get scenePartId {
    final $_column = $_itemColumn<int>('scene_part_id')!;

    final manager = $$ScenePartsTableTableManager(
      $_db,
      $_db.sceneParts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_scenePartIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScenePartResolversTableFilterComposer
    extends Composer<_$SceneGroup, $ScenePartResolversTable> {
  $$ScenePartResolversTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get dartResolverScript => $composableBuilder(
    column: $table.dartResolverScript,
    builder: (column) => ColumnFilters(column),
  );

  $$ScenePartsTableFilterComposer get scenePartId {
    final $$ScenePartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scenePartId,
      referencedTable: $db.sceneParts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenePartsTableFilterComposer(
            $db: $db,
            $table: $db.sceneParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScenePartResolversTableOrderingComposer
    extends Composer<_$SceneGroup, $ScenePartResolversTable> {
  $$ScenePartResolversTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get dartResolverScript => $composableBuilder(
    column: $table.dartResolverScript,
    builder: (column) => ColumnOrderings(column),
  );

  $$ScenePartsTableOrderingComposer get scenePartId {
    final $$ScenePartsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scenePartId,
      referencedTable: $db.sceneParts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenePartsTableOrderingComposer(
            $db: $db,
            $table: $db.sceneParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScenePartResolversTableAnnotationComposer
    extends Composer<_$SceneGroup, $ScenePartResolversTable> {
  $$ScenePartResolversTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get dartResolverScript => $composableBuilder(
    column: $table.dartResolverScript,
    builder: (column) => column,
  );

  $$ScenePartsTableAnnotationComposer get scenePartId {
    final $$ScenePartsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scenePartId,
      referencedTable: $db.sceneParts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenePartsTableAnnotationComposer(
            $db: $db,
            $table: $db.sceneParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScenePartResolversTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $ScenePartResolversTable,
          ScenePartResolver,
          $$ScenePartResolversTableFilterComposer,
          $$ScenePartResolversTableOrderingComposer,
          $$ScenePartResolversTableAnnotationComposer,
          $$ScenePartResolversTableCreateCompanionBuilder,
          $$ScenePartResolversTableUpdateCompanionBuilder,
          (ScenePartResolver, $$ScenePartResolversTableReferences),
          ScenePartResolver,
          PrefetchHooks Function({bool scenePartId})
        > {
  $$ScenePartResolversTableTableManager(
    _$SceneGroup db,
    $ScenePartResolversTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScenePartResolversTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScenePartResolversTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScenePartResolversTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> scenePartId = const Value.absent(),
                Value<String> dartResolverScript = const Value.absent(),
              }) => ScenePartResolversCompanion(
                scenePartId: scenePartId,
                dartResolverScript: dartResolverScript,
              ),
          createCompanionCallback:
              ({
                Value<int> scenePartId = const Value.absent(),
                required String dartResolverScript,
              }) => ScenePartResolversCompanion.insert(
                scenePartId: scenePartId,
                dartResolverScript: dartResolverScript,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ScenePartResolversTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({scenePartId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (scenePartId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.scenePartId,
                                referencedTable:
                                    $$ScenePartResolversTableReferences
                                        ._scenePartIdTable(db),
                                referencedColumn:
                                    $$ScenePartResolversTableReferences
                                        ._scenePartIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ScenePartResolversTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $ScenePartResolversTable,
      ScenePartResolver,
      $$ScenePartResolversTableFilterComposer,
      $$ScenePartResolversTableOrderingComposer,
      $$ScenePartResolversTableAnnotationComposer,
      $$ScenePartResolversTableCreateCompanionBuilder,
      $$ScenePartResolversTableUpdateCompanionBuilder,
      (ScenePartResolver, $$ScenePartResolversTableReferences),
      ScenePartResolver,
      PrefetchHooks Function({bool scenePartId})
    >;
typedef $$CustomScenePartsTableCreateCompanionBuilder =
    CustomScenePartsCompanion Function({
      Value<int> scenePartId,
      required String eventId,
    });
typedef $$CustomScenePartsTableUpdateCompanionBuilder =
    CustomScenePartsCompanion Function({
      Value<int> scenePartId,
      Value<String> eventId,
    });

final class $$CustomScenePartsTableReferences
    extends
        BaseReferences<_$SceneGroup, $CustomScenePartsTable, CustomScenePart> {
  $$CustomScenePartsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ScenePartsTable _scenePartIdTable(_$SceneGroup db) =>
      db.sceneParts.createAlias(
        $_aliasNameGenerator(db.customSceneParts.scenePartId, db.sceneParts.id),
      );

  $$ScenePartsTableProcessedTableManager get scenePartId {
    final $_column = $_itemColumn<int>('scene_part_id')!;

    final manager = $$ScenePartsTableTableManager(
      $_db,
      $_db.sceneParts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_scenePartIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CustomScenePartsTableFilterComposer
    extends Composer<_$SceneGroup, $CustomScenePartsTable> {
  $$CustomScenePartsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnFilters(column),
  );

  $$ScenePartsTableFilterComposer get scenePartId {
    final $$ScenePartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scenePartId,
      referencedTable: $db.sceneParts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenePartsTableFilterComposer(
            $db: $db,
            $table: $db.sceneParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomScenePartsTableOrderingComposer
    extends Composer<_$SceneGroup, $CustomScenePartsTable> {
  $$CustomScenePartsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnOrderings(column),
  );

  $$ScenePartsTableOrderingComposer get scenePartId {
    final $$ScenePartsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scenePartId,
      referencedTable: $db.sceneParts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenePartsTableOrderingComposer(
            $db: $db,
            $table: $db.sceneParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomScenePartsTableAnnotationComposer
    extends Composer<_$SceneGroup, $CustomScenePartsTable> {
  $$CustomScenePartsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);

  $$ScenePartsTableAnnotationComposer get scenePartId {
    final $$ScenePartsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.scenePartId,
      referencedTable: $db.sceneParts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScenePartsTableAnnotationComposer(
            $db: $db,
            $table: $db.sceneParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomScenePartsTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $CustomScenePartsTable,
          CustomScenePart,
          $$CustomScenePartsTableFilterComposer,
          $$CustomScenePartsTableOrderingComposer,
          $$CustomScenePartsTableAnnotationComposer,
          $$CustomScenePartsTableCreateCompanionBuilder,
          $$CustomScenePartsTableUpdateCompanionBuilder,
          (CustomScenePart, $$CustomScenePartsTableReferences),
          CustomScenePart,
          PrefetchHooks Function({bool scenePartId})
        > {
  $$CustomScenePartsTableTableManager(
    _$SceneGroup db,
    $CustomScenePartsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomScenePartsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomScenePartsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomScenePartsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> scenePartId = const Value.absent(),
                Value<String> eventId = const Value.absent(),
              }) => CustomScenePartsCompanion(
                scenePartId: scenePartId,
                eventId: eventId,
              ),
          createCompanionCallback:
              ({
                Value<int> scenePartId = const Value.absent(),
                required String eventId,
              }) => CustomScenePartsCompanion.insert(
                scenePartId: scenePartId,
                eventId: eventId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CustomScenePartsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({scenePartId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (scenePartId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.scenePartId,
                                referencedTable:
                                    $$CustomScenePartsTableReferences
                                        ._scenePartIdTable(db),
                                referencedColumn:
                                    $$CustomScenePartsTableReferences
                                        ._scenePartIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CustomScenePartsTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $CustomScenePartsTable,
      CustomScenePart,
      $$CustomScenePartsTableFilterComposer,
      $$CustomScenePartsTableOrderingComposer,
      $$CustomScenePartsTableAnnotationComposer,
      $$CustomScenePartsTableCreateCompanionBuilder,
      $$CustomScenePartsTableUpdateCompanionBuilder,
      (CustomScenePart, $$CustomScenePartsTableReferences),
      CustomScenePart,
      PrefetchHooks Function({bool scenePartId})
    >;
typedef $$ActorsTableCreateCompanionBuilder =
    ActorsCompanion Function({Value<int> id, required String name});
typedef $$ActorsTableUpdateCompanionBuilder =
    ActorsCompanion Function({Value<int> id, Value<String> name});

final class $$ActorsTableReferences
    extends BaseReferences<_$SceneGroup, $ActorsTable, Actor> {
  $$ActorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PoseMetadatasTable, List<PoseMetadata>>
  _poseMetadatasRefsTable(_$SceneGroup db) => MultiTypedResultKey.fromTable(
    db.poseMetadatas,
    aliasName: $_aliasNameGenerator(db.actors.id, db.poseMetadatas.groupId),
  );

  $$PoseMetadatasTableProcessedTableManager get poseMetadatasRefs {
    final manager = $$PoseMetadatasTableTableManager(
      $_db,
      $_db.poseMetadatas,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_poseMetadatasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ActorsTableFilterComposer extends Composer<_$SceneGroup, $ActorsTable> {
  $$ActorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> poseMetadatasRefs(
    Expression<bool> Function($$PoseMetadatasTableFilterComposer f) f,
  ) {
    final $$PoseMetadatasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.poseMetadatas,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PoseMetadatasTableFilterComposer(
            $db: $db,
            $table: $db.poseMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ActorsTableOrderingComposer
    extends Composer<_$SceneGroup, $ActorsTable> {
  $$ActorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActorsTableAnnotationComposer
    extends Composer<_$SceneGroup, $ActorsTable> {
  $$ActorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> poseMetadatasRefs<T extends Object>(
    Expression<T> Function($$PoseMetadatasTableAnnotationComposer a) f,
  ) {
    final $$PoseMetadatasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.poseMetadatas,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PoseMetadatasTableAnnotationComposer(
            $db: $db,
            $table: $db.poseMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ActorsTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $ActorsTable,
          Actor,
          $$ActorsTableFilterComposer,
          $$ActorsTableOrderingComposer,
          $$ActorsTableAnnotationComposer,
          $$ActorsTableCreateCompanionBuilder,
          $$ActorsTableUpdateCompanionBuilder,
          (Actor, $$ActorsTableReferences),
          Actor,
          PrefetchHooks Function({bool poseMetadatasRefs})
        > {
  $$ActorsTableTableManager(_$SceneGroup db, $ActorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => ActorsCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  ActorsCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ActorsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({poseMetadatasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (poseMetadatasRefs) db.poseMetadatas,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (poseMetadatasRefs)
                    await $_getPrefetchedData<
                      Actor,
                      $ActorsTable,
                      PoseMetadata
                    >(
                      currentTable: table,
                      referencedTable: $$ActorsTableReferences
                          ._poseMetadatasRefsTable(db),
                      managerFromTypedResult: (p0) => $$ActorsTableReferences(
                        db,
                        table,
                        p0,
                      ).poseMetadatasRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.groupId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ActorsTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $ActorsTable,
      Actor,
      $$ActorsTableFilterComposer,
      $$ActorsTableOrderingComposer,
      $$ActorsTableAnnotationComposer,
      $$ActorsTableCreateCompanionBuilder,
      $$ActorsTableUpdateCompanionBuilder,
      (Actor, $$ActorsTableReferences),
      Actor,
      PrefetchHooks Function({bool poseMetadatasRefs})
    >;
typedef $$PoseMetadatasTableCreateCompanionBuilder =
    PoseMetadatasCompanion Function({
      Value<int> id,
      required int groupId,
      required String name,
    });
typedef $$PoseMetadatasTableUpdateCompanionBuilder =
    PoseMetadatasCompanion Function({
      Value<int> id,
      Value<int> groupId,
      Value<String> name,
    });

final class $$PoseMetadatasTableReferences
    extends BaseReferences<_$SceneGroup, $PoseMetadatasTable, PoseMetadata> {
  $$PoseMetadatasTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ActorsTable _groupIdTable(_$SceneGroup db) => db.actors.createAlias(
    $_aliasNameGenerator(db.poseMetadatas.groupId, db.actors.id),
  );

  $$ActorsTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<int>('group_id')!;

    final manager = $$ActorsTableTableManager(
      $_db,
      $_db.actors,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FramePosesTable, List<FramePose>>
  _framePosesRefsTable(_$SceneGroup db) => MultiTypedResultKey.fromTable(
    db.framePoses,
    aliasName: $_aliasNameGenerator(db.poseMetadatas.id, db.framePoses.poseId),
  );

  $$FramePosesTableProcessedTableManager get framePosesRefs {
    final manager = $$FramePosesTableTableManager(
      $_db,
      $_db.framePoses,
    ).filter((f) => f.poseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_framePosesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PoseImagesTable, List<PoseImage>>
  _poseImagesRefsTable(_$SceneGroup db) => MultiTypedResultKey.fromTable(
    db.poseImages,
    aliasName: $_aliasNameGenerator(
      db.poseMetadatas.id,
      db.poseImages.metadataId,
    ),
  );

  $$PoseImagesTableProcessedTableManager get poseImagesRefs {
    final manager = $$PoseImagesTableTableManager(
      $_db,
      $_db.poseImages,
    ).filter((f) => f.metadataId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_poseImagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PoseMetadatasTableFilterComposer
    extends Composer<_$SceneGroup, $PoseMetadatasTable> {
  $$PoseMetadatasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  $$ActorsTableFilterComposer get groupId {
    final $$ActorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.actors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActorsTableFilterComposer(
            $db: $db,
            $table: $db.actors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> framePosesRefs(
    Expression<bool> Function($$FramePosesTableFilterComposer f) f,
  ) {
    final $$FramePosesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.framePoses,
      getReferencedColumn: (t) => t.poseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FramePosesTableFilterComposer(
            $db: $db,
            $table: $db.framePoses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> poseImagesRefs(
    Expression<bool> Function($$PoseImagesTableFilterComposer f) f,
  ) {
    final $$PoseImagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.poseImages,
      getReferencedColumn: (t) => t.metadataId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PoseImagesTableFilterComposer(
            $db: $db,
            $table: $db.poseImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PoseMetadatasTableOrderingComposer
    extends Composer<_$SceneGroup, $PoseMetadatasTable> {
  $$PoseMetadatasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  $$ActorsTableOrderingComposer get groupId {
    final $$ActorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.actors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActorsTableOrderingComposer(
            $db: $db,
            $table: $db.actors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PoseMetadatasTableAnnotationComposer
    extends Composer<_$SceneGroup, $PoseMetadatasTable> {
  $$PoseMetadatasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$ActorsTableAnnotationComposer get groupId {
    final $$ActorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.actors,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActorsTableAnnotationComposer(
            $db: $db,
            $table: $db.actors,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> framePosesRefs<T extends Object>(
    Expression<T> Function($$FramePosesTableAnnotationComposer a) f,
  ) {
    final $$FramePosesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.framePoses,
      getReferencedColumn: (t) => t.poseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FramePosesTableAnnotationComposer(
            $db: $db,
            $table: $db.framePoses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> poseImagesRefs<T extends Object>(
    Expression<T> Function($$PoseImagesTableAnnotationComposer a) f,
  ) {
    final $$PoseImagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.poseImages,
      getReferencedColumn: (t) => t.metadataId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PoseImagesTableAnnotationComposer(
            $db: $db,
            $table: $db.poseImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PoseMetadatasTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $PoseMetadatasTable,
          PoseMetadata,
          $$PoseMetadatasTableFilterComposer,
          $$PoseMetadatasTableOrderingComposer,
          $$PoseMetadatasTableAnnotationComposer,
          $$PoseMetadatasTableCreateCompanionBuilder,
          $$PoseMetadatasTableUpdateCompanionBuilder,
          (PoseMetadata, $$PoseMetadatasTableReferences),
          PoseMetadata,
          PrefetchHooks Function({
            bool groupId,
            bool framePosesRefs,
            bool poseImagesRefs,
          })
        > {
  $$PoseMetadatasTableTableManager(_$SceneGroup db, $PoseMetadatasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PoseMetadatasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PoseMetadatasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PoseMetadatasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> groupId = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) =>
                  PoseMetadatasCompanion(id: id, groupId: groupId, name: name),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int groupId,
                required String name,
              }) => PoseMetadatasCompanion.insert(
                id: id,
                groupId: groupId,
                name: name,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PoseMetadatasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                groupId = false,
                framePosesRefs = false,
                poseImagesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (framePosesRefs) db.framePoses,
                    if (poseImagesRefs) db.poseImages,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (groupId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.groupId,
                                    referencedTable:
                                        $$PoseMetadatasTableReferences
                                            ._groupIdTable(db),
                                    referencedColumn:
                                        $$PoseMetadatasTableReferences
                                            ._groupIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (framePosesRefs)
                        await $_getPrefetchedData<
                          PoseMetadata,
                          $PoseMetadatasTable,
                          FramePose
                        >(
                          currentTable: table,
                          referencedTable: $$PoseMetadatasTableReferences
                              ._framePosesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PoseMetadatasTableReferences(
                                db,
                                table,
                                p0,
                              ).framePosesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.poseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (poseImagesRefs)
                        await $_getPrefetchedData<
                          PoseMetadata,
                          $PoseMetadatasTable,
                          PoseImage
                        >(
                          currentTable: table,
                          referencedTable: $$PoseMetadatasTableReferences
                              ._poseImagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PoseMetadatasTableReferences(
                                db,
                                table,
                                p0,
                              ).poseImagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.metadataId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PoseMetadatasTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $PoseMetadatasTable,
      PoseMetadata,
      $$PoseMetadatasTableFilterComposer,
      $$PoseMetadatasTableOrderingComposer,
      $$PoseMetadatasTableAnnotationComposer,
      $$PoseMetadatasTableCreateCompanionBuilder,
      $$PoseMetadatasTableUpdateCompanionBuilder,
      (PoseMetadata, $$PoseMetadatasTableReferences),
      PoseMetadata,
      PrefetchHooks Function({
        bool groupId,
        bool framePosesRefs,
        bool poseImagesRefs,
      })
    >;
typedef $$FramePosesTableCreateCompanionBuilder =
    FramePosesCompanion Function({
      Value<int> id,
      required int frameScenePartId,
      Value<int?> poseId,
      required double order,
    });
typedef $$FramePosesTableUpdateCompanionBuilder =
    FramePosesCompanion Function({
      Value<int> id,
      Value<int> frameScenePartId,
      Value<int?> poseId,
      Value<double> order,
    });

final class $$FramePosesTableReferences
    extends BaseReferences<_$SceneGroup, $FramePosesTable, FramePose> {
  $$FramePosesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PoseMetadatasTable _poseIdTable(_$SceneGroup db) =>
      db.poseMetadatas.createAlias(
        $_aliasNameGenerator(db.framePoses.poseId, db.poseMetadatas.id),
      );

  $$PoseMetadatasTableProcessedTableManager? get poseId {
    final $_column = $_itemColumn<int>('pose_id');
    if ($_column == null) return null;
    final manager = $$PoseMetadatasTableTableManager(
      $_db,
      $_db.poseMetadatas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_poseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FramePosesTableFilterComposer
    extends Composer<_$SceneGroup, $FramePosesTable> {
  $$FramePosesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  $$PoseMetadatasTableFilterComposer get poseId {
    final $$PoseMetadatasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.poseId,
      referencedTable: $db.poseMetadatas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PoseMetadatasTableFilterComposer(
            $db: $db,
            $table: $db.poseMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FramePosesTableOrderingComposer
    extends Composer<_$SceneGroup, $FramePosesTable> {
  $$FramePosesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  $$PoseMetadatasTableOrderingComposer get poseId {
    final $$PoseMetadatasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.poseId,
      referencedTable: $db.poseMetadatas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PoseMetadatasTableOrderingComposer(
            $db: $db,
            $table: $db.poseMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FramePosesTableAnnotationComposer
    extends Composer<_$SceneGroup, $FramePosesTable> {
  $$FramePosesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  $$PoseMetadatasTableAnnotationComposer get poseId {
    final $$PoseMetadatasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.poseId,
      referencedTable: $db.poseMetadatas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PoseMetadatasTableAnnotationComposer(
            $db: $db,
            $table: $db.poseMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FramePosesTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $FramePosesTable,
          FramePose,
          $$FramePosesTableFilterComposer,
          $$FramePosesTableOrderingComposer,
          $$FramePosesTableAnnotationComposer,
          $$FramePosesTableCreateCompanionBuilder,
          $$FramePosesTableUpdateCompanionBuilder,
          (FramePose, $$FramePosesTableReferences),
          FramePose,
          PrefetchHooks Function({bool poseId})
        > {
  $$FramePosesTableTableManager(_$SceneGroup db, $FramePosesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FramePosesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FramePosesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FramePosesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> frameScenePartId = const Value.absent(),
                Value<int?> poseId = const Value.absent(),
                Value<double> order = const Value.absent(),
              }) => FramePosesCompanion(
                id: id,
                frameScenePartId: frameScenePartId,
                poseId: poseId,
                order: order,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int frameScenePartId,
                Value<int?> poseId = const Value.absent(),
                required double order,
              }) => FramePosesCompanion.insert(
                id: id,
                frameScenePartId: frameScenePartId,
                poseId: poseId,
                order: order,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FramePosesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({poseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (poseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.poseId,
                                referencedTable: $$FramePosesTableReferences
                                    ._poseIdTable(db),
                                referencedColumn: $$FramePosesTableReferences
                                    ._poseIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FramePosesTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $FramePosesTable,
      FramePose,
      $$FramePosesTableFilterComposer,
      $$FramePosesTableOrderingComposer,
      $$FramePosesTableAnnotationComposer,
      $$FramePosesTableCreateCompanionBuilder,
      $$FramePosesTableUpdateCompanionBuilder,
      (FramePose, $$FramePosesTableReferences),
      FramePose,
      PrefetchHooks Function({bool poseId})
    >;
typedef $$ChoicesTableCreateCompanionBuilder =
    ChoicesCompanion Function({Value<int> id, required String name});
typedef $$ChoicesTableUpdateCompanionBuilder =
    ChoicesCompanion Function({Value<int> id, Value<String> name});

final class $$ChoicesTableReferences
    extends BaseReferences<_$SceneGroup, $ChoicesTable, Choice> {
  $$ChoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FrameChoicesTable, List<FrameChoice>>
  _frameChoicesRefsTable(_$SceneGroup db) => MultiTypedResultKey.fromTable(
    db.frameChoices,
    aliasName: $_aliasNameGenerator(db.choices.id, db.frameChoices.choiceId),
  );

  $$FrameChoicesTableProcessedTableManager get frameChoicesRefs {
    final manager = $$FrameChoicesTableTableManager(
      $_db,
      $_db.frameChoices,
    ).filter((f) => f.choiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_frameChoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChoiceOptionsTable, List<ChoiceOption>>
  _choiceOptionsRefsTable(_$SceneGroup db) => MultiTypedResultKey.fromTable(
    db.choiceOptions,
    aliasName: $_aliasNameGenerator(db.choices.id, db.choiceOptions.choiceId),
  );

  $$ChoiceOptionsTableProcessedTableManager get choiceOptionsRefs {
    final manager = $$ChoiceOptionsTableTableManager(
      $_db,
      $_db.choiceOptions,
    ).filter((f) => f.choiceId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_choiceOptionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChoicesTableFilterComposer
    extends Composer<_$SceneGroup, $ChoicesTable> {
  $$ChoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> frameChoicesRefs(
    Expression<bool> Function($$FrameChoicesTableFilterComposer f) f,
  ) {
    final $$FrameChoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.frameChoices,
      getReferencedColumn: (t) => t.choiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FrameChoicesTableFilterComposer(
            $db: $db,
            $table: $db.frameChoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> choiceOptionsRefs(
    Expression<bool> Function($$ChoiceOptionsTableFilterComposer f) f,
  ) {
    final $$ChoiceOptionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.choiceOptions,
      getReferencedColumn: (t) => t.choiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChoiceOptionsTableFilterComposer(
            $db: $db,
            $table: $db.choiceOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChoicesTableOrderingComposer
    extends Composer<_$SceneGroup, $ChoicesTable> {
  $$ChoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChoicesTableAnnotationComposer
    extends Composer<_$SceneGroup, $ChoicesTable> {
  $$ChoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> frameChoicesRefs<T extends Object>(
    Expression<T> Function($$FrameChoicesTableAnnotationComposer a) f,
  ) {
    final $$FrameChoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.frameChoices,
      getReferencedColumn: (t) => t.choiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FrameChoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.frameChoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> choiceOptionsRefs<T extends Object>(
    Expression<T> Function($$ChoiceOptionsTableAnnotationComposer a) f,
  ) {
    final $$ChoiceOptionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.choiceOptions,
      getReferencedColumn: (t) => t.choiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChoiceOptionsTableAnnotationComposer(
            $db: $db,
            $table: $db.choiceOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChoicesTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $ChoicesTable,
          Choice,
          $$ChoicesTableFilterComposer,
          $$ChoicesTableOrderingComposer,
          $$ChoicesTableAnnotationComposer,
          $$ChoicesTableCreateCompanionBuilder,
          $$ChoicesTableUpdateCompanionBuilder,
          (Choice, $$ChoicesTableReferences),
          Choice,
          PrefetchHooks Function({
            bool frameChoicesRefs,
            bool choiceOptionsRefs,
          })
        > {
  $$ChoicesTableTableManager(_$SceneGroup db, $ChoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => ChoicesCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  ChoicesCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({frameChoicesRefs = false, choiceOptionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (frameChoicesRefs) db.frameChoices,
                    if (choiceOptionsRefs) db.choiceOptions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (frameChoicesRefs)
                        await $_getPrefetchedData<
                          Choice,
                          $ChoicesTable,
                          FrameChoice
                        >(
                          currentTable: table,
                          referencedTable: $$ChoicesTableReferences
                              ._frameChoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).frameChoicesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.choiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (choiceOptionsRefs)
                        await $_getPrefetchedData<
                          Choice,
                          $ChoicesTable,
                          ChoiceOption
                        >(
                          currentTable: table,
                          referencedTable: $$ChoicesTableReferences
                              ._choiceOptionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).choiceOptionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.choiceId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ChoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $ChoicesTable,
      Choice,
      $$ChoicesTableFilterComposer,
      $$ChoicesTableOrderingComposer,
      $$ChoicesTableAnnotationComposer,
      $$ChoicesTableCreateCompanionBuilder,
      $$ChoicesTableUpdateCompanionBuilder,
      (Choice, $$ChoicesTableReferences),
      Choice,
      PrefetchHooks Function({bool frameChoicesRefs, bool choiceOptionsRefs})
    >;
typedef $$FrameChoicesTableCreateCompanionBuilder =
    FrameChoicesCompanion Function({
      Value<int> frameScenePartId,
      Value<int?> choiceId,
    });
typedef $$FrameChoicesTableUpdateCompanionBuilder =
    FrameChoicesCompanion Function({
      Value<int> frameScenePartId,
      Value<int?> choiceId,
    });

final class $$FrameChoicesTableReferences
    extends BaseReferences<_$SceneGroup, $FrameChoicesTable, FrameChoice> {
  $$FrameChoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChoicesTable _choiceIdTable(_$SceneGroup db) =>
      db.choices.createAlias(
        $_aliasNameGenerator(db.frameChoices.choiceId, db.choices.id),
      );

  $$ChoicesTableProcessedTableManager? get choiceId {
    final $_column = $_itemColumn<int>('choice_id');
    if ($_column == null) return null;
    final manager = $$ChoicesTableTableManager(
      $_db,
      $_db.choices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_choiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FrameChoicesTableFilterComposer
    extends Composer<_$SceneGroup, $FrameChoicesTable> {
  $$FrameChoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ChoicesTableFilterComposer get choiceId {
    final $$ChoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.choiceId,
      referencedTable: $db.choices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChoicesTableFilterComposer(
            $db: $db,
            $table: $db.choices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FrameChoicesTableOrderingComposer
    extends Composer<_$SceneGroup, $FrameChoicesTable> {
  $$FrameChoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ChoicesTableOrderingComposer get choiceId {
    final $$ChoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.choiceId,
      referencedTable: $db.choices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChoicesTableOrderingComposer(
            $db: $db,
            $table: $db.choices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FrameChoicesTableAnnotationComposer
    extends Composer<_$SceneGroup, $FrameChoicesTable> {
  $$FrameChoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ChoicesTableAnnotationComposer get choiceId {
    final $$ChoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.choiceId,
      referencedTable: $db.choices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.choices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FrameChoicesTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $FrameChoicesTable,
          FrameChoice,
          $$FrameChoicesTableFilterComposer,
          $$FrameChoicesTableOrderingComposer,
          $$FrameChoicesTableAnnotationComposer,
          $$FrameChoicesTableCreateCompanionBuilder,
          $$FrameChoicesTableUpdateCompanionBuilder,
          (FrameChoice, $$FrameChoicesTableReferences),
          FrameChoice,
          PrefetchHooks Function({bool choiceId})
        > {
  $$FrameChoicesTableTableManager(_$SceneGroup db, $FrameChoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FrameChoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FrameChoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FrameChoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> frameScenePartId = const Value.absent(),
                Value<int?> choiceId = const Value.absent(),
              }) => FrameChoicesCompanion(
                frameScenePartId: frameScenePartId,
                choiceId: choiceId,
              ),
          createCompanionCallback:
              ({
                Value<int> frameScenePartId = const Value.absent(),
                Value<int?> choiceId = const Value.absent(),
              }) => FrameChoicesCompanion.insert(
                frameScenePartId: frameScenePartId,
                choiceId: choiceId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FrameChoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({choiceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (choiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.choiceId,
                                referencedTable: $$FrameChoicesTableReferences
                                    ._choiceIdTable(db),
                                referencedColumn: $$FrameChoicesTableReferences
                                    ._choiceIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FrameChoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $FrameChoicesTable,
      FrameChoice,
      $$FrameChoicesTableFilterComposer,
      $$FrameChoicesTableOrderingComposer,
      $$FrameChoicesTableAnnotationComposer,
      $$FrameChoicesTableCreateCompanionBuilder,
      $$FrameChoicesTableUpdateCompanionBuilder,
      (FrameChoice, $$FrameChoicesTableReferences),
      FrameChoice,
      PrefetchHooks Function({bool choiceId})
    >;
typedef $$BackgroundImagesTableCreateCompanionBuilder =
    BackgroundImagesCompanion Function({
      Value<int> metadataId,
      required Uint8List imageData,
    });
typedef $$BackgroundImagesTableUpdateCompanionBuilder =
    BackgroundImagesCompanion Function({
      Value<int> metadataId,
      Value<Uint8List> imageData,
    });

final class $$BackgroundImagesTableReferences
    extends
        BaseReferences<_$SceneGroup, $BackgroundImagesTable, BackgroundImage> {
  $$BackgroundImagesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BackgroundMetadatasTable _metadataIdTable(_$SceneGroup db) =>
      db.backgroundMetadatas.createAlias(
        $_aliasNameGenerator(
          db.backgroundImages.metadataId,
          db.backgroundMetadatas.id,
        ),
      );

  $$BackgroundMetadatasTableProcessedTableManager get metadataId {
    final $_column = $_itemColumn<int>('metadata_id')!;

    final manager = $$BackgroundMetadatasTableTableManager(
      $_db,
      $_db.backgroundMetadatas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_metadataIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BackgroundImagesTableFilterComposer
    extends Composer<_$SceneGroup, $BackgroundImagesTable> {
  $$BackgroundImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<Uint8List> get imageData => $composableBuilder(
    column: $table.imageData,
    builder: (column) => ColumnFilters(column),
  );

  $$BackgroundMetadatasTableFilterComposer get metadataId {
    final $$BackgroundMetadatasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metadataId,
      referencedTable: $db.backgroundMetadatas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BackgroundMetadatasTableFilterComposer(
            $db: $db,
            $table: $db.backgroundMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BackgroundImagesTableOrderingComposer
    extends Composer<_$SceneGroup, $BackgroundImagesTable> {
  $$BackgroundImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<Uint8List> get imageData => $composableBuilder(
    column: $table.imageData,
    builder: (column) => ColumnOrderings(column),
  );

  $$BackgroundMetadatasTableOrderingComposer get metadataId {
    final $$BackgroundMetadatasTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.metadataId,
          referencedTable: $db.backgroundMetadatas,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BackgroundMetadatasTableOrderingComposer(
                $db: $db,
                $table: $db.backgroundMetadatas,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$BackgroundImagesTableAnnotationComposer
    extends Composer<_$SceneGroup, $BackgroundImagesTable> {
  $$BackgroundImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<Uint8List> get imageData =>
      $composableBuilder(column: $table.imageData, builder: (column) => column);

  $$BackgroundMetadatasTableAnnotationComposer get metadataId {
    final $$BackgroundMetadatasTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.metadataId,
          referencedTable: $db.backgroundMetadatas,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BackgroundMetadatasTableAnnotationComposer(
                $db: $db,
                $table: $db.backgroundMetadatas,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$BackgroundImagesTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $BackgroundImagesTable,
          BackgroundImage,
          $$BackgroundImagesTableFilterComposer,
          $$BackgroundImagesTableOrderingComposer,
          $$BackgroundImagesTableAnnotationComposer,
          $$BackgroundImagesTableCreateCompanionBuilder,
          $$BackgroundImagesTableUpdateCompanionBuilder,
          (BackgroundImage, $$BackgroundImagesTableReferences),
          BackgroundImage,
          PrefetchHooks Function({bool metadataId})
        > {
  $$BackgroundImagesTableTableManager(
    _$SceneGroup db,
    $BackgroundImagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackgroundImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BackgroundImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BackgroundImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> metadataId = const Value.absent(),
                Value<Uint8List> imageData = const Value.absent(),
              }) => BackgroundImagesCompanion(
                metadataId: metadataId,
                imageData: imageData,
              ),
          createCompanionCallback:
              ({
                Value<int> metadataId = const Value.absent(),
                required Uint8List imageData,
              }) => BackgroundImagesCompanion.insert(
                metadataId: metadataId,
                imageData: imageData,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BackgroundImagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({metadataId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (metadataId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.metadataId,
                                referencedTable:
                                    $$BackgroundImagesTableReferences
                                        ._metadataIdTable(db),
                                referencedColumn:
                                    $$BackgroundImagesTableReferences
                                        ._metadataIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BackgroundImagesTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $BackgroundImagesTable,
      BackgroundImage,
      $$BackgroundImagesTableFilterComposer,
      $$BackgroundImagesTableOrderingComposer,
      $$BackgroundImagesTableAnnotationComposer,
      $$BackgroundImagesTableCreateCompanionBuilder,
      $$BackgroundImagesTableUpdateCompanionBuilder,
      (BackgroundImage, $$BackgroundImagesTableReferences),
      BackgroundImage,
      PrefetchHooks Function({bool metadataId})
    >;
typedef $$PoseImagesTableCreateCompanionBuilder =
    PoseImagesCompanion Function({
      Value<int> metadataId,
      required Uint8List imageData,
    });
typedef $$PoseImagesTableUpdateCompanionBuilder =
    PoseImagesCompanion Function({
      Value<int> metadataId,
      Value<Uint8List> imageData,
    });

final class $$PoseImagesTableReferences
    extends BaseReferences<_$SceneGroup, $PoseImagesTable, PoseImage> {
  $$PoseImagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PoseMetadatasTable _metadataIdTable(_$SceneGroup db) =>
      db.poseMetadatas.createAlias(
        $_aliasNameGenerator(db.poseImages.metadataId, db.poseMetadatas.id),
      );

  $$PoseMetadatasTableProcessedTableManager get metadataId {
    final $_column = $_itemColumn<int>('metadata_id')!;

    final manager = $$PoseMetadatasTableTableManager(
      $_db,
      $_db.poseMetadatas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_metadataIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PoseImagesTableFilterComposer
    extends Composer<_$SceneGroup, $PoseImagesTable> {
  $$PoseImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<Uint8List> get imageData => $composableBuilder(
    column: $table.imageData,
    builder: (column) => ColumnFilters(column),
  );

  $$PoseMetadatasTableFilterComposer get metadataId {
    final $$PoseMetadatasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metadataId,
      referencedTable: $db.poseMetadatas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PoseMetadatasTableFilterComposer(
            $db: $db,
            $table: $db.poseMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PoseImagesTableOrderingComposer
    extends Composer<_$SceneGroup, $PoseImagesTable> {
  $$PoseImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<Uint8List> get imageData => $composableBuilder(
    column: $table.imageData,
    builder: (column) => ColumnOrderings(column),
  );

  $$PoseMetadatasTableOrderingComposer get metadataId {
    final $$PoseMetadatasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metadataId,
      referencedTable: $db.poseMetadatas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PoseMetadatasTableOrderingComposer(
            $db: $db,
            $table: $db.poseMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PoseImagesTableAnnotationComposer
    extends Composer<_$SceneGroup, $PoseImagesTable> {
  $$PoseImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<Uint8List> get imageData =>
      $composableBuilder(column: $table.imageData, builder: (column) => column);

  $$PoseMetadatasTableAnnotationComposer get metadataId {
    final $$PoseMetadatasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.metadataId,
      referencedTable: $db.poseMetadatas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PoseMetadatasTableAnnotationComposer(
            $db: $db,
            $table: $db.poseMetadatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PoseImagesTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $PoseImagesTable,
          PoseImage,
          $$PoseImagesTableFilterComposer,
          $$PoseImagesTableOrderingComposer,
          $$PoseImagesTableAnnotationComposer,
          $$PoseImagesTableCreateCompanionBuilder,
          $$PoseImagesTableUpdateCompanionBuilder,
          (PoseImage, $$PoseImagesTableReferences),
          PoseImage,
          PrefetchHooks Function({bool metadataId})
        > {
  $$PoseImagesTableTableManager(_$SceneGroup db, $PoseImagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PoseImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PoseImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PoseImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> metadataId = const Value.absent(),
                Value<Uint8List> imageData = const Value.absent(),
              }) => PoseImagesCompanion(
                metadataId: metadataId,
                imageData: imageData,
              ),
          createCompanionCallback:
              ({
                Value<int> metadataId = const Value.absent(),
                required Uint8List imageData,
              }) => PoseImagesCompanion.insert(
                metadataId: metadataId,
                imageData: imageData,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PoseImagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({metadataId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (metadataId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.metadataId,
                                referencedTable: $$PoseImagesTableReferences
                                    ._metadataIdTable(db),
                                referencedColumn: $$PoseImagesTableReferences
                                    ._metadataIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PoseImagesTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $PoseImagesTable,
      PoseImage,
      $$PoseImagesTableFilterComposer,
      $$PoseImagesTableOrderingComposer,
      $$PoseImagesTableAnnotationComposer,
      $$PoseImagesTableCreateCompanionBuilder,
      $$PoseImagesTableUpdateCompanionBuilder,
      (PoseImage, $$PoseImagesTableReferences),
      PoseImage,
      PrefetchHooks Function({bool metadataId})
    >;
typedef $$ChoiceOptionsTableCreateCompanionBuilder =
    ChoiceOptionsCompanion Function({
      Value<int> id,
      required String name,
      required int choiceId,
      Value<bool> isSelected,
    });
typedef $$ChoiceOptionsTableUpdateCompanionBuilder =
    ChoiceOptionsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> choiceId,
      Value<bool> isSelected,
    });

final class $$ChoiceOptionsTableReferences
    extends BaseReferences<_$SceneGroup, $ChoiceOptionsTable, ChoiceOption> {
  $$ChoiceOptionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ChoicesTable _choiceIdTable(_$SceneGroup db) =>
      db.choices.createAlias(
        $_aliasNameGenerator(db.choiceOptions.choiceId, db.choices.id),
      );

  $$ChoicesTableProcessedTableManager get choiceId {
    final $_column = $_itemColumn<int>('choice_id')!;

    final manager = $$ChoicesTableTableManager(
      $_db,
      $_db.choices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_choiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChoiceOptionsTableFilterComposer
    extends Composer<_$SceneGroup, $ChoiceOptionsTable> {
  $$ChoiceOptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => ColumnFilters(column),
  );

  $$ChoicesTableFilterComposer get choiceId {
    final $$ChoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.choiceId,
      referencedTable: $db.choices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChoicesTableFilterComposer(
            $db: $db,
            $table: $db.choices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChoiceOptionsTableOrderingComposer
    extends Composer<_$SceneGroup, $ChoiceOptionsTable> {
  $$ChoiceOptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChoicesTableOrderingComposer get choiceId {
    final $$ChoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.choiceId,
      referencedTable: $db.choices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChoicesTableOrderingComposer(
            $db: $db,
            $table: $db.choices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChoiceOptionsTableAnnotationComposer
    extends Composer<_$SceneGroup, $ChoiceOptionsTable> {
  $$ChoiceOptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isSelected => $composableBuilder(
    column: $table.isSelected,
    builder: (column) => column,
  );

  $$ChoicesTableAnnotationComposer get choiceId {
    final $$ChoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.choiceId,
      referencedTable: $db.choices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.choices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChoiceOptionsTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $ChoiceOptionsTable,
          ChoiceOption,
          $$ChoiceOptionsTableFilterComposer,
          $$ChoiceOptionsTableOrderingComposer,
          $$ChoiceOptionsTableAnnotationComposer,
          $$ChoiceOptionsTableCreateCompanionBuilder,
          $$ChoiceOptionsTableUpdateCompanionBuilder,
          (ChoiceOption, $$ChoiceOptionsTableReferences),
          ChoiceOption,
          PrefetchHooks Function({bool choiceId})
        > {
  $$ChoiceOptionsTableTableManager(_$SceneGroup db, $ChoiceOptionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChoiceOptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChoiceOptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChoiceOptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> choiceId = const Value.absent(),
                Value<bool> isSelected = const Value.absent(),
              }) => ChoiceOptionsCompanion(
                id: id,
                name: name,
                choiceId: choiceId,
                isSelected: isSelected,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required int choiceId,
                Value<bool> isSelected = const Value.absent(),
              }) => ChoiceOptionsCompanion.insert(
                id: id,
                name: name,
                choiceId: choiceId,
                isSelected: isSelected,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChoiceOptionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({choiceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (choiceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.choiceId,
                                referencedTable: $$ChoiceOptionsTableReferences
                                    ._choiceIdTable(db),
                                referencedColumn: $$ChoiceOptionsTableReferences
                                    ._choiceIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChoiceOptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $ChoiceOptionsTable,
      ChoiceOption,
      $$ChoiceOptionsTableFilterComposer,
      $$ChoiceOptionsTableOrderingComposer,
      $$ChoiceOptionsTableAnnotationComposer,
      $$ChoiceOptionsTableCreateCompanionBuilder,
      $$ChoiceOptionsTableUpdateCompanionBuilder,
      (ChoiceOption, $$ChoiceOptionsTableReferences),
      ChoiceOption,
      PrefetchHooks Function({bool choiceId})
    >;
typedef $$DialogueBoxesTableCreateCompanionBuilder =
    DialogueBoxesCompanion Function({
      Value<int> frameScenePartId,
      Value<String?> name,
      required String dialogue,
    });
typedef $$DialogueBoxesTableUpdateCompanionBuilder =
    DialogueBoxesCompanion Function({
      Value<int> frameScenePartId,
      Value<String?> name,
      Value<String> dialogue,
    });

class $$DialogueBoxesTableFilterComposer
    extends Composer<_$SceneGroup, $DialogueBoxesTable> {
  $$DialogueBoxesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dialogue => $composableBuilder(
    column: $table.dialogue,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DialogueBoxesTableOrderingComposer
    extends Composer<_$SceneGroup, $DialogueBoxesTable> {
  $$DialogueBoxesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dialogue => $composableBuilder(
    column: $table.dialogue,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DialogueBoxesTableAnnotationComposer
    extends Composer<_$SceneGroup, $DialogueBoxesTable> {
  $$DialogueBoxesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get dialogue =>
      $composableBuilder(column: $table.dialogue, builder: (column) => column);
}

class $$DialogueBoxesTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $DialogueBoxesTable,
          DialogueBox,
          $$DialogueBoxesTableFilterComposer,
          $$DialogueBoxesTableOrderingComposer,
          $$DialogueBoxesTableAnnotationComposer,
          $$DialogueBoxesTableCreateCompanionBuilder,
          $$DialogueBoxesTableUpdateCompanionBuilder,
          (
            DialogueBox,
            BaseReferences<_$SceneGroup, $DialogueBoxesTable, DialogueBox>,
          ),
          DialogueBox,
          PrefetchHooks Function()
        > {
  $$DialogueBoxesTableTableManager(_$SceneGroup db, $DialogueBoxesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DialogueBoxesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DialogueBoxesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DialogueBoxesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> frameScenePartId = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String> dialogue = const Value.absent(),
              }) => DialogueBoxesCompanion(
                frameScenePartId: frameScenePartId,
                name: name,
                dialogue: dialogue,
              ),
          createCompanionCallback:
              ({
                Value<int> frameScenePartId = const Value.absent(),
                Value<String?> name = const Value.absent(),
                required String dialogue,
              }) => DialogueBoxesCompanion.insert(
                frameScenePartId: frameScenePartId,
                name: name,
                dialogue: dialogue,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DialogueBoxesTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $DialogueBoxesTable,
      DialogueBox,
      $$DialogueBoxesTableFilterComposer,
      $$DialogueBoxesTableOrderingComposer,
      $$DialogueBoxesTableAnnotationComposer,
      $$DialogueBoxesTableCreateCompanionBuilder,
      $$DialogueBoxesTableUpdateCompanionBuilder,
      (
        DialogueBox,
        BaseReferences<_$SceneGroup, $DialogueBoxesTable, DialogueBox>,
      ),
      DialogueBox,
      PrefetchHooks Function()
    >;

class $SceneGroupManager {
  final _$SceneGroup _db;
  $SceneGroupManager(this._db);
  $$ScenesTableTableManager get scenes =>
      $$ScenesTableTableManager(_db, _db.scenes);
  $$ScenePartsTableTableManager get sceneParts =>
      $$ScenePartsTableTableManager(_db, _db.sceneParts);
  $$PlacesTableTableManager get places =>
      $$PlacesTableTableManager(_db, _db.places);
  $$BackgroundMetadatasTableTableManager get backgroundMetadatas =>
      $$BackgroundMetadatasTableTableManager(_db, _db.backgroundMetadatas);
  $$FramesTableTableManager get frames =>
      $$FramesTableTableManager(_db, _db.frames);
  $$ScenePartResolversTableTableManager get scenePartResolvers =>
      $$ScenePartResolversTableTableManager(_db, _db.scenePartResolvers);
  $$CustomScenePartsTableTableManager get customSceneParts =>
      $$CustomScenePartsTableTableManager(_db, _db.customSceneParts);
  $$ActorsTableTableManager get actors =>
      $$ActorsTableTableManager(_db, _db.actors);
  $$PoseMetadatasTableTableManager get poseMetadatas =>
      $$PoseMetadatasTableTableManager(_db, _db.poseMetadatas);
  $$FramePosesTableTableManager get framePoses =>
      $$FramePosesTableTableManager(_db, _db.framePoses);
  $$ChoicesTableTableManager get choices =>
      $$ChoicesTableTableManager(_db, _db.choices);
  $$FrameChoicesTableTableManager get frameChoices =>
      $$FrameChoicesTableTableManager(_db, _db.frameChoices);
  $$BackgroundImagesTableTableManager get backgroundImages =>
      $$BackgroundImagesTableTableManager(_db, _db.backgroundImages);
  $$PoseImagesTableTableManager get poseImages =>
      $$PoseImagesTableTableManager(_db, _db.poseImages);
  $$ChoiceOptionsTableTableManager get choiceOptions =>
      $$ChoiceOptionsTableTableManager(_db, _db.choiceOptions);
  $$DialogueBoxesTableTableManager get dialogueBoxes =>
      $$DialogueBoxesTableTableManager(_db, _db.dialogueBoxes);
}
