// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: constant_identifier_names,prefer_const_declarations,unused_local_variable,prefer_int_literals,lines_longer_than_80_chars,prefer_const_constructors

part of 'enums.dart';

// **************************************************************************
// EnumAssistGenerator
// **************************************************************************

/// Extensions for the enum SerializedFormat
extension SerializedFormatX on SerializedFormat {
  /// Map of all values of the enum
  T map<T extends Object?>({
    required T camel,
    required T capital,
    required T constant,
    required T dot,
    required T header,
    required T kebab,
    required T no,
    required T none,
    required T pascal,
    required T path,
    required T sentence,
    required T snake,
    required T swap,
  }) {
    switch (this) {
      case SerializedFormat.camel:
        return camel;
      case SerializedFormat.capital:
        return capital;
      case SerializedFormat.constant:
        return constant;
      case SerializedFormat.dot:
        return dot;
      case SerializedFormat.header:
        return header;
      case SerializedFormat.kebab:
        return kebab;
      case SerializedFormat.no:
        return no;
      case SerializedFormat.none:
        return none;
      case SerializedFormat.pascal:
        return pascal;
      case SerializedFormat.path:
        return path;
      case SerializedFormat.sentence:
        return sentence;
      case SerializedFormat.snake:
        return snake;
      case SerializedFormat.swap:
        return swap;
    }
  }

  /// Optionally map all values of the enum
  ///
  /// default value is provided when value has not been mapped
  T maybeMap<T extends Object?>({
    required T orElse,
    T? camel,
    T? capital,
    T? constant,
    T? dot,
    T? header,
    T? kebab,
    T? no,
    T? none,
    T? pascal,
    T? path,
    T? sentence,
    T? snake,
    T? swap,
  }) {
    var isNullable = true;
    try {
      final value = null as T;
    } catch (_) {
      isNullable = false;
    }

    switch (this) {
      case SerializedFormat.camel:
        if (camel == null && !isNullable) return orElse;
        return camel as T;
      case SerializedFormat.capital:
        if (capital == null && !isNullable) return orElse;
        return capital as T;
      case SerializedFormat.constant:
        if (constant == null && !isNullable) return orElse;
        return constant as T;
      case SerializedFormat.dot:
        if (dot == null && !isNullable) return orElse;
        return dot as T;
      case SerializedFormat.header:
        if (header == null && !isNullable) return orElse;
        return header as T;
      case SerializedFormat.kebab:
        if (kebab == null && !isNullable) return orElse;
        return kebab as T;
      case SerializedFormat.no:
        if (no == null && !isNullable) return orElse;
        return no as T;
      case SerializedFormat.none:
        if (none == null && !isNullable) return orElse;
        return none as T;
      case SerializedFormat.pascal:
        if (pascal == null && !isNullable) return orElse;
        return pascal as T;
      case SerializedFormat.path:
        if (path == null && !isNullable) return orElse;
        return path as T;
      case SerializedFormat.sentence:
        if (sentence == null && !isNullable) return orElse;
        return sentence as T;
      case SerializedFormat.snake:
        if (snake == null && !isNullable) return orElse;
        return snake as T;
      case SerializedFormat.swap:
        if (swap == null && !isNullable) return orElse;
        return swap as T;
    }
  }

  /// Returns the name of the enum field
  /// in a human readable format.
  String get name {
    return map(
      camel: 'Camel',
      capital: 'Capital',
      constant: 'Constant',
      dot: 'Dot',
      header: 'Header',
      kebab: 'Kebab',
      no: 'No',
      none: 'None',
      pascal: 'Pascal',
      path: 'Path',
      sentence: 'Sentence',
      snake: 'Snake',
      swap: 'Swap',
    );
  }

