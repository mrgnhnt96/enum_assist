import 'package:enum_assist/src/util/string_helpers.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

/// Extension used for [FieldFormat]
extension FieldFormatX on FieldFormat {
  /// Returns the [FieldFormat] as a [FieldRename]
  FieldRename toRename() => map(
        kebab: FieldRename.kebab,
        snake: FieldRename.snake,
        pascal: FieldRename.pascal,
        none: FieldRename.none,
      );
}

/// extension to [StringBuffer]
extension StringBufferX on StringBuffer {
  /// {@macro tab_indentation}
  void writelnTab(String s, [int n = 1]) {
    writeln('${tabIndentation * n}$s');
  }

  /// {@macro tab_indentation}
  void writeTab(String s, [int n = 1]) {
    write('${tabIndentation * n}$s');
  }

  /// accepts a header string to name the section
  ///
  /// wraps the header with brakets
  void writeobj(
    String s, {
    required void Function(StringBuffer, int) body,
    int tab = 0,
    String? open,
    String? close,
    bool appendNewLine = true,
    bool includeSpaceBetweenOpen = true,
  }) {
    final openAndCloseAreNullOrNotNull = (open == null) ^ (close == null);
    if (openAndCloseAreNullOrNotNull) {
      throw ArgumentError(
        'open and close must both be null or both be non-null',
      );
    }

    final opener = open ?? '{';
    final closer = close ?? '}';
    final spacer = includeSpaceBetweenOpen ? ' ' : '';

    writelnTab('$s$spacer$opener', tab);
    body(this, tab + 1);
    if (appendNewLine) {
      writelnTab(closer, tab);
    } else {
      writeTab(closer, tab);
    }
  }
}
