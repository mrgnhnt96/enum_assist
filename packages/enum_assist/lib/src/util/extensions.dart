import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:enum_assist/src/util/string_helpers.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:source_gen/source_gen.dart';

export 'package:change_case/change_case.dart';

/// extension to [StringBuffer]
extension StringBufferX on StringBuffer {
  /// {@macro tab_indentation}
  void writelnTab(String s, [int n = 1]) {
    writeln(tab(s, n));
  }

  /// {@macro tab_indentation}
  void writeTab(String s, [int n = 1]) {
    write(tab(s, n));
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

/// extension to [TypeChecker]

extension TypeCheckerX on TypeChecker {
  /// retrieves the object form the annotation on an [element]
  DartObject? getObjectFromAnnotation(FieldElement element) {
    final object = firstAnnotationOf(element);

    if (object != null) return object;

    if (element.getter != null) {
      return firstAnnotationOf(element.getter!);
    }
  }
}

/// Extensions for FieldElement
extension FieldElementX on FieldElement {
  /// gets the first annotation of [EnumValue]
  ElementAnnotation? getEnumValueAnnotation() {
    try {
      return metadata
          .firstWhere((data) => data.toSource().contains('$EnumValue'));
    } catch (_) {
      return null;
    }
  }
}
