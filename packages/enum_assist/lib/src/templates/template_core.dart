import 'package:enum_assist/src/templates/item_core.dart';
import 'package:enum_assist/src/util/string_helpers.dart';

/// {@template enum_assist.template_core}
/// helper class to format generated code
/// {@endtemplate}

abstract class TemplateCore<T extends ItemCore> {
  /// {@macro enum_assist.template_core}
  TemplateCore(this.enumName, this.fields);

  /// All fields for enum
  final Iterable<String> fields;

  /// the name of the enum
  final String enumName;

  final _buffer = StringBuffer();

  /// All fields formatted to
  Iterable<T> get configFields;

  /// {@macro tab_indentation}
  String get tb => tab('');

  /// {@macro tab_indentation}
  String tabn(String s, [int n = 1]) => tab(s, n);

  /// maps out all fields to [T]
  ///
  /// returns joined string
  String map(String Function(T) i) {
    return configFields.map((e) => i(e)).join('\n');
  }

  /// Starts the template with the provided buffer.
  StringBuffer writeTemplate(StringBuffer buffer);

  @override
  String toString() {
    return writeTemplate(_buffer).toString();
  }
}
