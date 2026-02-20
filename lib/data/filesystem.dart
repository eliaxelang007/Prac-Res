// import "dart:typed_data";
// import "package:result_type/result_type.dart";

// sealed class FilesystemItem {}

// sealed class FileProvider {}

// abstract interface class SyncFileReader extends FileProvider {
//   Uint8List read();
// }

// abstract interface class AsyncFileReader extends FileProvider {
//   Future<Uint8List> read();
// }

// class File extends FilesystemItem {
//   final FileProvider provider;

//   File({required this.provider});
// }

// class Folder extends FilesystemItem {}

// /// Windows's max path length is 260 characters.
// const int maxPath = 260;

// enum FilesystemNameError implements Exception {
//   empty("A filename can't be empty!"),
//   exceedingLength("A filename can't be longer than $maxPath characters!"),
//   nonAscii("A filename has to be valid ascii!"),
//   forbiddenCharacters(
//     "A filename can't contain '<', '>', ':', '\"', '/', '\\', '|', '?', or '*'!",
//   ),
//   nonLowercase("A filename can't have any case other than lowercase!"),
//   beginningOrEndingWithWhitespace(
//     "A filename can't start or end with whitespace!",
//   ),
//   endingPeriod("A filename can't end with a period!");

//   final String message;

//   const FilesystemNameError(this.message);

//   @override
//   String toString() => message;
// }

// extension type const FilesystemName._(String fullFilename)
//     implements String {
//   static Result<Null, FilesystemNameError> _validate(String fullFilename) {
//     if (fullFilename.isEmpty) {
//       return Failure(FilesystemNameError.empty);
//     }

//     if (fullFilename.length > maxPath) {
//       return Failure(FilesystemNameError.exceedingLength);
//     }

//     if (fullFilename.endsWith('.')) {
//       return Failure(FilesystemNameError.endingPeriod);
//     }

//     if (fullFilename.codeUnits.any((c) => c < 32 || c > 126)) {
//       return Failure(FilesystemNameError.nonAscii);
//     }

//     if (fullFilename.contains(RegExp(r'[<>:"/\\|?*]'))) {
//       return Failure(FilesystemNameError.forbiddenCharacters);
//     }

//     if (fullFilename != fullFilename.toLowerCase()) {
//       return Failure(FilesystemNameError.nonLowercase);
//     }

//     if (fullFilename.trim().length != fullFilename.length) {
//       return Failure(FilesystemNameError.beginningOrEndingWithWhitespace);
//     }

//     return Success(null);
//   }

//   static Result<FilesystemName, FilesystemNameError> create(
//     String fullFilename,
//   ) {
//     return _validate(
//       fullFilename,
//     ).map((_) => FilesystemName._(fullFilename));
//   }
// }

import "dart:typed_data";

import "dart:convert";
import "package:archive/archive.dart";
import "package:result_type/result_type.dart";

class ArchiveWriter {
  final Archive archive;

  final List<CrossFilesystemName> path;

  ArchiveWriter._({required this.archive, required this.path});

  factory ArchiveWriter({required Archive archive}) {
    return ArchiveWriter._(archive: archive, path: []);
  }

  void writeFolder(CrossFilesystemName folderName, FolderChildren children) {
    path.add(folderName);

    for (final MapEntry(:key, :value) in children.entries) {
      value.writeToArchive(this, key);
    }

    path.removeLast();
  }

  void writeFile(CrossFilesystemName fileName, Uint8List fileBytes) {
    path.add(fileName);

    archive.add(ArchiveFile.bytes(path.join("/"), fileBytes));

    path.removeLast();
  }
}

abstract interface class WritableArchiveData {
  void writeToArchive(ArchiveWriter writer, CrossFilesystemName name);

  Archive toArchive(CrossFilesystemName name) {
    final writer = ArchiveWriter(archive: Archive());

    writeToArchive(writer, name);

    return writer.archive;
  }
}

sealed class ArchiveItemData extends WritableArchiveData {}

typedef ArchiveItem<Data> = MapEntry<CrossFilesystemName, Data>;
typedef AnyArchiveItem = ArchiveItem<ArchiveItemData>;

enum FolderChildrenError implements Exception {
  duplicateEntries(
    "In [FolderData]'s [fromEntries] constructor, there were at least two different archive items with the same name!",
  );

  final String message;

  const FolderChildrenError(this.message);

  @override
  String toString() => message;
}

