import 'dart:convert';

class JsonFormatter {
  static String pretty(String jsonString) {
    final jsonObj = json.decode(jsonString);
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(jsonObj);
  }

  static String minify(String jsonString) {
    final jsonObj = json.decode(jsonString);
    return json.encode(jsonObj);
  }
}
