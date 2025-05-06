import 'dart:io';
import 'package:path/path.dart' as path;
import 'dart:typed_data';

extension FileExtensions on File {
  /// Returns the file extension
  String get extension => path.extension(this.path);

  /// Returns the file name without extension
  String get nameWithoutExtension => path.basenameWithoutExtension(this.path);

  /// Returns the file size in bytes
  Future<int> get size => length();

  /// Returns the file size in human readable format
  Future<String> get humanReadableSize async {
    final bytes = await size;
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  /// Returns true if the file is an image
  bool get isImage {
    final ext = extension.toLowerCase();
    return ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'].contains(ext);
  }

  /// Returns true if the file is a video
  bool get isVideo {
    final ext = extension.toLowerCase();
    return ['.mp4', '.avi', '.mov', '.wmv', '.flv', '.mkv'].contains(ext);
  }

  /// Returns true if the file is a document
  bool get isDocument {
    final ext = extension.toLowerCase();
    return [
      '.pdf',
      '.doc',
      '.docx',
      '.txt',
      '.rtf',
      '.odt',
      '.xls',
      '.xlsx',
      '.csv',
      '.ppt',
      '.pptx'
    ].contains(ext);
  }

  /// Returns true if the file is an archive
  bool get isArchive {
    final ext = extension.toLowerCase();
    return ['.zip', '.rar', '.7z', '.tar', '.gz'].contains(ext);
  }

  /// Returns the file's last modified date
  Future<DateTime> get lastModified async {
    final fileStat = await stat();
    return fileStat.modified;
  }

  /// Returns the file's creation date
  Future<DateTime> get created async {
    final fileStat = await stat();
    return fileStat.changed;
  }

  /// Returns true if the file is older than the specified duration
  Future<bool> isOlderThan(Duration duration) async {
    final modified = await lastModified;
    return DateTime.now().difference(modified) > duration;
  }

  /// Returns the file's MIME type
  String get mimeType {
    final ext = extension.toLowerCase();
    final mimeTypes = {
      '.jpg': 'image/jpeg',
      '.jpeg': 'image/jpeg',
      '.png': 'image/png',
      '.gif': 'image/gif',
      '.pdf': 'application/pdf',
      '.doc': 'application/msword',
      '.docx':
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      '.xls': 'application/vnd.ms-excel',
      '.xlsx':
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      '.zip': 'application/zip',
      '.txt': 'text/plain',
    };
    return mimeTypes[ext] ?? 'application/octet-stream';
  }

  /// Creates a copy of the file in the specified directory
  Future<File> copyTo(String destinationPath) async {
    final destination = File(destinationPath);
    await destination.create(recursive: true);
    return copy(destination.path);
  }

  /// Moves the file to the specified directory
  Future<File> moveTo(String destinationPath) async {
    final destination = File(destinationPath);
    await destination.create(recursive: true);
    return rename(destination.path);
  }

  /// Checks if the file exists.
  Future<bool> existsAsync() => exists();

  /// Deletes the file if it exists, returns true if deleted.
  Future<bool> deleteIfExists() async {
    if (await exists()) {
      await delete();
      return true;
    }
    return false;
  }

  /// Reads the file content as a string.
  Future<String> readAsStringAsync() => readAsString();

  /// Reads the file content as bytes.
  Future<Uint8List> readAsBytesAsync() => readAsBytes();

  /// Writes [content] to the file using [mode], returns the file.
  Future<File> writeString(String content,
      {FileMode mode = FileMode.write}) async {
    return writeAsString(content, mode: mode);
  }

  /// Writes [bytes] to the file using [mode], returns the file.
  Future<File> writeBytes(Uint8List bytes,
      {FileMode mode = FileMode.write}) async {
    return writeAsBytes(bytes, mode: mode);
  }

  /// Returns the file name (with extension).
  String get fileName => path.basename(this.path);

  /// Returns the parent directory path of the file.
  String get parentDirectory => path.dirname(this.path);

  /// Renames the file's extension to [newExtension], returns the new file.
  Future<File> withExtension(String newExtension) {
    final dir = path.dirname(this.path);
    final name = path.basenameWithoutExtension(this.path) + newExtension;
    final newPath = path.join(dir, name);
    return rename(newPath);
  }

  /// Appends [content] to the file using the given [mode].
  Future<File> appendString(String content, {FileMode mode = FileMode.append}) {
    return writeAsString(content, mode: mode);
  }

  /// Appends [bytes] to the file using the given [mode].
  Future<File> appendBytes(Uint8List bytes, {FileMode mode = FileMode.append}) {
    return writeAsBytes(bytes, mode: mode);
  }

  /// Reads the file content as a list of lines.
  Future<List<String>> readLines() async {
    final text = await readAsString();
    return text.split('\n');
  }

  /// Returns true if the file is hidden (filename starts with a dot).
  bool get isHidden => path.basename(this.path).startsWith('.');

  /// Ensures the parent directory exists, creating it if necessary.
  Future<void> ensureParentDirExists() async {
    final dir = Directory(path.dirname(this.path));
    await dir.create(recursive: true);
  }
}