  /// Returns the description of the enum field.
  ///
  /// If the description is null, the doc comment of the enum field is returned.
  String? get description {
    return map(
      camel: '''
Converts to a string with the separators denoted
by having the next letter capitalized

(e.g. `'hello_world' -> 'helloWorld'`)
''',
      capital: '''
Converts to a lowercased, first letter captialized word,
space separated string of every word

(e.g. `'hello world' -> 'Hello World'`)
''',
      constant: '''
Converts to an upper case, underscore separated string

(e.g. `'hello world' -> 'HELLO_WORLD'`)
''',
      dot: '''
Converts to a lower case period separated string

(e.g. `'hello World' -> 'hello.World'`)
''',
      header: '''
Converts to a captialized word, dash separated string

(e.g. `'hello world' -> 'Hello-World'`)
''',
      kebab: '''
Converts to a lower case, dash separated string

(e.g. `'hello World' -> 'hello-world'`)
''',
      no: '''
Converts the string without any casing (lower case, space separated)

(e.g. `'Hello-World' -> 'hello world'`)
''',
      none: '''
does not format the value
(e.g. `fieldName` remains `fieldName`).
''',
      pascal: '''
Converts to a string denoted in the same fashion as [camel]
but with the first letter capitalized

(e.g. `'hello_world' -> 'HelloWorld'`)
''',
      path: '''
Converts to a lower case, slash separated string

(e.g. `'hello World' -> 'hello/world'`)
''',
      sentence: '''
Converts to a lower case, space separated string
with the first letter capitalized

(e.g. `'hello World' -> 'Hello world'`)
''',
      snake: '''
Converts to a lower case, underscore separated string

(e.g. `'hello World' -> 'hello_world'`)
''',
      swap: '''
Converts to a string with every character case reversed

(e.g. `'Hello World' -> 'hELLO wORLD'`)
''',
    );
  }

  /// Returns the serialized value of the enum field.
  String get serialized {
    return map(
      camel: SerializedFormatConv._camelName,
      capital: SerializedFormatConv._capitalName,
      constant: SerializedFormatConv._constantName,
      dot: SerializedFormatConv._dotName,
      header: SerializedFormatConv._headerName,
      kebab: SerializedFormatConv._kebabName,
      no: SerializedFormatConv._noName,
      none: SerializedFormatConv._noneName,
      pascal: SerializedFormatConv._pascalName,
      path: SerializedFormatConv._pathName,
      sentence: SerializedFormatConv._sentenceName,
      snake: SerializedFormatConv._snakeName,
      swap: SerializedFormatConv._swapName,
    );
  }
}

/// {@template serialized_format.json_converter}
/// Serializes [SerializedFormat] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @SerializedFormatConv()
/// final SerializedFormat myEnum;
/// ```
/// {@endtemplate}
class SerializedFormatConv extends JsonConverter<SerializedFormat, String> {
  /// {@macro serialized_format.json_converter}
  const SerializedFormatConv({this.defaultValue});

  /// the value to be used when no match is found
  final SerializedFormat? defaultValue;

  /// {@macro serialized_format.json_converter_nullable}
  static const nullable = _SerializedFormatNullableConv();

  static const _camelName = 'camel';
  static const _capitalName = 'capital';
  static const _constantName = 'constant';
  static const _dotName = 'dot';
  static const _headerName = 'header';
  static const _kebabName = 'kebab';
  static const _noName = 'no';
  static const _noneName = 'none';
  static const _pascalName = 'pascal';
  static const _pathName = 'path';
  static const _sentenceName = 'sentence';
  static const _snakeName = 'snake';
  static const _swapName = 'swap';

  @override
  SerializedFormat fromJson(String json) {
    switch (json) {
      case _camelName:
        return SerializedFormat.camel;
      case _capitalName:
        return SerializedFormat.capital;
      case _constantName:
        return SerializedFormat.constant;
      case _dotName:
        return SerializedFormat.dot;
      case _headerName:
        return SerializedFormat.header;
      case _kebabName:
        return SerializedFormat.kebab;
      case _noName:
        return SerializedFormat.no;
      case _noneName:
        return SerializedFormat.none;
      case _pascalName:
        return SerializedFormat.pascal;
      case _pathName:
        return SerializedFormat.path;
      case _sentenceName:
        return SerializedFormat.sentence;
      case _snakeName:
        return SerializedFormat.snake;
      case _swapName:
        return SerializedFormat.swap;
      default:
        if (defaultValue != null) return defaultValue!;

        throw Exception('Unknown field: $json');
    }
  }

  @override
  String toJson(SerializedFormat object) => object.serialized;
}

