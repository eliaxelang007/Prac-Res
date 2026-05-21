// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// ignore_for_file: type=lint
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

class Place extends DataClass implements Insertable<Place> {
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

class $BackgroundsTable extends Backgrounds
    with TableInfo<$BackgroundsTable, Background> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackgroundsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _placeIdMeta = const VerificationMeta(
    'placeId',
  );
  @override
  late final GeneratedColumn<int> placeId = GeneratedColumn<int>(
    'place_id',
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
  List<GeneratedColumn> get $columns => [id, placeId, name, imageData];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'backgrounds';
  @override
  VerificationContext validateIntegrity(
    Insertable<Background> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('place_id')) {
      context.handle(
        _placeIdMeta,
        placeId.isAcceptableOrUnknown(data['place_id']!, _placeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_placeIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Background map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Background(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      placeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}place_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      imageData: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}image_data'],
      )!,
    );
  }

  @override
  $BackgroundsTable createAlias(String alias) {
    return $BackgroundsTable(attachedDatabase, alias);
  }
}

class Background extends DataClass implements Insertable<Background> {
  final int id;
  final int placeId;
  final String name;
  final Uint8List imageData;
  const Background({
    required this.id,
    required this.placeId,
    required this.name,
    required this.imageData,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['place_id'] = Variable<int>(placeId);
    map['name'] = Variable<String>(name);
    map['image_data'] = Variable<Uint8List>(imageData);
    return map;
  }

  BackgroundsCompanion toCompanion(bool nullToAbsent) {
    return BackgroundsCompanion(
      id: Value(id),
      placeId: Value(placeId),
      name: Value(name),
      imageData: Value(imageData),
    );
  }

  factory Background.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Background(
      id: serializer.fromJson<int>(json['id']),
      placeId: serializer.fromJson<int>(json['placeId']),
      name: serializer.fromJson<String>(json['name']),
      imageData: serializer.fromJson<Uint8List>(json['imageData']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'placeId': serializer.toJson<int>(placeId),
      'name': serializer.toJson<String>(name),
      'imageData': serializer.toJson<Uint8List>(imageData),
    };
  }

  Background copyWith({
    int? id,
    int? placeId,
    String? name,
    Uint8List? imageData,
  }) => Background(
    id: id ?? this.id,
    placeId: placeId ?? this.placeId,
    name: name ?? this.name,
    imageData: imageData ?? this.imageData,
  );
  Background copyWithCompanion(BackgroundsCompanion data) {
    return Background(
      id: data.id.present ? data.id.value : this.id,
      placeId: data.placeId.present ? data.placeId.value : this.placeId,
      name: data.name.present ? data.name.value : this.name,
      imageData: data.imageData.present ? data.imageData.value : this.imageData,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Background(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('name: $name, ')
          ..write('imageData: $imageData')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, placeId, name, $driftBlobEquality.hash(imageData));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Background &&
          other.id == this.id &&
          other.placeId == this.placeId &&
          other.name == this.name &&
          $driftBlobEquality.equals(other.imageData, this.imageData));
}

class BackgroundsCompanion extends UpdateCompanion<Background> {
  final Value<int> id;
  final Value<int> placeId;
  final Value<String> name;
  final Value<Uint8List> imageData;
  const BackgroundsCompanion({
    this.id = const Value.absent(),
    this.placeId = const Value.absent(),
    this.name = const Value.absent(),
    this.imageData = const Value.absent(),
  });
  BackgroundsCompanion.insert({
    this.id = const Value.absent(),
    required int placeId,
    required String name,
    required Uint8List imageData,
  }) : placeId = Value(placeId),
       name = Value(name),
       imageData = Value(imageData);
  static Insertable<Background> custom({
    Expression<int>? id,
    Expression<int>? placeId,
    Expression<String>? name,
    Expression<Uint8List>? imageData,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (placeId != null) 'place_id': placeId,
      if (name != null) 'name': name,
      if (imageData != null) 'image_data': imageData,
    });
  }

  BackgroundsCompanion copyWith({
    Value<int>? id,
    Value<int>? placeId,
    Value<String>? name,
    Value<Uint8List>? imageData,
  }) {
    return BackgroundsCompanion(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      imageData: imageData ?? this.imageData,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (placeId.present) {
      map['place_id'] = Variable<int>(placeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageData.present) {
      map['image_data'] = Variable<Uint8List>(imageData.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackgroundsCompanion(')
          ..write('id: $id, ')
          ..write('placeId: $placeId, ')
          ..write('name: $name, ')
          ..write('imageData: $imageData')
          ..write(')'))
        .toString();
  }
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

class Actor extends DataClass implements Insertable<Actor> {
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

class $PosesTable extends Poses with TableInfo<$PosesTable, Pose> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PosesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _actorIdMeta = const VerificationMeta(
    'actorId',
  );
  @override
  late final GeneratedColumn<int> actorId = GeneratedColumn<int>(
    'actor_id',
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
  List<GeneratedColumn> get $columns => [id, actorId, name, imageData];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'poses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pose> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('actor_id')) {
      context.handle(
        _actorIdMeta,
        actorId.isAcceptableOrUnknown(data['actor_id']!, _actorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_actorIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pose map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pose(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      actorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actor_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      imageData: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}image_data'],
      )!,
    );
  }

  @override
  $PosesTable createAlias(String alias) {
    return $PosesTable(attachedDatabase, alias);
  }
}

class Pose extends DataClass implements Insertable<Pose> {
  final int id;
  final int actorId;
  final String name;
  final Uint8List imageData;
  const Pose({
    required this.id,
    required this.actorId,
    required this.name,
    required this.imageData,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['actor_id'] = Variable<int>(actorId);
    map['name'] = Variable<String>(name);
    map['image_data'] = Variable<Uint8List>(imageData);
    return map;
  }

  PosesCompanion toCompanion(bool nullToAbsent) {
    return PosesCompanion(
      id: Value(id),
      actorId: Value(actorId),
      name: Value(name),
      imageData: Value(imageData),
    );
  }

  factory Pose.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pose(
      id: serializer.fromJson<int>(json['id']),
      actorId: serializer.fromJson<int>(json['actorId']),
      name: serializer.fromJson<String>(json['name']),
      imageData: serializer.fromJson<Uint8List>(json['imageData']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'actorId': serializer.toJson<int>(actorId),
      'name': serializer.toJson<String>(name),
      'imageData': serializer.toJson<Uint8List>(imageData),
    };
  }

  Pose copyWith({int? id, int? actorId, String? name, Uint8List? imageData}) =>
      Pose(
        id: id ?? this.id,
        actorId: actorId ?? this.actorId,
        name: name ?? this.name,
        imageData: imageData ?? this.imageData,
      );
  Pose copyWithCompanion(PosesCompanion data) {
    return Pose(
      id: data.id.present ? data.id.value : this.id,
      actorId: data.actorId.present ? data.actorId.value : this.actorId,
      name: data.name.present ? data.name.value : this.name,
      imageData: data.imageData.present ? data.imageData.value : this.imageData,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pose(')
          ..write('id: $id, ')
          ..write('actorId: $actorId, ')
          ..write('name: $name, ')
          ..write('imageData: $imageData')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, actorId, name, $driftBlobEquality.hash(imageData));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pose &&
          other.id == this.id &&
          other.actorId == this.actorId &&
          other.name == this.name &&
          $driftBlobEquality.equals(other.imageData, this.imageData));
}

class PosesCompanion extends UpdateCompanion<Pose> {
  final Value<int> id;
  final Value<int> actorId;
  final Value<String> name;
  final Value<Uint8List> imageData;
  const PosesCompanion({
    this.id = const Value.absent(),
    this.actorId = const Value.absent(),
    this.name = const Value.absent(),
    this.imageData = const Value.absent(),
  });
  PosesCompanion.insert({
    this.id = const Value.absent(),
    required int actorId,
    required String name,
    required Uint8List imageData,
  }) : actorId = Value(actorId),
       name = Value(name),
       imageData = Value(imageData);
  static Insertable<Pose> custom({
    Expression<int>? id,
    Expression<int>? actorId,
    Expression<String>? name,
    Expression<Uint8List>? imageData,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (actorId != null) 'actor_id': actorId,
      if (name != null) 'name': name,
      if (imageData != null) 'image_data': imageData,
    });
  }

  PosesCompanion copyWith({
    Value<int>? id,
    Value<int>? actorId,
    Value<String>? name,
    Value<Uint8List>? imageData,
  }) {
    return PosesCompanion(
      id: id ?? this.id,
      actorId: actorId ?? this.actorId,
      name: name ?? this.name,
      imageData: imageData ?? this.imageData,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (actorId.present) {
      map['actor_id'] = Variable<int>(actorId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageData.present) {
      map['image_data'] = Variable<Uint8List>(imageData.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PosesCompanion(')
          ..write('id: $id, ')
          ..write('actorId: $actorId, ')
          ..write('name: $name, ')
          ..write('imageData: $imageData')
          ..write(')'))
        .toString();
  }
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
  static const VerificationMeta _optionTextMeta = const VerificationMeta(
    'optionText',
  );
  @override
  late final GeneratedColumn<String> optionText = GeneratedColumn<String>(
    'option_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isSelectedMeta = const VerificationMeta(
    'isSelected',
  );
  @override
  late final GeneratedColumn<int> isSelected = GeneratedColumn<int>(
    'is_selected',
    aliasedName,
    false,
    check: () => isSelected.isIn([0, 1]),
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, choiceId, optionText, isSelected];
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
    if (data.containsKey('choice_id')) {
      context.handle(
        _choiceIdMeta,
        choiceId.isAcceptableOrUnknown(data['choice_id']!, _choiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_choiceIdMeta);
    }
    if (data.containsKey('option_text')) {
      context.handle(
        _optionTextMeta,
        optionText.isAcceptableOrUnknown(data['option_text']!, _optionTextMeta),
      );
    } else if (isInserting) {
      context.missing(_optionTextMeta);
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
      choiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}choice_id'],
      )!,
      optionText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}option_text'],
      )!,
      isSelected: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_selected'],
      )!,
    );
  }

  @override
  $ChoiceOptionsTable createAlias(String alias) {
    return $ChoiceOptionsTable(attachedDatabase, alias);
  }
}

class ChoiceOption extends DataClass implements Insertable<ChoiceOption> {
  final int id;
  final int choiceId;
  final String optionText;
  final int isSelected;
  const ChoiceOption({
    required this.id,
    required this.choiceId,
    required this.optionText,
    required this.isSelected,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['choice_id'] = Variable<int>(choiceId);
    map['option_text'] = Variable<String>(optionText);
    map['is_selected'] = Variable<int>(isSelected);
    return map;
  }

  ChoiceOptionsCompanion toCompanion(bool nullToAbsent) {
    return ChoiceOptionsCompanion(
      id: Value(id),
      choiceId: Value(choiceId),
      optionText: Value(optionText),
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
      choiceId: serializer.fromJson<int>(json['choiceId']),
      optionText: serializer.fromJson<String>(json['optionText']),
      isSelected: serializer.fromJson<int>(json['isSelected']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'choiceId': serializer.toJson<int>(choiceId),
      'optionText': serializer.toJson<String>(optionText),
      'isSelected': serializer.toJson<int>(isSelected),
    };
  }

  ChoiceOption copyWith({
    int? id,
    int? choiceId,
    String? optionText,
    int? isSelected,
  }) => ChoiceOption(
    id: id ?? this.id,
    choiceId: choiceId ?? this.choiceId,
    optionText: optionText ?? this.optionText,
    isSelected: isSelected ?? this.isSelected,
  );
  ChoiceOption copyWithCompanion(ChoiceOptionsCompanion data) {
    return ChoiceOption(
      id: data.id.present ? data.id.value : this.id,
      choiceId: data.choiceId.present ? data.choiceId.value : this.choiceId,
      optionText: data.optionText.present
          ? data.optionText.value
          : this.optionText,
      isSelected: data.isSelected.present
          ? data.isSelected.value
          : this.isSelected,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChoiceOption(')
          ..write('id: $id, ')
          ..write('choiceId: $choiceId, ')
          ..write('optionText: $optionText, ')
          ..write('isSelected: $isSelected')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, choiceId, optionText, isSelected);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChoiceOption &&
          other.id == this.id &&
          other.choiceId == this.choiceId &&
          other.optionText == this.optionText &&
          other.isSelected == this.isSelected);
}

class ChoiceOptionsCompanion extends UpdateCompanion<ChoiceOption> {
  final Value<int> id;
  final Value<int> choiceId;
  final Value<String> optionText;
  final Value<int> isSelected;
  const ChoiceOptionsCompanion({
    this.id = const Value.absent(),
    this.choiceId = const Value.absent(),
    this.optionText = const Value.absent(),
    this.isSelected = const Value.absent(),
  });
  ChoiceOptionsCompanion.insert({
    this.id = const Value.absent(),
    required int choiceId,
    required String optionText,
    this.isSelected = const Value.absent(),
  }) : choiceId = Value(choiceId),
       optionText = Value(optionText);
  static Insertable<ChoiceOption> custom({
    Expression<int>? id,
    Expression<int>? choiceId,
    Expression<String>? optionText,
    Expression<int>? isSelected,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (choiceId != null) 'choice_id': choiceId,
      if (optionText != null) 'option_text': optionText,
      if (isSelected != null) 'is_selected': isSelected,
    });
  }

  ChoiceOptionsCompanion copyWith({
    Value<int>? id,
    Value<int>? choiceId,
    Value<String>? optionText,
    Value<int>? isSelected,
  }) {
    return ChoiceOptionsCompanion(
      id: id ?? this.id,
      choiceId: choiceId ?? this.choiceId,
      optionText: optionText ?? this.optionText,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (choiceId.present) {
      map['choice_id'] = Variable<int>(choiceId.value);
    }
    if (optionText.present) {
      map['option_text'] = Variable<String>(optionText.value);
    }
    if (isSelected.present) {
      map['is_selected'] = Variable<int>(isSelected.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChoiceOptionsCompanion(')
          ..write('id: $id, ')
          ..write('choiceId: $choiceId, ')
          ..write('optionText: $optionText, ')
          ..write('isSelected: $isSelected')
          ..write(')'))
        .toString();
  }
}

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

class Scene extends DataClass implements Insertable<Scene> {
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
    check: () => partType.isIn(["frame", "resolver", "custom"]),
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
      'REFERENCES backgrounds (id) ON DELETE SET NULL',
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

class $FrameResolversTable extends FrameResolvers
    with TableInfo<$FrameResolversTable, FrameResolver> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FrameResolversTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _resolverScriptMeta = const VerificationMeta(
    'resolverScript',
  );
  @override
  late final GeneratedColumn<String> resolverScript = GeneratedColumn<String>(
    'resolver_script',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [scenePartId, resolverScript];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'frame_resolvers';
  @override
  VerificationContext validateIntegrity(
    Insertable<FrameResolver> instance, {
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
    if (data.containsKey('resolver_script')) {
      context.handle(
        _resolverScriptMeta,
        resolverScript.isAcceptableOrUnknown(
          data['resolver_script']!,
          _resolverScriptMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_resolverScriptMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {scenePartId};
  @override
  FrameResolver map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FrameResolver(
      scenePartId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scene_part_id'],
      )!,
      resolverScript: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resolver_script'],
      )!,
    );
  }

  @override
  $FrameResolversTable createAlias(String alias) {
    return $FrameResolversTable(attachedDatabase, alias);
  }
}

class FrameResolver extends DataClass implements Insertable<FrameResolver> {
  final int scenePartId;
  final String resolverScript;
  const FrameResolver({
    required this.scenePartId,
    required this.resolverScript,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['scene_part_id'] = Variable<int>(scenePartId);
    map['resolver_script'] = Variable<String>(resolverScript);
    return map;
  }

  FrameResolversCompanion toCompanion(bool nullToAbsent) {
    return FrameResolversCompanion(
      scenePartId: Value(scenePartId),
      resolverScript: Value(resolverScript),
    );
  }

  factory FrameResolver.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FrameResolver(
      scenePartId: serializer.fromJson<int>(json['scenePartId']),
      resolverScript: serializer.fromJson<String>(json['resolverScript']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'scenePartId': serializer.toJson<int>(scenePartId),
      'resolverScript': serializer.toJson<String>(resolverScript),
    };
  }

  FrameResolver copyWith({int? scenePartId, String? resolverScript}) =>
      FrameResolver(
        scenePartId: scenePartId ?? this.scenePartId,
        resolverScript: resolverScript ?? this.resolverScript,
      );
  FrameResolver copyWithCompanion(FrameResolversCompanion data) {
    return FrameResolver(
      scenePartId: data.scenePartId.present
          ? data.scenePartId.value
          : this.scenePartId,
      resolverScript: data.resolverScript.present
          ? data.resolverScript.value
          : this.resolverScript,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FrameResolver(')
          ..write('scenePartId: $scenePartId, ')
          ..write('resolverScript: $resolverScript')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(scenePartId, resolverScript);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FrameResolver &&
          other.scenePartId == this.scenePartId &&
          other.resolverScript == this.resolverScript);
}

class FrameResolversCompanion extends UpdateCompanion<FrameResolver> {
  final Value<int> scenePartId;
  final Value<String> resolverScript;
  const FrameResolversCompanion({
    this.scenePartId = const Value.absent(),
    this.resolverScript = const Value.absent(),
  });
  FrameResolversCompanion.insert({
    this.scenePartId = const Value.absent(),
    required String resolverScript,
  }) : resolverScript = Value(resolverScript);
  static Insertable<FrameResolver> custom({
    Expression<int>? scenePartId,
    Expression<String>? resolverScript,
  }) {
    return RawValuesInsertable({
      if (scenePartId != null) 'scene_part_id': scenePartId,
      if (resolverScript != null) 'resolver_script': resolverScript,
    });
  }

  FrameResolversCompanion copyWith({
    Value<int>? scenePartId,
    Value<String>? resolverScript,
  }) {
    return FrameResolversCompanion(
      scenePartId: scenePartId ?? this.scenePartId,
      resolverScript: resolverScript ?? this.resolverScript,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (scenePartId.present) {
      map['scene_part_id'] = Variable<int>(scenePartId.value);
    }
    if (resolverScript.present) {
      map['resolver_script'] = Variable<String>(resolverScript.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FrameResolversCompanion(')
          ..write('scenePartId: $scenePartId, ')
          ..write('resolverScript: $resolverScript')
          ..write(')'))
        .toString();
  }
}

class $CustomTable extends Custom with TableInfo<$CustomTable, CustomData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomTable(this.attachedDatabase, [this._alias]);
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
  static const String $name = 'custom';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomData> instance, {
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
  CustomData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomData(
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
  $CustomTable createAlias(String alias) {
    return $CustomTable(attachedDatabase, alias);
  }
}

class CustomData extends DataClass implements Insertable<CustomData> {
  final int scenePartId;
  final String eventId;
  const CustomData({required this.scenePartId, required this.eventId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['scene_part_id'] = Variable<int>(scenePartId);
    map['event_id'] = Variable<String>(eventId);
    return map;
  }

  CustomCompanion toCompanion(bool nullToAbsent) {
    return CustomCompanion(
      scenePartId: Value(scenePartId),
      eventId: Value(eventId),
    );
  }

  factory CustomData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomData(
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

  CustomData copyWith({int? scenePartId, String? eventId}) => CustomData(
    scenePartId: scenePartId ?? this.scenePartId,
    eventId: eventId ?? this.eventId,
  );
  CustomData copyWithCompanion(CustomCompanion data) {
    return CustomData(
      scenePartId: data.scenePartId.present
          ? data.scenePartId.value
          : this.scenePartId,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomData(')
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
      (other is CustomData &&
          other.scenePartId == this.scenePartId &&
          other.eventId == this.eventId);
}

class CustomCompanion extends UpdateCompanion<CustomData> {
  final Value<int> scenePartId;
  final Value<String> eventId;
  const CustomCompanion({
    this.scenePartId = const Value.absent(),
    this.eventId = const Value.absent(),
  });
  CustomCompanion.insert({
    this.scenePartId = const Value.absent(),
    required String eventId,
  }) : eventId = Value(eventId);
  static Insertable<CustomData> custom({
    Expression<int>? scenePartId,
    Expression<String>? eventId,
  }) {
    return RawValuesInsertable({
      if (scenePartId != null) 'scene_part_id': scenePartId,
      if (eventId != null) 'event_id': eventId,
    });
  }

  CustomCompanion copyWith({Value<int>? scenePartId, Value<String>? eventId}) {
    return CustomCompanion(
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
    return (StringBuffer('CustomCompanion(')
          ..write('scenePartId: $scenePartId, ')
          ..write('eventId: $eventId')
          ..write(')'))
        .toString();
  }
}

class $DialogueBoxesTable extends DialogueBoxes
    with TableInfo<$DialogueBoxesTable, DialogueBoxe> {
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
    Insertable<DialogueBoxe> instance, {
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
  DialogueBoxe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DialogueBoxe(
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

class DialogueBoxe extends DataClass implements Insertable<DialogueBoxe> {
  final int frameScenePartId;
  final String? name;
  final String dialogue;
  const DialogueBoxe({
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

  factory DialogueBoxe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DialogueBoxe(
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

  DialogueBoxe copyWith({
    int? frameScenePartId,
    Value<String?> name = const Value.absent(),
    String? dialogue,
  }) => DialogueBoxe(
    frameScenePartId: frameScenePartId ?? this.frameScenePartId,
    name: name.present ? name.value : this.name,
    dialogue: dialogue ?? this.dialogue,
  );
  DialogueBoxe copyWithCompanion(DialogueBoxesCompanion data) {
    return DialogueBoxe(
      frameScenePartId: data.frameScenePartId.present
          ? data.frameScenePartId.value
          : this.frameScenePartId,
      name: data.name.present ? data.name.value : this.name,
      dialogue: data.dialogue.present ? data.dialogue.value : this.dialogue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DialogueBoxe(')
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
      (other is DialogueBoxe &&
          other.frameScenePartId == this.frameScenePartId &&
          other.name == this.name &&
          other.dialogue == this.dialogue);
}

class DialogueBoxesCompanion extends UpdateCompanion<DialogueBoxe> {
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
  static Insertable<DialogueBoxe> custom({
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
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES poses (id) ON DELETE CASCADE',
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
    } else if (isInserting) {
      context.missing(_poseIdMeta);
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
      )!,
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
  final int poseId;
  final double order;
  const FramePose({
    required this.id,
    required this.frameScenePartId,
    required this.poseId,
    required this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['frame_scene_part_id'] = Variable<int>(frameScenePartId);
    map['pose_id'] = Variable<int>(poseId);
    map['order'] = Variable<double>(order);
    return map;
  }

  FramePosesCompanion toCompanion(bool nullToAbsent) {
    return FramePosesCompanion(
      id: Value(id),
      frameScenePartId: Value(frameScenePartId),
      poseId: Value(poseId),
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
      poseId: serializer.fromJson<int>(json['poseId']),
      order: serializer.fromJson<double>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'frameScenePartId': serializer.toJson<int>(frameScenePartId),
      'poseId': serializer.toJson<int>(poseId),
      'order': serializer.toJson<double>(order),
    };
  }

  FramePose copyWith({
    int? id,
    int? frameScenePartId,
    int? poseId,
    double? order,
  }) => FramePose(
    id: id ?? this.id,
    frameScenePartId: frameScenePartId ?? this.frameScenePartId,
    poseId: poseId ?? this.poseId,
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
  final Value<int> poseId;
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
    required int poseId,
    required double order,
  }) : frameScenePartId = Value(frameScenePartId),
       poseId = Value(poseId),
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
    Value<int>? poseId,
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

class SceneTimelineViewData extends DataClass {
  final int id;
  final int sceneId;
  final double order;
  final String partType;
  final int? backgroundId;
  final String? resolverScript;
  final String? eventId;
  const SceneTimelineViewData({
    required this.id,
    required this.sceneId,
    required this.order,
    required this.partType,
    this.backgroundId,
    this.resolverScript,
    this.eventId,
  });
  factory SceneTimelineViewData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SceneTimelineViewData(
      id: serializer.fromJson<int>(json['id']),
      sceneId: serializer.fromJson<int>(json['sceneId']),
      order: serializer.fromJson<double>(json['order']),
      partType: serializer.fromJson<String>(json['partType']),
      backgroundId: serializer.fromJson<int?>(json['backgroundId']),
      resolverScript: serializer.fromJson<String?>(json['resolverScript']),
      eventId: serializer.fromJson<String?>(json['eventId']),
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
      'backgroundId': serializer.toJson<int?>(backgroundId),
      'resolverScript': serializer.toJson<String?>(resolverScript),
      'eventId': serializer.toJson<String?>(eventId),
    };
  }

  SceneTimelineViewData copyWith({
    int? id,
    int? sceneId,
    double? order,
    String? partType,
    Value<int?> backgroundId = const Value.absent(),
    Value<String?> resolverScript = const Value.absent(),
    Value<String?> eventId = const Value.absent(),
  }) => SceneTimelineViewData(
    id: id ?? this.id,
    sceneId: sceneId ?? this.sceneId,
    order: order ?? this.order,
    partType: partType ?? this.partType,
    backgroundId: backgroundId.present ? backgroundId.value : this.backgroundId,
    resolverScript: resolverScript.present
        ? resolverScript.value
        : this.resolverScript,
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
          ..write('resolverScript: $resolverScript, ')
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
    resolverScript,
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
          other.resolverScript == this.resolverScript &&
          other.eventId == this.eventId);
}

class $SceneTimelineViewView
    extends ViewInfo<$SceneTimelineViewView, SceneTimelineViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$SceneGroup attachedDatabase;
  $SceneTimelineViewView(this.attachedDatabase, [this._alias]);
  $ScenePartsTable get sceneParts =>
      attachedDatabase.sceneParts.createAlias('t0');
  $FramesTable get frames => attachedDatabase.frames.createAlias('t1');
  $FrameResolversTable get frameResolvers =>
      attachedDatabase.frameResolvers.createAlias('t2');
  $CustomTable get custom => attachedDatabase.custom.createAlias('t3');
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sceneId,
    order,
    partType,
    backgroundId,
    resolverScript,
    eventId,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'scene_timeline_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $SceneTimelineViewView get asDslTable => this;
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
      resolverScript: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resolver_script'],
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
    generatedAs: GeneratedAs(sceneParts.id, false),
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<int> sceneId = GeneratedColumn<int>(
    'scene_id',
    aliasedName,
    false,
    generatedAs: GeneratedAs(sceneParts.sceneId, false),
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<double> order = GeneratedColumn<double>(
    'order',
    aliasedName,
    false,
    generatedAs: GeneratedAs(sceneParts.order, false),
    type: DriftSqlType.double,
  );
  late final GeneratedColumn<String> partType = GeneratedColumn<String>(
    'part_type',
    aliasedName,
    false,
    generatedAs: GeneratedAs(sceneParts.partType, false),
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<int> backgroundId = GeneratedColumn<int>(
    'background_id',
    aliasedName,
    true,
    generatedAs: GeneratedAs(frames.backgroundId, false),
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<String> resolverScript = GeneratedColumn<String>(
    'resolver_script',
    aliasedName,
    true,
    generatedAs: GeneratedAs(frameResolvers.resolverScript, false),
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    true,
    generatedAs: GeneratedAs(custom.eventId, false),
    type: DriftSqlType.string,
  );
  @override
  $SceneTimelineViewView createAlias(String alias) {
    return $SceneTimelineViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(sceneParts)..addColumns($columns)).join([
        leftOuterJoin(frames, frames.scenePartId.equalsExp(sceneParts.id)),
        leftOuterJoin(
          frameResolvers,
          frameResolvers.scenePartId.equalsExp(sceneParts.id),
        ),
        leftOuterJoin(custom, custom.scenePartId.equalsExp(sceneParts.id)),
      ]);
  @override
  Set<String> get readTables => const {
    'scene_parts',
    'frames',
    'frame_resolvers',
    'custom',
  };
}

class FramePosesViewData extends DataClass {
  final int id;
  final int frameScenePartId;
  final int poseId;
  final double order;
  final int actorId;
  final String name;
  final Uint8List imageData;
  const FramePosesViewData({
    required this.id,
    required this.frameScenePartId,
    required this.poseId,
    required this.order,
    required this.actorId,
    required this.name,
    required this.imageData,
  });
  factory FramePosesViewData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FramePosesViewData(
      id: serializer.fromJson<int>(json['id']),
      frameScenePartId: serializer.fromJson<int>(json['frameScenePartId']),
      poseId: serializer.fromJson<int>(json['poseId']),
      order: serializer.fromJson<double>(json['order']),
      actorId: serializer.fromJson<int>(json['actorId']),
      name: serializer.fromJson<String>(json['name']),
      imageData: serializer.fromJson<Uint8List>(json['imageData']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'frameScenePartId': serializer.toJson<int>(frameScenePartId),
      'poseId': serializer.toJson<int>(poseId),
      'order': serializer.toJson<double>(order),
      'actorId': serializer.toJson<int>(actorId),
      'name': serializer.toJson<String>(name),
      'imageData': serializer.toJson<Uint8List>(imageData),
    };
  }

  FramePosesViewData copyWith({
    int? id,
    int? frameScenePartId,
    int? poseId,
    double? order,
    int? actorId,
    String? name,
    Uint8List? imageData,
  }) => FramePosesViewData(
    id: id ?? this.id,
    frameScenePartId: frameScenePartId ?? this.frameScenePartId,
    poseId: poseId ?? this.poseId,
    order: order ?? this.order,
    actorId: actorId ?? this.actorId,
    name: name ?? this.name,
    imageData: imageData ?? this.imageData,
  );
  @override
  String toString() {
    return (StringBuffer('FramePosesViewData(')
          ..write('id: $id, ')
          ..write('frameScenePartId: $frameScenePartId, ')
          ..write('poseId: $poseId, ')
          ..write('order: $order, ')
          ..write('actorId: $actorId, ')
          ..write('name: $name, ')
          ..write('imageData: $imageData')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    frameScenePartId,
    poseId,
    order,
    actorId,
    name,
    $driftBlobEquality.hash(imageData),
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FramePosesViewData &&
          other.id == this.id &&
          other.frameScenePartId == this.frameScenePartId &&
          other.poseId == this.poseId &&
          other.order == this.order &&
          other.actorId == this.actorId &&
          other.name == this.name &&
          $driftBlobEquality.equals(other.imageData, this.imageData));
}

class $FramePosesViewView
    extends ViewInfo<$FramePosesViewView, FramePosesViewData>
    implements HasResultSet {
  final String? _alias;
  @override
  final _$SceneGroup attachedDatabase;
  $FramePosesViewView(this.attachedDatabase, [this._alias]);
  $FramePosesTable get framePoses =>
      attachedDatabase.framePoses.createAlias('t0');
  $PosesTable get poses => attachedDatabase.poses.createAlias('t1');
  @override
  List<GeneratedColumn> get $columns => [
    id,
    frameScenePartId,
    poseId,
    order,
    actorId,
    name,
    imageData,
  ];
  @override
  String get aliasedName => _alias ?? entityName;
  @override
  String get entityName => 'frame_poses_view';
  @override
  Map<SqlDialect, String>? get createViewStatements => null;
  @override
  $FramePosesViewView get asDslTable => this;
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
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}order'],
      )!,
      actorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actor_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      imageData: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}image_data'],
      )!,
    );
  }

  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    generatedAs: GeneratedAs(framePoses.id, false),
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<int> frameScenePartId = GeneratedColumn<int>(
    'frame_scene_part_id',
    aliasedName,
    false,
    generatedAs: GeneratedAs(framePoses.frameScenePartId, false),
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<int> poseId = GeneratedColumn<int>(
    'pose_id',
    aliasedName,
    false,
    generatedAs: GeneratedAs(framePoses.poseId, false),
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<double> order = GeneratedColumn<double>(
    'order',
    aliasedName,
    false,
    generatedAs: GeneratedAs(framePoses.order, false),
    type: DriftSqlType.double,
  );
  late final GeneratedColumn<int> actorId = GeneratedColumn<int>(
    'actor_id',
    aliasedName,
    false,
    generatedAs: GeneratedAs(poses.actorId, false),
    type: DriftSqlType.int,
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    generatedAs: GeneratedAs(poses.name, false),
    type: DriftSqlType.string,
  );
  late final GeneratedColumn<Uint8List> imageData = GeneratedColumn<Uint8List>(
    'image_data',
    aliasedName,
    false,
    generatedAs: GeneratedAs(poses.imageData, false),
    type: DriftSqlType.blob,
  );
  @override
  $FramePosesViewView createAlias(String alias) {
    return $FramePosesViewView(attachedDatabase, alias);
  }

  @override
  Query? get query =>
      (attachedDatabase.selectOnly(framePoses)..addColumns($columns)).join([
        innerJoin(poses, poses.id.equalsExp(framePoses.poseId)),
      ]);
  @override
  Set<String> get readTables => const {'frame_poses', 'poses'};
}

abstract class _$SceneGroup extends GeneratedDatabase {
  _$SceneGroup(QueryExecutor e) : super(e);
  $SceneGroupManager get managers => $SceneGroupManager(this);
  late final $PlacesTable places = $PlacesTable(this);
  late final $BackgroundsTable backgrounds = $BackgroundsTable(this);
  late final $ActorsTable actors = $ActorsTable(this);
  late final $PosesTable poses = $PosesTable(this);
  late final $ChoicesTable choices = $ChoicesTable(this);
  late final $ChoiceOptionsTable choiceOptions = $ChoiceOptionsTable(this);
  late final $ScenesTable scenes = $ScenesTable(this);
  late final $ScenePartsTable sceneParts = $ScenePartsTable(this);
  late final $FramesTable frames = $FramesTable(this);
  late final $FrameResolversTable frameResolvers = $FrameResolversTable(this);
  late final $CustomTable custom = $CustomTable(this);
  late final $DialogueBoxesTable dialogueBoxes = $DialogueBoxesTable(this);
  late final $FramePosesTable framePoses = $FramePosesTable(this);
  late final $SceneTimelineViewView sceneTimelineView = $SceneTimelineViewView(
    this,
  );
  late final $FramePosesViewView framePosesView = $FramePosesViewView(this);
  late final Index oneSelectedPerChoice = Index(
    'one_selected_per_choice',
    'CREATE UNIQUE INDEX IF NOT EXISTS one_selected_per_choice ON choice_options (choice_id) WHERE is_selected = 1',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    places,
    backgrounds,
    actors,
    poses,
    choices,
    choiceOptions,
    scenes,
    sceneParts,
    frames,
    frameResolvers,
    custom,
    dialogueBoxes,
    framePoses,
    sceneTimelineView,
    framePosesView,
    oneSelectedPerChoice,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'places',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('backgrounds', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'actors',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('poses', kind: UpdateKind.delete)],
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
        'scenes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('scene_parts', kind: UpdateKind.delete)],
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
        'backgrounds',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('frames', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'scene_parts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('frame_resolvers', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'scene_parts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('custom', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'frames',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('dialogue_boxes', kind: UpdateKind.delete)],
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
        'poses',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('frame_poses', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$PlacesTableCreateCompanionBuilder =
    PlacesCompanion Function({Value<int> id, required String name});
typedef $$PlacesTableUpdateCompanionBuilder =
    PlacesCompanion Function({Value<int> id, Value<String> name});

final class $$PlacesTableReferences
    extends BaseReferences<_$SceneGroup, $PlacesTable, Place> {
  $$PlacesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BackgroundsTable, List<Background>>
  _backgroundsRefsTable(_$SceneGroup db) => MultiTypedResultKey.fromTable(
    db.backgrounds,
    aliasName: $_aliasNameGenerator(db.places.id, db.backgrounds.placeId),
  );

  $$BackgroundsTableProcessedTableManager get backgroundsRefs {
    final manager = $$BackgroundsTableTableManager(
      $_db,
      $_db.backgrounds,
    ).filter((f) => f.placeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_backgroundsRefsTable($_db));
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

  Expression<bool> backgroundsRefs(
    Expression<bool> Function($$BackgroundsTableFilterComposer f) f,
  ) {
    final $$BackgroundsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.backgrounds,
      getReferencedColumn: (t) => t.placeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BackgroundsTableFilterComposer(
            $db: $db,
            $table: $db.backgrounds,
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

  Expression<T> backgroundsRefs<T extends Object>(
    Expression<T> Function($$BackgroundsTableAnnotationComposer a) f,
  ) {
    final $$BackgroundsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.backgrounds,
      getReferencedColumn: (t) => t.placeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BackgroundsTableAnnotationComposer(
            $db: $db,
            $table: $db.backgrounds,
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
          PrefetchHooks Function({bool backgroundsRefs})
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
          prefetchHooksCallback: ({backgroundsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (backgroundsRefs) db.backgrounds],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (backgroundsRefs)
                    await $_getPrefetchedData<Place, $PlacesTable, Background>(
                      currentTable: table,
                      referencedTable: $$PlacesTableReferences
                          ._backgroundsRefsTable(db),
                      managerFromTypedResult: (p0) => $$PlacesTableReferences(
                        db,
                        table,
                        p0,
                      ).backgroundsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.placeId == item.id),
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
      PrefetchHooks Function({bool backgroundsRefs})
    >;
typedef $$BackgroundsTableCreateCompanionBuilder =
    BackgroundsCompanion Function({
      Value<int> id,
      required int placeId,
      required String name,
      required Uint8List imageData,
    });
typedef $$BackgroundsTableUpdateCompanionBuilder =
    BackgroundsCompanion Function({
      Value<int> id,
      Value<int> placeId,
      Value<String> name,
      Value<Uint8List> imageData,
    });

final class $$BackgroundsTableReferences
    extends BaseReferences<_$SceneGroup, $BackgroundsTable, Background> {
  $$BackgroundsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlacesTable _placeIdTable(_$SceneGroup db) => db.places.createAlias(
    $_aliasNameGenerator(db.backgrounds.placeId, db.places.id),
  );

  $$PlacesTableProcessedTableManager get placeId {
    final $_column = $_itemColumn<int>('place_id')!;

    final manager = $$PlacesTableTableManager(
      $_db,
      $_db.places,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_placeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FramesTable, List<Frame>> _framesRefsTable(
    _$SceneGroup db,
  ) => MultiTypedResultKey.fromTable(
    db.frames,
    aliasName: $_aliasNameGenerator(db.backgrounds.id, db.frames.backgroundId),
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
}

class $$BackgroundsTableFilterComposer
    extends Composer<_$SceneGroup, $BackgroundsTable> {
  $$BackgroundsTableFilterComposer({
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

  ColumnFilters<Uint8List> get imageData => $composableBuilder(
    column: $table.imageData,
    builder: (column) => ColumnFilters(column),
  );

  $$PlacesTableFilterComposer get placeId {
    final $$PlacesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.placeId,
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
}

class $$BackgroundsTableOrderingComposer
    extends Composer<_$SceneGroup, $BackgroundsTable> {
  $$BackgroundsTableOrderingComposer({
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

  ColumnOrderings<Uint8List> get imageData => $composableBuilder(
    column: $table.imageData,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlacesTableOrderingComposer get placeId {
    final $$PlacesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.placeId,
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

class $$BackgroundsTableAnnotationComposer
    extends Composer<_$SceneGroup, $BackgroundsTable> {
  $$BackgroundsTableAnnotationComposer({
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

  GeneratedColumn<Uint8List> get imageData =>
      $composableBuilder(column: $table.imageData, builder: (column) => column);

  $$PlacesTableAnnotationComposer get placeId {
    final $$PlacesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.placeId,
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
}

class $$BackgroundsTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $BackgroundsTable,
          Background,
          $$BackgroundsTableFilterComposer,
          $$BackgroundsTableOrderingComposer,
          $$BackgroundsTableAnnotationComposer,
          $$BackgroundsTableCreateCompanionBuilder,
          $$BackgroundsTableUpdateCompanionBuilder,
          (Background, $$BackgroundsTableReferences),
          Background,
          PrefetchHooks Function({bool placeId, bool framesRefs})
        > {
  $$BackgroundsTableTableManager(_$SceneGroup db, $BackgroundsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackgroundsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BackgroundsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BackgroundsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> placeId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<Uint8List> imageData = const Value.absent(),
              }) => BackgroundsCompanion(
                id: id,
                placeId: placeId,
                name: name,
                imageData: imageData,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int placeId,
                required String name,
                required Uint8List imageData,
              }) => BackgroundsCompanion.insert(
                id: id,
                placeId: placeId,
                name: name,
                imageData: imageData,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BackgroundsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({placeId = false, framesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (framesRefs) db.frames],
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
                    if (placeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.placeId,
                                referencedTable: $$BackgroundsTableReferences
                                    ._placeIdTable(db),
                                referencedColumn: $$BackgroundsTableReferences
                                    ._placeIdTable(db)
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
                      Background,
                      $BackgroundsTable,
                      Frame
                    >(
                      currentTable: table,
                      referencedTable: $$BackgroundsTableReferences
                          ._framesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BackgroundsTableReferences(
                            db,
                            table,
                            p0,
                          ).framesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.backgroundId == item.id,
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

typedef $$BackgroundsTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $BackgroundsTable,
      Background,
      $$BackgroundsTableFilterComposer,
      $$BackgroundsTableOrderingComposer,
      $$BackgroundsTableAnnotationComposer,
      $$BackgroundsTableCreateCompanionBuilder,
      $$BackgroundsTableUpdateCompanionBuilder,
      (Background, $$BackgroundsTableReferences),
      Background,
      PrefetchHooks Function({bool placeId, bool framesRefs})
    >;
typedef $$ActorsTableCreateCompanionBuilder =
    ActorsCompanion Function({Value<int> id, required String name});
typedef $$ActorsTableUpdateCompanionBuilder =
    ActorsCompanion Function({Value<int> id, Value<String> name});

final class $$ActorsTableReferences
    extends BaseReferences<_$SceneGroup, $ActorsTable, Actor> {
  $$ActorsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PosesTable, List<Pose>> _posesRefsTable(
    _$SceneGroup db,
  ) => MultiTypedResultKey.fromTable(
    db.poses,
    aliasName: $_aliasNameGenerator(db.actors.id, db.poses.actorId),
  );

  $$PosesTableProcessedTableManager get posesRefs {
    final manager = $$PosesTableTableManager(
      $_db,
      $_db.poses,
    ).filter((f) => f.actorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_posesRefsTable($_db));
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

  Expression<bool> posesRefs(
    Expression<bool> Function($$PosesTableFilterComposer f) f,
  ) {
    final $$PosesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.poses,
      getReferencedColumn: (t) => t.actorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PosesTableFilterComposer(
            $db: $db,
            $table: $db.poses,
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

  Expression<T> posesRefs<T extends Object>(
    Expression<T> Function($$PosesTableAnnotationComposer a) f,
  ) {
    final $$PosesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.poses,
      getReferencedColumn: (t) => t.actorId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PosesTableAnnotationComposer(
            $db: $db,
            $table: $db.poses,
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
          PrefetchHooks Function({bool posesRefs})
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
          prefetchHooksCallback: ({posesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (posesRefs) db.poses],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (posesRefs)
                    await $_getPrefetchedData<Actor, $ActorsTable, Pose>(
                      currentTable: table,
                      referencedTable: $$ActorsTableReferences._posesRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$ActorsTableReferences(db, table, p0).posesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.actorId == item.id),
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
      PrefetchHooks Function({bool posesRefs})
    >;
typedef $$PosesTableCreateCompanionBuilder =
    PosesCompanion Function({
      Value<int> id,
      required int actorId,
      required String name,
      required Uint8List imageData,
    });
typedef $$PosesTableUpdateCompanionBuilder =
    PosesCompanion Function({
      Value<int> id,
      Value<int> actorId,
      Value<String> name,
      Value<Uint8List> imageData,
    });

final class $$PosesTableReferences
    extends BaseReferences<_$SceneGroup, $PosesTable, Pose> {
  $$PosesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ActorsTable _actorIdTable(_$SceneGroup db) => db.actors.createAlias(
    $_aliasNameGenerator(db.poses.actorId, db.actors.id),
  );

  $$ActorsTableProcessedTableManager get actorId {
    final $_column = $_itemColumn<int>('actor_id')!;

    final manager = $$ActorsTableTableManager(
      $_db,
      $_db.actors,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_actorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$FramePosesTable, List<FramePose>>
  _framePosesRefsTable(_$SceneGroup db) => MultiTypedResultKey.fromTable(
    db.framePoses,
    aliasName: $_aliasNameGenerator(db.poses.id, db.framePoses.poseId),
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
}

class $$PosesTableFilterComposer extends Composer<_$SceneGroup, $PosesTable> {
  $$PosesTableFilterComposer({
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

  ColumnFilters<Uint8List> get imageData => $composableBuilder(
    column: $table.imageData,
    builder: (column) => ColumnFilters(column),
  );

  $$ActorsTableFilterComposer get actorId {
    final $$ActorsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.actorId,
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
}

class $$PosesTableOrderingComposer extends Composer<_$SceneGroup, $PosesTable> {
  $$PosesTableOrderingComposer({
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

  ColumnOrderings<Uint8List> get imageData => $composableBuilder(
    column: $table.imageData,
    builder: (column) => ColumnOrderings(column),
  );

  $$ActorsTableOrderingComposer get actorId {
    final $$ActorsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.actorId,
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

class $$PosesTableAnnotationComposer
    extends Composer<_$SceneGroup, $PosesTable> {
  $$PosesTableAnnotationComposer({
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

  GeneratedColumn<Uint8List> get imageData =>
      $composableBuilder(column: $table.imageData, builder: (column) => column);

  $$ActorsTableAnnotationComposer get actorId {
    final $$ActorsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.actorId,
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
}

class $$PosesTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $PosesTable,
          Pose,
          $$PosesTableFilterComposer,
          $$PosesTableOrderingComposer,
          $$PosesTableAnnotationComposer,
          $$PosesTableCreateCompanionBuilder,
          $$PosesTableUpdateCompanionBuilder,
          (Pose, $$PosesTableReferences),
          Pose,
          PrefetchHooks Function({bool actorId, bool framePosesRefs})
        > {
  $$PosesTableTableManager(_$SceneGroup db, $PosesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PosesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PosesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PosesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> actorId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<Uint8List> imageData = const Value.absent(),
              }) => PosesCompanion(
                id: id,
                actorId: actorId,
                name: name,
                imageData: imageData,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int actorId,
                required String name,
                required Uint8List imageData,
              }) => PosesCompanion.insert(
                id: id,
                actorId: actorId,
                name: name,
                imageData: imageData,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PosesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({actorId = false, framePosesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (framePosesRefs) db.framePoses],
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
                    if (actorId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.actorId,
                                referencedTable: $$PosesTableReferences
                                    ._actorIdTable(db),
                                referencedColumn: $$PosesTableReferences
                                    ._actorIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (framePosesRefs)
                    await $_getPrefetchedData<Pose, $PosesTable, FramePose>(
                      currentTable: table,
                      referencedTable: $$PosesTableReferences
                          ._framePosesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PosesTableReferences(db, table, p0).framePosesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.poseId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PosesTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $PosesTable,
      Pose,
      $$PosesTableFilterComposer,
      $$PosesTableOrderingComposer,
      $$PosesTableAnnotationComposer,
      $$PosesTableCreateCompanionBuilder,
      $$PosesTableUpdateCompanionBuilder,
      (Pose, $$PosesTableReferences),
      Pose,
      PrefetchHooks Function({bool actorId, bool framePosesRefs})
    >;
typedef $$ChoicesTableCreateCompanionBuilder =
    ChoicesCompanion Function({Value<int> id, required String name});
typedef $$ChoicesTableUpdateCompanionBuilder =
    ChoicesCompanion Function({Value<int> id, Value<String> name});

final class $$ChoicesTableReferences
    extends BaseReferences<_$SceneGroup, $ChoicesTable, Choice> {
  $$ChoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

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
          PrefetchHooks Function({bool choiceOptionsRefs})
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
          prefetchHooksCallback: ({choiceOptionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (choiceOptionsRefs) db.choiceOptions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (choiceOptionsRefs)
                    await $_getPrefetchedData<
                      Choice,
                      $ChoicesTable,
                      ChoiceOption
                    >(
                      currentTable: table,
                      referencedTable: $$ChoicesTableReferences
                          ._choiceOptionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ChoicesTableReferences(
                        db,
                        table,
                        p0,
                      ).choiceOptionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.choiceId == item.id),
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
      PrefetchHooks Function({bool choiceOptionsRefs})
    >;
typedef $$ChoiceOptionsTableCreateCompanionBuilder =
    ChoiceOptionsCompanion Function({
      Value<int> id,
      required int choiceId,
      required String optionText,
      Value<int> isSelected,
    });
typedef $$ChoiceOptionsTableUpdateCompanionBuilder =
    ChoiceOptionsCompanion Function({
      Value<int> id,
      Value<int> choiceId,
      Value<String> optionText,
      Value<int> isSelected,
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

  ColumnFilters<String> get optionText => $composableBuilder(
    column: $table.optionText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isSelected => $composableBuilder(
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

  ColumnOrderings<String> get optionText => $composableBuilder(
    column: $table.optionText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isSelected => $composableBuilder(
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

  GeneratedColumn<String> get optionText => $composableBuilder(
    column: $table.optionText,
    builder: (column) => column,
  );

  GeneratedColumn<int> get isSelected => $composableBuilder(
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
                Value<int> choiceId = const Value.absent(),
                Value<String> optionText = const Value.absent(),
                Value<int> isSelected = const Value.absent(),
              }) => ChoiceOptionsCompanion(
                id: id,
                choiceId: choiceId,
                optionText: optionText,
                isSelected: isSelected,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int choiceId,
                required String optionText,
                Value<int> isSelected = const Value.absent(),
              }) => ChoiceOptionsCompanion.insert(
                id: id,
                choiceId: choiceId,
                optionText: optionText,
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

  static MultiTypedResultKey<$FrameResolversTable, List<FrameResolver>>
  _frameResolversRefsTable(_$SceneGroup db) => MultiTypedResultKey.fromTable(
    db.frameResolvers,
    aliasName: $_aliasNameGenerator(
      db.sceneParts.id,
      db.frameResolvers.scenePartId,
    ),
  );

  $$FrameResolversTableProcessedTableManager get frameResolversRefs {
    final manager = $$FrameResolversTableTableManager(
      $_db,
      $_db.frameResolvers,
    ).filter((f) => f.scenePartId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_frameResolversRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CustomTable, List<CustomData>> _customRefsTable(
    _$SceneGroup db,
  ) => MultiTypedResultKey.fromTable(
    db.custom,
    aliasName: $_aliasNameGenerator(db.sceneParts.id, db.custom.scenePartId),
  );

  $$CustomTableProcessedTableManager get customRefs {
    final manager = $$CustomTableTableManager(
      $_db,
      $_db.custom,
    ).filter((f) => f.scenePartId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_customRefsTable($_db));
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

  Expression<bool> frameResolversRefs(
    Expression<bool> Function($$FrameResolversTableFilterComposer f) f,
  ) {
    final $$FrameResolversTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.frameResolvers,
      getReferencedColumn: (t) => t.scenePartId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FrameResolversTableFilterComposer(
            $db: $db,
            $table: $db.frameResolvers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> customRefs(
    Expression<bool> Function($$CustomTableFilterComposer f) f,
  ) {
    final $$CustomTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.custom,
      getReferencedColumn: (t) => t.scenePartId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomTableFilterComposer(
            $db: $db,
            $table: $db.custom,
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

  Expression<T> frameResolversRefs<T extends Object>(
    Expression<T> Function($$FrameResolversTableAnnotationComposer a) f,
  ) {
    final $$FrameResolversTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.frameResolvers,
      getReferencedColumn: (t) => t.scenePartId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FrameResolversTableAnnotationComposer(
            $db: $db,
            $table: $db.frameResolvers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> customRefs<T extends Object>(
    Expression<T> Function($$CustomTableAnnotationComposer a) f,
  ) {
    final $$CustomTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.custom,
      getReferencedColumn: (t) => t.scenePartId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomTableAnnotationComposer(
            $db: $db,
            $table: $db.custom,
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
            bool frameResolversRefs,
            bool customRefs,
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
                frameResolversRefs = false,
                customRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (framesRefs) db.frames,
                    if (frameResolversRefs) db.frameResolvers,
                    if (customRefs) db.custom,
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
                      if (frameResolversRefs)
                        await $_getPrefetchedData<
                          ScenePart,
                          $ScenePartsTable,
                          FrameResolver
                        >(
                          currentTable: table,
                          referencedTable: $$ScenePartsTableReferences
                              ._frameResolversRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ScenePartsTableReferences(
                                db,
                                table,
                                p0,
                              ).frameResolversRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.scenePartId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (customRefs)
                        await $_getPrefetchedData<
                          ScenePart,
                          $ScenePartsTable,
                          CustomData
                        >(
                          currentTable: table,
                          referencedTable: $$ScenePartsTableReferences
                              ._customRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ScenePartsTableReferences(
                                db,
                                table,
                                p0,
                              ).customRefs,
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
        bool frameResolversRefs,
        bool customRefs,
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

  static $BackgroundsTable _backgroundIdTable(_$SceneGroup db) =>
      db.backgrounds.createAlias(
        $_aliasNameGenerator(db.frames.backgroundId, db.backgrounds.id),
      );

  $$BackgroundsTableProcessedTableManager? get backgroundId {
    final $_column = $_itemColumn<int>('background_id');
    if ($_column == null) return null;
    final manager = $$BackgroundsTableTableManager(
      $_db,
      $_db.backgrounds,
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

  $$BackgroundsTableFilterComposer get backgroundId {
    final $$BackgroundsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.backgroundId,
      referencedTable: $db.backgrounds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BackgroundsTableFilterComposer(
            $db: $db,
            $table: $db.backgrounds,
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

  $$BackgroundsTableOrderingComposer get backgroundId {
    final $$BackgroundsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.backgroundId,
      referencedTable: $db.backgrounds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BackgroundsTableOrderingComposer(
            $db: $db,
            $table: $db.backgrounds,
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

  $$BackgroundsTableAnnotationComposer get backgroundId {
    final $$BackgroundsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.backgroundId,
      referencedTable: $db.backgrounds,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BackgroundsTableAnnotationComposer(
            $db: $db,
            $table: $db.backgrounds,
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
typedef $$FrameResolversTableCreateCompanionBuilder =
    FrameResolversCompanion Function({
      Value<int> scenePartId,
      required String resolverScript,
    });
typedef $$FrameResolversTableUpdateCompanionBuilder =
    FrameResolversCompanion Function({
      Value<int> scenePartId,
      Value<String> resolverScript,
    });

final class $$FrameResolversTableReferences
    extends BaseReferences<_$SceneGroup, $FrameResolversTable, FrameResolver> {
  $$FrameResolversTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ScenePartsTable _scenePartIdTable(_$SceneGroup db) =>
      db.sceneParts.createAlias(
        $_aliasNameGenerator(db.frameResolvers.scenePartId, db.sceneParts.id),
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

class $$FrameResolversTableFilterComposer
    extends Composer<_$SceneGroup, $FrameResolversTable> {
  $$FrameResolversTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get resolverScript => $composableBuilder(
    column: $table.resolverScript,
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

class $$FrameResolversTableOrderingComposer
    extends Composer<_$SceneGroup, $FrameResolversTable> {
  $$FrameResolversTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get resolverScript => $composableBuilder(
    column: $table.resolverScript,
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

class $$FrameResolversTableAnnotationComposer
    extends Composer<_$SceneGroup, $FrameResolversTable> {
  $$FrameResolversTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get resolverScript => $composableBuilder(
    column: $table.resolverScript,
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

class $$FrameResolversTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $FrameResolversTable,
          FrameResolver,
          $$FrameResolversTableFilterComposer,
          $$FrameResolversTableOrderingComposer,
          $$FrameResolversTableAnnotationComposer,
          $$FrameResolversTableCreateCompanionBuilder,
          $$FrameResolversTableUpdateCompanionBuilder,
          (FrameResolver, $$FrameResolversTableReferences),
          FrameResolver,
          PrefetchHooks Function({bool scenePartId})
        > {
  $$FrameResolversTableTableManager(_$SceneGroup db, $FrameResolversTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FrameResolversTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FrameResolversTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FrameResolversTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> scenePartId = const Value.absent(),
                Value<String> resolverScript = const Value.absent(),
              }) => FrameResolversCompanion(
                scenePartId: scenePartId,
                resolverScript: resolverScript,
              ),
          createCompanionCallback:
              ({
                Value<int> scenePartId = const Value.absent(),
                required String resolverScript,
              }) => FrameResolversCompanion.insert(
                scenePartId: scenePartId,
                resolverScript: resolverScript,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FrameResolversTableReferences(db, table, e),
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
                                referencedTable: $$FrameResolversTableReferences
                                    ._scenePartIdTable(db),
                                referencedColumn:
                                    $$FrameResolversTableReferences
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

typedef $$FrameResolversTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $FrameResolversTable,
      FrameResolver,
      $$FrameResolversTableFilterComposer,
      $$FrameResolversTableOrderingComposer,
      $$FrameResolversTableAnnotationComposer,
      $$FrameResolversTableCreateCompanionBuilder,
      $$FrameResolversTableUpdateCompanionBuilder,
      (FrameResolver, $$FrameResolversTableReferences),
      FrameResolver,
      PrefetchHooks Function({bool scenePartId})
    >;
typedef $$CustomTableCreateCompanionBuilder =
    CustomCompanion Function({Value<int> scenePartId, required String eventId});
typedef $$CustomTableUpdateCompanionBuilder =
    CustomCompanion Function({Value<int> scenePartId, Value<String> eventId});

final class $$CustomTableReferences
    extends BaseReferences<_$SceneGroup, $CustomTable, CustomData> {
  $$CustomTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ScenePartsTable _scenePartIdTable(_$SceneGroup db) =>
      db.sceneParts.createAlias(
        $_aliasNameGenerator(db.custom.scenePartId, db.sceneParts.id),
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

class $$CustomTableFilterComposer extends Composer<_$SceneGroup, $CustomTable> {
  $$CustomTableFilterComposer({
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

class $$CustomTableOrderingComposer
    extends Composer<_$SceneGroup, $CustomTable> {
  $$CustomTableOrderingComposer({
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

class $$CustomTableAnnotationComposer
    extends Composer<_$SceneGroup, $CustomTable> {
  $$CustomTableAnnotationComposer({
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

class $$CustomTableTableManager
    extends
        RootTableManager<
          _$SceneGroup,
          $CustomTable,
          CustomData,
          $$CustomTableFilterComposer,
          $$CustomTableOrderingComposer,
          $$CustomTableAnnotationComposer,
          $$CustomTableCreateCompanionBuilder,
          $$CustomTableUpdateCompanionBuilder,
          (CustomData, $$CustomTableReferences),
          CustomData,
          PrefetchHooks Function({bool scenePartId})
        > {
  $$CustomTableTableManager(_$SceneGroup db, $CustomTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> scenePartId = const Value.absent(),
                Value<String> eventId = const Value.absent(),
              }) => CustomCompanion(scenePartId: scenePartId, eventId: eventId),
          createCompanionCallback:
              ({
                Value<int> scenePartId = const Value.absent(),
                required String eventId,
              }) => CustomCompanion.insert(
                scenePartId: scenePartId,
                eventId: eventId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$CustomTableReferences(db, table, e)),
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
                                referencedTable: $$CustomTableReferences
                                    ._scenePartIdTable(db),
                                referencedColumn: $$CustomTableReferences
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

typedef $$CustomTableProcessedTableManager =
    ProcessedTableManager<
      _$SceneGroup,
      $CustomTable,
      CustomData,
      $$CustomTableFilterComposer,
      $$CustomTableOrderingComposer,
      $$CustomTableAnnotationComposer,
      $$CustomTableCreateCompanionBuilder,
      $$CustomTableUpdateCompanionBuilder,
      (CustomData, $$CustomTableReferences),
      CustomData,
      PrefetchHooks Function({bool scenePartId})
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
          DialogueBoxe,
          $$DialogueBoxesTableFilterComposer,
          $$DialogueBoxesTableOrderingComposer,
          $$DialogueBoxesTableAnnotationComposer,
          $$DialogueBoxesTableCreateCompanionBuilder,
          $$DialogueBoxesTableUpdateCompanionBuilder,
          (
            DialogueBoxe,
            BaseReferences<_$SceneGroup, $DialogueBoxesTable, DialogueBoxe>,
          ),
          DialogueBoxe,
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
      DialogueBoxe,
      $$DialogueBoxesTableFilterComposer,
      $$DialogueBoxesTableOrderingComposer,
      $$DialogueBoxesTableAnnotationComposer,
      $$DialogueBoxesTableCreateCompanionBuilder,
      $$DialogueBoxesTableUpdateCompanionBuilder,
      (
        DialogueBoxe,
        BaseReferences<_$SceneGroup, $DialogueBoxesTable, DialogueBoxe>,
      ),
      DialogueBoxe,
      PrefetchHooks Function()
    >;
typedef $$FramePosesTableCreateCompanionBuilder =
    FramePosesCompanion Function({
      Value<int> id,
      required int frameScenePartId,
      required int poseId,
      required double order,
    });
typedef $$FramePosesTableUpdateCompanionBuilder =
    FramePosesCompanion Function({
      Value<int> id,
      Value<int> frameScenePartId,
      Value<int> poseId,
      Value<double> order,
    });

final class $$FramePosesTableReferences
    extends BaseReferences<_$SceneGroup, $FramePosesTable, FramePose> {
  $$FramePosesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PosesTable _poseIdTable(_$SceneGroup db) => db.poses.createAlias(
    $_aliasNameGenerator(db.framePoses.poseId, db.poses.id),
  );

  $$PosesTableProcessedTableManager get poseId {
    final $_column = $_itemColumn<int>('pose_id')!;

    final manager = $$PosesTableTableManager(
      $_db,
      $_db.poses,
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

  $$PosesTableFilterComposer get poseId {
    final $$PosesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.poseId,
      referencedTable: $db.poses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PosesTableFilterComposer(
            $db: $db,
            $table: $db.poses,
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

  $$PosesTableOrderingComposer get poseId {
    final $$PosesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.poseId,
      referencedTable: $db.poses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PosesTableOrderingComposer(
            $db: $db,
            $table: $db.poses,
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

  $$PosesTableAnnotationComposer get poseId {
    final $$PosesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.poseId,
      referencedTable: $db.poses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PosesTableAnnotationComposer(
            $db: $db,
            $table: $db.poses,
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
                Value<int> poseId = const Value.absent(),
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
                required int poseId,
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

class $SceneGroupManager {
  final _$SceneGroup _db;
  $SceneGroupManager(this._db);
  $$PlacesTableTableManager get places =>
      $$PlacesTableTableManager(_db, _db.places);
  $$BackgroundsTableTableManager get backgrounds =>
      $$BackgroundsTableTableManager(_db, _db.backgrounds);
  $$ActorsTableTableManager get actors =>
      $$ActorsTableTableManager(_db, _db.actors);
  $$PosesTableTableManager get poses =>
      $$PosesTableTableManager(_db, _db.poses);
  $$ChoicesTableTableManager get choices =>
      $$ChoicesTableTableManager(_db, _db.choices);
  $$ChoiceOptionsTableTableManager get choiceOptions =>
      $$ChoiceOptionsTableTableManager(_db, _db.choiceOptions);
  $$ScenesTableTableManager get scenes =>
      $$ScenesTableTableManager(_db, _db.scenes);
  $$ScenePartsTableTableManager get sceneParts =>
      $$ScenePartsTableTableManager(_db, _db.sceneParts);
  $$FramesTableTableManager get frames =>
      $$FramesTableTableManager(_db, _db.frames);
  $$FrameResolversTableTableManager get frameResolvers =>
      $$FrameResolversTableTableManager(_db, _db.frameResolvers);
  $$CustomTableTableManager get custom =>
      $$CustomTableTableManager(_db, _db.custom);
  $$DialogueBoxesTableTableManager get dialogueBoxes =>
      $$DialogueBoxesTableTableManager(_db, _db.dialogueBoxes);
  $$FramePosesTableTableManager get framePoses =>
      $$FramePosesTableTableManager(_db, _db.framePoses);
}
