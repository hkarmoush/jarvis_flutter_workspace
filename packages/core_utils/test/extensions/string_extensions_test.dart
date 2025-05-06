import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/core_utils.dart';

void main() {
  group('StringExtensions', () {
    test('isEmail returns correct value', () {
      expect('test@example.com'.isEmail, isTrue);
      expect('user.name@domain.co'.isEmail, isTrue);
      expect('invalid-email'.isEmail, isFalse);
      expect('user@.com'.isEmail, isFalse);
    });

    test('isPhoneNumber returns correct value', () {
      expect('+12345678901'.isPhoneNumber, isTrue);
      expect('1234567890'.isPhoneNumber, isTrue);
      expect('12345'.isPhoneNumber, isFalse);
      expect('phone123'.isPhoneNumber, isFalse);
    });

    test('capitalize returns correct value', () {
      expect('hello'.capitalize, 'Hello');
      expect('Hello'.capitalize, 'Hello');
      expect(''.capitalize, '');
    });

    test('isNullOrEmpty returns correct value', () {
      expect(''.isNullOrEmpty, isTrue);
      expect('not empty'.isNullOrEmpty, isFalse);
    });

    test('titleCase returns correct value', () {
      expect('hello world'.titleCase, 'Hello World');
      expect('dart is fun'.titleCase, 'Dart Is Fun');
      expect(''.titleCase, '');
    });

    test('reverse returns correct value', () {
      expect('hello'.reverse, 'olleh');
      expect(''.reverse, '');
      expect('a'.reverse, 'a');
    });

    test('isNumeric returns correct value', () {
      expect('12345'.isNumeric, isTrue);
      expect('-123.45'.isNumeric, isTrue);
      expect('12a45'.isNumeric, isFalse);
      expect(''.isNumeric, isFalse);
    });

    test('isAlpha returns correct value', () {
      expect('abcDEF'.isAlpha, isTrue);
      expect('abc123'.isAlpha, isFalse);
      expect(''.isAlpha, isFalse);
    });

    test('isAlphanumeric returns correct value', () {
      expect('abc123'.isAlphanumeric, isTrue);
      expect('abc'.isAlphanumeric, isTrue);
      expect('123'.isAlphanumeric, isTrue);
      expect('abc!123'.isAlphanumeric, isFalse);
      expect(''.isAlphanumeric, isFalse);
    });

    test('removeWhitespace returns correct value', () {
      expect('a b c'.removeWhitespace, 'abc');
      expect('   hello   world   '.removeWhitespace, 'helloworld');
      expect(''.removeWhitespace, '');
    });

    test('truncate returns correct value', () {
      expect('hello world'.truncate(5), 'hello...');
      expect('short'.truncate(10), 'short');
      expect('truncate me'.truncate(8, ellipsis: '--'), 'truncate--');
    });

    test('toSnakeCase returns correct value', () {
      expect('helloWorld'.toSnakeCase, 'hello_world');
      expect('Hello World'.toSnakeCase, 'hello_world');
      expect('already_snake_case'.toSnakeCase, 'already_snake_case');
    });

    test('toCamelCase returns correct value', () {
      expect('hello_world'.toCamelCase, 'helloWorld');
      expect('Hello world'.toCamelCase, 'helloWorld');
      expect('alreadyCamelCase'.toCamelCase, 'alreadycamelcase');
      expect('snake_case_string'.toCamelCase, 'snakeCaseString');
      expect('kebab-case-string'.toCamelCase, 'kebabCaseString');
    });

    test('toKebabCase returns correct value', () {
      expect('helloWorld'.toKebabCase, 'hello-world');
      expect('Hello World'.toKebabCase, 'hello-world');
      expect('already-kebab-case'.toKebabCase, 'already-kebab-case');
    });

    test('repeat returns correct value', () {
      expect('abc'.repeat(3), 'abcabcabc');
      expect('x'.repeat(0), '');
      expect(''.repeat(5), '');
    });
  });
}
