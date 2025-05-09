import 'package:flutter_test/flutter_test.dart';
import 'package:core_utils/src/extensions/enum_extensions.dart';

enum TestEnum { alpha, beta, gamma }

void main() {
  group('EnumExtensions', () {
    test('toName returns enum name', () {
      expect(TestEnum.alpha.toName(), 'alpha');
      expect(TestEnum.beta.toName(), 'beta');
      expect(TestEnum.gamma.toName(), 'gamma');
    });
  });

  group('EnumListExtensions', () {
    test('fromName finds enum by name', () {
      final values = TestEnum.values;
      expect(values.fromName('alpha'), TestEnum.alpha);
      expect(values.fromName('beta'), TestEnum.beta);
      expect(values.fromName('gamma'), TestEnum.gamma);
      expect(values.fromName('delta'), isNull);
    });
  });
}
