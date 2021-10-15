import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'enums.ge.dart';

/// {@template enum_assist_annotation.serialized_format}
/// Formats the field name when serializing.
/// {@endtemplate}
@EnumAssist()
enum SerializedFormat {
  /// {@template enum_assist_annotation.serialized_format.camel}
  /// Converts to a string with the separators denoted
  /// by having the next letter capitalized
  ///
  /// example:
  ///
  /// `'hello_world' -> 'helloWorld'`
  /// {@endtemplate}
  camel,

  /// {@template enum_assist_annotation.serialized_format.capital}
  /// Converts to a lowercased, first letter captialized word,
  /// space separated string of every word
  ///
  /// example:
  ///
  /// `'hello world' -> 'Hello World'`
  /// {@endtemplate}
  capital,

  /// {@template enum_assist_annotation.serialized_format.constant}
  /// Converts to an upper case, underscore separated string
  ///
  /// example:
  ///
  /// `'hello world' -> 'HELLO_WORLD'`
  /// {@endtemplate}
  constant,

  /// {@template enum_assist_annotation.serialized_format.dot}
  /// Converts to a lower case period separated string
  ///
  /// example:
  ///
  /// `'hello World' -> 'hello.World'`
  /// {@endtemplate}
  dot,

  /// {@template enum_assist_annotation.serialized_format.header}
  /// Converts to a captialized word, dash separated string
  ///
  /// example:
  ///
  /// `'hello world' -> 'Hello-World'`
  /// {@endtemplate}
  header,

  /// {@template enum_assist_annotation.serialized_format.kebab}
  /// Converts to a lower case, dash separated string
  ///
  /// example:
  ///
  /// `'hello World' -> 'hello-world'`
  /// {@endtemplate}
  kebab,

  /// {@template enum_assist_annotation.serialized_format.no}
  /// Converts the string without any casing (lower case, space separated)
  ///
  /// example:
  ///
  /// `'Hello-World' -> 'hello world'`
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
  /// example:
  ///
  /// `'hello_world' -> 'HelloWorld'`
  /// {@endtemplate}
  pascal,

  /// {@template enum_assist_annotation.serialized_format.path}
  /// Converts to a lower case, slash separated string
  ///
  /// example:
  ///
  /// `'hello World' -> 'hello/world'`
  /// {@endtemplate}
  path,

  /// {@template enum_assist_annotation.serialized_format.sentence}
  /// Converts to a lower case, space separated string
  /// with the first letter capitalized
  ///
  /// example:
  ///
  /// `'hello World' -> 'Hello world'`
  /// {@endtemplate}
  sentence,

  /// {@template enum_assist_annotation.serialized_format.snake}
  /// Converts to a lower case, underscore separated string
  ///
  /// example:
  ///
  /// `'hello World' -> 'hello_world'`
  /// {@endtemplate}
  snake,

  /// {@template enum_assist_annotation.serialized_format.swap}
  /// Converts to a string with every character case reversed
  ///
  /// example:
  ///
  /// `'Hello World' -> 'hELLO wORLD'`
  /// {@endtemplate}
  swap,
}

/// {@template enum_assist.method_type}
/// Determines how to set up the generated method.
/// {@endtemplate}
@EnumAssist()
enum MethodType {
  /// The generated method will be `map(...)`.
  ///
  /// requires annotation [EnumKey] on all enum values
  map,

  /// The generated method will be `maybeMap(...)`.
  ///
  /// __does not__ require annotation [EnumKey] all enum values
  maybeMap,
}
