import 'package:enum_assist/src/enum_field.dart';
import 'package:enum_assist/src/util/string_helpers.dart';
import 'package:meta/meta.dart';

/// {@template enum_assist.template_core}
/// helper class to format generated code
/// {@endtemplate}
abstract class FieldTemplate<T> {
  /// {@template enum_assist.template_core}
  /// helper class to format generated code
  /// {@endtemplate}
  const FieldTemplate(this.enumName, this.field);

  /// the name of the enum
  final String enumName;

  /// the field to format
  ///
  /// Will always be null in [TemplateCore]
  final T field;
}

/// {@template enum_assist.template_core}
/// helper class to format generated code
/// {@endtemplate}
abstract class TemplateCore<T extends FieldTemplate<R>, R> {
  /// {@macro enum_assist.template_core}
  TemplateCore(this.enumName, this.fields);

  /// the name of the enum
  @protected
  @nonVirtual
  final String enumName;

  /// All fields for enum
  @protected
  @nonVirtual
  final Iterable<R> fields;

  @protected
  @nonVirtual
  final _buffer = StringBuffer();

  /// {@macro tab_indentation}
  @protected
  @nonVirtual
  String get tb => tab('');

  /// {@macro tab_indentation}
  @protected
  @nonVirtual
  String tabn(String s, [int n = 1]) => tab(s, n);

  /// maps out all fields to [T]
  ///
  /// returns joined string
  @protected
  @nonVirtual
  String map(String Function(T) i) {
    return formatFields.map((e) => i(e)).join('\n');
  }

  /// Starts the template with the provided buffer.
  StringBuffer writeTemplate(StringBuffer buffer);

  @override
  @nonVirtual
  String toString() {
    return writeTemplate(_buffer).toString();
  }

  /// fields to be used in the template
  ///
  /// prepped with quick templates for code generation
  @protected
  @nonVirtual
  Iterable<T> get formatFields => fields.map(convert);

  /// converts a field to [T]
  T convert(R e);
}

/// {@macro enum_assist.template_core}
abstract class TemplateCoreSimple<T extends FieldTemplate<String>>
    extends TemplateCore<T, String> {
  /// {@macro enum_assist.template_core}
  TemplateCoreSimple(String enumName, Iterable<String> fields)
      : super(enumName, fields);
}

/// {@macro enum_assist.template_core}
abstract class TemplateCoreDetailed<T extends FieldTemplate<EnumField>>
    extends TemplateCore<T, EnumField> {
  /// {@macro enum_assist.template_core}
  TemplateCoreDetailed(String enumName, Iterable<EnumField> fields)
      : super(enumName, fields);
}
