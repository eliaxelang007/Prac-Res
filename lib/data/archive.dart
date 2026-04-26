import 'dart:typed_data';

import "package:archive/archive.dart";
import "package:junction/junction.dart";
import "package:path/path.dart" as p;

extension CrossFolderDataExtension on CrossFolderData {
  static CrossFolderData fromArchive(Archive archive) {
    final rootFolder = CrossFolderData(children: CrossFolderChildren({}));

    for (final file in archive) {
      final pathParts = CrossPath.fromString(file.name);

      if (pathParts.isEmpty) continue;

      var currentFolder = rootFolder;
      final lastIndex = pathParts.length - 1;

      for (int i = 0; i < lastIndex; i++) {
        final part = pathParts[i];

        currentFolder =
            currentFolder.children.putIfAbsent(
                  part,
                  () => CrossFolderData(children: CrossFolderChildren({})),
                )
                as CrossFolderData;
      }

      // This has to be [putIfAbsent] because /folder/file.txt can come before /folder
      // And just assigning it directly would incorrectly overwrite data.
      currentFolder.children.putIfAbsent(
        pathParts[lastIndex], // Because we continued [if (pathParts.isEmpty)], this is safe.
        () => (file.isFile)
            ? CrossFileData(bytes: file.readBytes() ?? Uint8List(0))
            : CrossFolderData(children: CrossFolderChildren({})),
      );
    }

    return rootFolder;
  }
}

extension ArchiveExtension on Archive {
  static Archive fromFolder(CrossFolderData item) {
    final archive = Archive();

    _writeFolderData(archive, [], item);

    return archive;
  }
}

void _writeFolderData(
  Archive archive,
  List<CrossFilesystemName> currentPath,
  CrossFolderData folderData,
) {
  final folderChildren = folderData.children;

  if (folderChildren.isEmpty) {
    archive.addFile(ArchiveFile.directory(p.posix.joinAll(currentPath)));
    return;
  }

  for (final child in folderChildren.entries) {
    _toArchive(archive, currentPath, child);
  }
}

void _toArchive(
  Archive archive,
  List<CrossFilesystemName> currentPath,
  AnyCrossFilesystemItem item,
) {
  currentPath.add(item.key);

  final data = item.value;

  switch (data) {
    case CrossFileData(bytes: final bytes):
      {
        archive.add(ArchiveFile.bytes(p.posix.joinAll(currentPath), bytes));

        break;
      }
    case CrossFolderData(children: final children):
      {
        for (final child in children.entries) {
          _toArchive(archive, currentPath, child);
        }

        break;
      }
  }

  currentPath.removeLast();
}
