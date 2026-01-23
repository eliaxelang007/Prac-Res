import "dart:convert";
import "dart:typed_data";
import "package:archive/archive.dart";
import "package:result_type/result_type.dart";

class ArchiveWriter {
  final Archive archive;

  /// This would have been a [List<ArchiveItemName>] if not for the root folder feature!
  final List<String> path;

  ArchiveWriter._({required this.archive, required this.path});

  factory ArchiveWriter({required Archive archive}) {
    return ArchiveWriter._(archive: archive, path: []);
  }

  void writeFolder(String folderName, List<ArchiveItem> folderChildren) {
    path.add(folderName);

    for (final child in folderChildren) {
      child.writeToArchive(this);
    }

    path.removeLast();
  }

  void writeFile(String fileName, Uint8List fileBytes) {
    path.add(fileName);

    archive.add(ArchiveFile.bytes(path.join("/"), fileBytes));

    path.removeLast();
  }
}

abstract interface class ArchiveWritable {
  void writeToArchive(ArchiveWriter writer);

  Archive toArchive() {
    final writer = ArchiveWriter(archive: Archive());

    writeToArchive(writer);

    return writer.archive;
  }
}

sealed class ArchiveItem extends ArchiveWritable {}

class Folder extends ArchiveItem {
  final ArchiveItemName name;
  final List<ArchiveItem> children;

  Folder({required this.name, required this.children});

  @override
  void writeToArchive(ArchiveWriter writer) {
    writer.writeFolder(name, children);
  }
}

class File extends ArchiveItem implements ArchiveWritable {
  final ArchiveItemName name;
  final Uint8List bytes;

  File({required this.name, required this.bytes});

  static File fromJson(ArchiveItemName name, Map<String, dynamic> json) {
    return File(name: name, bytes: utf8.encode(jsonEncode(json)));
  }

  @override
  void writeToArchive(ArchiveWriter writer) {
    writer.writeFile(name, bytes);
  }
}

class RootFolder extends ArchiveWritable {
  final List<ArchiveItem> children;

  RootFolder({required this.children});

  @override
  void writeToArchive(ArchiveWriter writer) {
    writer.writeFolder("", children);
  }
}

/// Windows's max path length is 260 characters.
const int maxPath = 260;

enum ArchiveItemNameError implements Exception {
  isEmpty("A filename can't be empty!"),
  hasExceedingLength("A filename can't be longer than $maxPath characters!"),
  hasNonAscii("A filename has to be valid ascii!"),
  hasForbiddenCharacters(
    "A filename can't contain '<', '>', ':', '\"', '/', '\\', '|', '?', or '*'!",
  ),
  hasNonLowercase("A filename can't have any case other than lowercase!"),
  hasBeginningOrEndingWhitespace(
    "A filename can't start or end with whitespace!",
  ),
  hasEndingPeriod("A filename can't end with a period!");

  final String errorMessage;

  const ArchiveItemNameError(this.errorMessage);
}

extension type const ArchiveItemName._(String fullFilename) implements String {
  static Result<Null, ArchiveItemNameError> _validate(String fullFilename) {
    if (fullFilename.isEmpty) {
      return Failure(ArchiveItemNameError.isEmpty);
    }

    if (fullFilename.length > maxPath) {
      return Failure(ArchiveItemNameError.hasExceedingLength);
    }

    if (fullFilename.endsWith('.')) {
      return Failure(ArchiveItemNameError.hasEndingPeriod);
    }

    if (fullFilename.codeUnits.any((c) => c < 32 || c > 126)) {
      return Failure(ArchiveItemNameError.hasNonAscii);
    }

    if (fullFilename.contains(RegExp(r'[<>:"/\\|?*]'))) {
      return Failure(ArchiveItemNameError.hasForbiddenCharacters);
    }

    if (fullFilename != fullFilename.toLowerCase()) {
      return Failure(ArchiveItemNameError.hasNonLowercase);
    }

    if (fullFilename.trim().length != fullFilename.length) {
      return Failure(ArchiveItemNameError.hasBeginningOrEndingWhitespace);
    }

    return Success(null);
  }

  static Result<ArchiveItemName, ArchiveItemNameError> create(
    String fullFilename,
  ) {
    return _validate(fullFilename).map((_) => ArchiveItemName._(fullFilename));
  }

  // factory ArchiveItemName(String fullFilename) {
  //   return ArchiveItemName.create(fullFilename).unwrap();
  // }
}