/// {@template serialized_format.json_converter_nullable}
/// Serializes [SerializedFormat?] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @SerializedFormatConv.nullable
/// final SerializedFormat? myEnum;
/// ```
/// {@endtemplate}
class _SerializedFormatNullableConv
    extends JsonConverter<SerializedFormat?, String?> {
  /// {@macro serialized_format.json_converter}
  const _SerializedFormatNullableConv();

  @override
  SerializedFormat? fromJson(String? json) {
    switch (json) {
      case SerializedFormatConv._camelName:
        return SerializedFormat.camel;
      case SerializedFormatConv._capitalName:
        return SerializedFormat.capital;
      case SerializedFormatConv._constantName:
        return SerializedFormat.constant;
      case SerializedFormatConv._dotName:
        return SerializedFormat.dot;
      case SerializedFormatConv._headerName:
        return SerializedFormat.header;
      case SerializedFormatConv._kebabName:
        return SerializedFormat.kebab;
      case SerializedFormatConv._noName:
        return SerializedFormat.no;
      case SerializedFormatConv._noneName:
        return SerializedFormat.none;
      case SerializedFormatConv._pascalName:
        return SerializedFormat.pascal;
      case SerializedFormatConv._pathName:
        return SerializedFormat.path;
      case SerializedFormatConv._sentenceName:
        return SerializedFormat.sentence;
      case SerializedFormatConv._snakeName:
        return SerializedFormat.snake;
      case SerializedFormatConv._swapName:
        return SerializedFormat.swap;
      default:
        return null;
    }
  }

  @override
  String? toJson(SerializedFormat? object) => object?.serialized;
}

/// Extensions for the enum MethodType
extension MethodTypeX on MethodType {
  /// Map of all values of the enum
  T map<T extends Object?>({
    required T map,
    required T maybeMap,
  }) {
    switch (this) {
      case MethodType.map:
        return map;
      case MethodType.maybeMap:
        return maybeMap;
    }
  }

  /// Optionally map all values of the enum
  ///
  /// default value is provided when value has not been mapped
  T maybeMap<T extends Object?>({
    required T orElse,
    T? map,
    T? maybeMap,
  }) {
    var isNullable = true;
    try {
      final value = null as T;
    } catch (_) {
      isNullable = false;
    }

    switch (this) {
      case MethodType.map:
        if (map == null && !isNullable) return orElse;
        return map as T;
      case MethodType.maybeMap:
        if (maybeMap == null && !isNullable) return orElse;
        return maybeMap as T;
    }
  }

  /// Returns the name of the enum field
  /// in a human readable format.
  String get name {
    return map(
      map: 'Map',
      maybeMap: 'Maybe Map',
    );
  }

  /// Returns the description of the enum field.
  ///
  /// If the description is null, the doc comment of the enum field is returned.
  String? get description {
    return map(
      map: '''
The generated method will be `map(...)`.

Requires an extension declaration in [EnumKey.extensions]
on __ALL__ enum fields
___except when___ [Extension.allowNulls] is set to `true`
''',
      maybeMap: '''
The generated method will be `maybeMap(...)`.

Requires at least one extension declaration in the [EnumKey.extensions]
annotation on any enum field

Returns [Extension.defaultValue], or `null`
if [Extension.allowNulls] is `true`
''',
    );
  }

  /// Returns the serialized value of the enum field.
  String get serialized {
    return map(
      map: MethodTypeConv._mapName,
      maybeMap: MethodTypeConv._maybeMapName,
    );
  }
}

/// {@template method_type.json_converter}
/// Serializes [MethodType] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @MethodTypeConv()
/// final MethodType myEnum;
/// ```
/// {@endtemplate}
class MethodTypeConv extends JsonConverter<MethodType, String> {
  /// {@macro method_type.json_converter}
  const MethodTypeConv({this.defaultValue});

  /// the value to be used when no match is found
  final MethodType? defaultValue;

  /// {@macro method_type.json_converter_nullable}
  static const nullable = _MethodTypeNullableConv();

  static const _mapName = 'map';
  static const _maybeMapName = 'maybeMap';

  @override
  MethodType fromJson(String json) {
    switch (json) {
      case _mapName:
        return MethodType.map;
      case _maybeMapName:
        return MethodType.maybeMap;
      default:
        if (defaultValue != null) return defaultValue!;

        throw Exception('Unknown field: $json');
    }
  }

  @override
  String toJson(MethodType object) => object.serialized;
}

/// {@template method_type.json_converter_nullable}
/// Serializes [MethodType?] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @MethodTypeConv.nullable
/// final MethodType? myEnum;
/// ```
/// {@endtemplate}
class _MethodTypeNullableConv extends JsonConverter<MethodType?, String?> {
  /// {@macro method_type.json_converter}
  const _MethodTypeNullableConv();

  @override
  MethodType? fromJson(String? json) {
    switch (json) {
      case MethodTypeConv._mapName:
        return MethodType.map;
      case MethodTypeConv._maybeMapName:
        return MethodType.maybeMap;
      default:
        return null;
    }
  }

  @override
  String? toJson(MethodType? object) => object?.serialized;
}
