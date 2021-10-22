import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'enums.ge.dart';

/// {@template enum_assist_annotation.serialized_format}
/// The serialized format of the enum's fields
/// {@endtemplate}
@EnumAssist()
enum SerializedFormat {
  /// {@template enum_assist_annotation.serialized_format.camel}
  /// Converts to a string with the separators denoted
  /// by having the next letter capitalized
  ///
  /// (e.g. `'hello_world' -> 'helloWorld'`)
  /// {@endtemplate}
  camel,

  /// {@template enum_assist_annotation.serialized_format.capital}
  /// Converts to a lowercased, first letter captialized word,
  /// space separated string of every word
  ///
  /// (e.g. `'hello world' -> 'Hello World'`)
  /// {@endtemplate}
  capital,

  /// {@template enum_assist_annotation.serialized_format.constant}
  /// Converts to an upper case, underscore separated string
  ///
  /// (e.g. `'hello world' -> 'HELLO_WORLD'`)
  /// {@endtemplate}
  constant,

  /// {@template enum_assist_annotation.serialized_format.dot}
  /// Converts to a lower case period separated string
  ///
  /// (e.g. `'hello World' -> 'hello.World'`)
  /// {@endtemplate}
  dot,

  /// {@template enum_assist_annotation.serialized_format.header}
  /// Converts to a captialized word, dash separated string
  ///
  /// (e.g. `'hello world' -> 'Hello-World'`)
  /// {@endtemplate}
  header,

  /// {@template enum_assist_annotation.serialized_format.kebab}
  /// Converts to a lower case, dash separated string
  ///
  /// (e.g. `'hello World' -> 'hello-world'`)
  /// {@endtemplate}
  kebab,

  /// {@template enum_assist_annotation.serialized_format.no}
  /// Converts the string without any casing (lower case, space separated)
  ///
  /// (e.g. `'Hello-World' -> 'hello world'`)
  /// {@endtemplate}
  no,

  /// {@template enum_assist_annotation.serialized_format.none}
  /// does not format the value
  /// (e.g. `fieldName` remains `fieldName`).
  /// {@endtemplate}
  none,

  /// {@template enum_assist_annotation.serialized_format.pascal}
  /// Converts to a string denoted in the same fashion as [camel]
  /// but with the first letter capitalized
  ///
  /// (e.g. `'hello_world' -> 'HelloWorld'`)
  /// {@endtemplate}
  pascal,

  /// {@template enum_assist_annotation.serialized_format.path}
  /// Converts to a lower case, slash separated string
  ///
  /// (e.g. `'hello World' -> 'hello/world'`)
  /// {@endtemplate}
  path,

  /// {@template enum_assist_annotation.serialized_format.sentence}
  /// Converts to a lower case, space separated string
  /// with the first letter capitalized
  ///
  /// (e.g. `'hello World' -> 'Hello world'`)
  /// {@endtemplate}
  sentence,

  /// {@template enum_assist_annotation.serialized_format.snake}
  /// Converts to a lower case, underscore separated string
  ///
  /// (e.g. `'hello World' -> 'hello_world'`)
  /// {@endtemplate}
  snake,

  /// {@template enum_assist_annotation.serialized_format.swap}
  /// Converts to a string with every character case reversed
  ///
  /// (e.g. `'Hello World' -> 'hELLO wORLD'`)
  /// {@endtemplate}
  swap,
}

/// {@template enum_assist_annotation.method_type}
/// Specifies how the generated method will be created
/// {@endtemplate}
///
/// ### Map
/// {@macro enum_assist_annotation.method_type.map}
///
/// ### Maybe Map
/// {@macro enum_assist_annotation.method_type.maybe_map}
@EnumAssist()
enum MethodType {
  /// {@template enum_assist_annotation.method_type.map}
  /// The generated method will be `map(...)`.
  ///
  /// Requires an extension declaration in [EnumKey.extensions]
  /// on __ALL__ enum fields
  /// ___except when___ [Extension.allowNulls] is set to `true`
  /// {@endtemplate}
  map,

  /// {@template enum_assist_annotation.method_type.maybe_map}
  /// The generated method will be `maybeMap(...)`.
  ///
  /// Requires at least one extension declaration in the [EnumKey.extensions]
  /// annotation on any enum field
  ///
  /// Returns [Extension.defaultValue], or `null`
  /// if [Extension.allowNulls] is `true`
  /// {@endtemplate}
  maybeMap,
}