extension type FolderChildren(
  Map<CrossFilesystemName, ArchiveItemData> _children
)
    implements Map<CrossFilesystemName, ArchiveItemData> {
  static Result<FolderChildren, FolderChildrenError> fromEntries(
    Iterable<AnyArchiveItem> entries,
  ) {
    final children = <CrossFilesystemName, ArchiveItemData>{};

    for (final MapEntry(:key, :value) in entries) {
      if (children.containsKey(key)) {
        return Failure(FolderChildrenError.duplicateEntries);
      }

      children[key] = value;
    }

    return Success(FolderChildren(children));
  }

  ArchiveItemData? find(CrossFilesystemName name) {
    return _children[name];
  }

  void add(AnyArchiveItem item) {
    _children[item.key] = item.value;
  }
}

class FolderData extends ArchiveItemData {
  final FolderChildren children;

  FolderData({required this.children});

  ArchiveItemData? find(CrossFilesystemName name) {
    return children.find(name);
  }

  @override
  void writeToArchive(ArchiveWriter writer, CrossFilesystemName name) {
    writer.writeFolder(name, children);
  }

  Root toRoot() {
    return Root(children: children);
  }
}

extension type Folder._(ArchiveItem<FolderData> _folder)
    implements ArchiveItem<FolderData> {
  factory Folder({
    required CrossFilesystemName name,
    required FolderData children,
  }) {
    return Folder._(MapEntry(name, children));
  }
}

class FileData extends ArchiveItemData {
  final Uint8List bytes;

  FileData({required this.bytes});

  static FileData fromJson(Object? json) {
    return FileData(bytes: utf8.encode(jsonEncode(json)));
  }

  dynamic toJson() {
    return jsonDecode(utf8.decode(bytes));
  }

  @override
  void writeToArchive(ArchiveWriter writer, CrossFilesystemName name) {
    writer.writeFile(name, bytes);
  }
}

extension type File._(ArchiveItem<FileData> _file)
    implements ArchiveItem<FileData> {
  factory File({required CrossFilesystemName name, required FileData data}) {
    return File._(ArchiveItem<FileData>(name, data));
  }
}

class Root {
  final FolderChildren children;

  Root({required this.children});

  ArchiveItemData? find(CrossFilesystemName name) {
    return children.find(name);
  }

  void writeToArchive(ArchiveWriter writer) {
    for (final MapEntry(:key, :value) in children.entries) {
      value.writeToArchive(writer, key);
    }
  }

  Archive toArchive() {
    final writer = ArchiveWriter(archive: Archive());

    writeToArchive(writer);

    return writer.archive;
  }

  FolderData toFolderData() {
    return FolderData(children: children);
  }
}

/// Windows's max path length is 260 characters.
const int maxPath = 260;

enum CrossFilesystemNameError implements Exception {
  empty("A filename can't be empty!"),
  exceedingLength("A filename can't be longer than $maxPath characters!"),
  nonAscii("A filename has to be valid ascii!"),
  forbiddenCharacters(
    "A filename can't contain '<', '>', ':', '\"', '/', '\\', '|', '?', or '*'!",
  ),
  nonLowercase("A filename can't have any case other than lowercase!"),
  beginningOrEndingWithWhitespace(
    "A filename can't start or end with whitespace!",
  ),
  endingPeriod("A filename can't end with a period!");

  final String message;

  const CrossFilesystemNameError(this.message);

  @override
  String toString() => message;
}

extension type const CrossFilesystemName._(String fullFilename)
    implements String {
  static Result<Null, CrossFilesystemNameError> _validate(String fullFilename) {
    if (fullFilename.isEmpty) {
      return Failure(CrossFilesystemNameError.empty);
    }

    if (fullFilename.length > maxPath) {
      return Failure(CrossFilesystemNameError.exceedingLength);
    }

    if (fullFilename.endsWith('.')) {
      return Failure(CrossFilesystemNameError.endingPeriod);
    }

    if (fullFilename.codeUnits.any((c) => c < 32 || c > 126)) {
      return Failure(CrossFilesystemNameError.nonAscii);
    }

    if (fullFilename.contains(RegExp(r'[<>:"/\\|?*]'))) {
      return Failure(CrossFilesystemNameError.forbiddenCharacters);
    }

    if (fullFilename != fullFilename.toLowerCase()) {
      return Failure(CrossFilesystemNameError.nonLowercase);
    }

    if (fullFilename.trim().length != fullFilename.length) {
      return Failure(CrossFilesystemNameError.beginningOrEndingWithWhitespace);
    }

    return Success(null);
  }

  static Result<CrossFilesystemName, CrossFilesystemNameError> create(
    String fullFilename,
  ) {
    return _validate(
      fullFilename,
    ).map((_) => CrossFilesystemName._(fullFilename));
  }
}
