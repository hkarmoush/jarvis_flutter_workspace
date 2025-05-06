import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core_utils/core_utils.dart';

import 'file_extensions_test.mocks.dart';

@GenerateMocks([File])
void main() {
  group('FileExtensions', () {
    late MockFile file;

    setUp(() {
      file = MockFile();
    });

    test('existsAsync returns true when file exists', () async {
      when(file.exists()).thenAnswer((_) async => true);
      final result = await file.existsAsync();
      expect(result, isTrue);
      verify(file.exists()).called(1);
    });

    test('deleteIfExists deletes file when it exists', () async {
      when(file.exists()).thenAnswer((_) async => true);
      when(file.delete()).thenAnswer((_) async => file);
      final result = await file.deleteIfExists();
      expect(result, isTrue);
      verify(file.exists()).called(1);
      verify(file.delete()).called(1);
    });

    test('deleteIfExists returns false when file does not exist', () async {
      when(file.exists()).thenAnswer((_) async => false);
      final result = await file.deleteIfExists();
      expect(result, isFalse);
      verify(file.exists()).called(1);
      verifyNever(file.delete());
    });

    test('readAsStringAsync calls readAsString', () async {
      when(file.readAsString()).thenAnswer((_) async => 'line1\nline2');
      final result = await file.readAsStringAsync();
      expect(result, 'line1\nline2');
      verify(file.readAsString()).called(1);
    });

    test('readAsBytesAsync calls readAsBytes', () async {
      final bytes = Uint8List.fromList([10, 20]);
      when(file.readAsBytes()).thenAnswer((_) async => bytes);
      final result = await file.readAsBytesAsync();
      expect(result, bytes);
      verify(file.readAsBytes()).called(1);
    });

    test('writeString calls writeAsString with default mode', () async {
      when(file.writeAsString(any, mode: anyNamed('mode')))
          .thenAnswer((_) async => file);
      final result = await file.writeString('abc');
      expect(result, file);
      verify(file.writeAsString('abc', mode: FileMode.write)).called(1);
    });

    test('writeBytes calls writeAsBytes with default mode', () async {
      final data = Uint8List.fromList([1, 2, 3]);
      when(file.writeAsBytes(any, mode: anyNamed('mode')))
          .thenAnswer((_) async => file);
      final result = await file.writeBytes(data);
      expect(result, file);
      verify(file.writeAsBytes(data, mode: FileMode.write)).called(1);
    });

    test('fileName returns basename of path', () {
      when(file.path).thenReturn('/tmp/example.txt');
      expect(file.fileName, 'example.txt');
    });

    test('parentDirectory returns dirname of path', () {
      when(file.path).thenReturn('/tmp/some/path/data.json');
      expect(file.parentDirectory, '/tmp/some/path');
    });

    test('withExtension renames file extension correctly', () async {
      when(file.path).thenReturn('/tmp/docs/report.txt');
      when(file.rename(any)).thenAnswer((inv) async => file);
      final newFile = await file.withExtension('.md');
      expect(newFile, file);
      final captured = verify(file.rename(captureAny)).captured.single;
      expect(captured, path.join('/tmp/docs', 'report.md'));
    });

    test('appendString appends content using append mode', () async {
      when(file.writeAsString(any, mode: anyNamed('mode')))
          .thenAnswer((_) async => file);
      final result = await file.appendString('XYZ');
      expect(result, file);
      verify(file.writeAsString('XYZ', mode: FileMode.append)).called(1);
    });

    test('appendBytes appends bytes using append mode', () async {
      final data = Uint8List.fromList([5, 6, 7]);
      when(file.writeAsBytes(any, mode: anyNamed('mode')))
          .thenAnswer((_) async => file);
      final result = await file.appendBytes(data);
      expect(result, file);
      verify(file.writeAsBytes(data, mode: FileMode.append)).called(1);
    });

    test('readLines splits content into lines', () async {
      when(file.readAsString()).thenAnswer((_) async => 'a\nb\nc');
      final lines = await file.readLines();
      expect(lines, ['a', 'b', 'c']);
    });

    test('isHidden returns true when filename starts with dot', () {
      when(file.path).thenReturn('/tmp/.secret');
      expect(file.isHidden, isTrue);
      when(file.path).thenReturn('/tmp/visible.txt');
      expect(file.isHidden, isFalse);
    });

    test('ensureParentDirExists creates parent directory', () async {
      final tempDir = Directory.systemTemp.createTempSync();
      final nestedFilePath = path.join(tempDir.path, 'nested', 'file.txt');
      final realFile = File(nestedFilePath);
      // Ensure parent does not exist
      expect(Directory(path.dirname(nestedFilePath)).existsSync(), isFalse);
      await realFile.ensureParentDirExists();
      expect(Directory(path.dirname(nestedFilePath)).existsSync(), isTrue);
      tempDir.deleteSync(recursive: true);
    });
  });
}
