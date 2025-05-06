import 'dart:io';
import 'package:path/path.dart' as path;

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
}
