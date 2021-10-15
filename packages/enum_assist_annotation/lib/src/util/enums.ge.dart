// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file:

part of 'enums.dart';

// **************************************************************************
// EnumAssistGenerator
// **************************************************************************

/// Extensions for the enum SerializedFormat
extension SerializedFormatX on SerializedFormat {
  /// Map of all values of the enum
  T map<T>({
    required T camel,
    required T constant,
    required T dot,
    required T kebab,
    required T no,
    required T none,
    required T pascal,
    required T path,
    required T sentence,
    required T snake,
    required T swap,
    required T capital,
    required T header,
  }) {
    switch (this) {
      case SerializedFormat.camel:
        return camel;
      case SerializedFormat.constant:
        return constant;
      case SerializedFormat.dot:
        return dot;
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
      case SerializedFormat.capital:
        return capital;
      case SerializedFormat.header:
        return header;
    }
  }

  /// Optionally map all values of the enum
  ///
  /// default value is provided when value has not been mapped
  T maybeMap<T>({
    required T orElse,
    T? camel,
    T? constant,
    T? dot,
    T? kebab,
    T? no,
    T? none,
    T? pascal,
    T? path,
    T? sentence,
    T? snake,
    T? swap,
    T? capital,
    T? header,
  }) {
    switch (this) {
      case SerializedFormat.camel:
        if (camel == null) return orElse;
        return camel;
      case SerializedFormat.constant:
        if (constant == null) return orElse;
        return constant;
      case SerializedFormat.dot:
        if (dot == null) return orElse;
        return dot;
      case SerializedFormat.kebab:
        if (kebab == null) return orElse;
        return kebab;
      case SerializedFormat.no:
        if (no == null) return orElse;
        return no;
      case SerializedFormat.none:
        if (none == null) return orElse;
        return none;
      case SerializedFormat.pascal:
        if (pascal == null) return orElse;
        return pascal;
      case SerializedFormat.path:
        if (path == null) return orElse;
        return path;
      case SerializedFormat.sentence:
        if (sentence == null) return orElse;
        return sentence;
      case SerializedFormat.snake:
        if (snake == null) return orElse;
        return snake;
      case SerializedFormat.swap:
        if (swap == null) return orElse;
        return swap;
      case SerializedFormat.capital:
        if (capital == null) return orElse;
        return capital;
      case SerializedFormat.header:
        if (header == null) return orElse;
        return header;
    }
  }

  /// Returns the name of the enum field
  /// in a human readable format.
  String get name {
    return map(
      camel: 'Camel',
      constant: 'Constant',
      dot: 'Dot',
      kebab: 'Kebab',
      no: 'No',
      none: 'None',
      pascal: 'Pascal',
      path: 'Path',
      sentence: 'Sentence',
      snake: 'Snake',
      swap: 'Swap',
      capital: 'Capital',
      header: 'Header',
    );
  }

  /// Returns the description of the enum field.
  ///
  /// If the description is null, the doc comment of the enum field is returned.
  String? get description {
    return maybeMap(
      orElse: null,
      camel: '''
Converts to a string with the separators denoted
by having the next letter capitalized

example:

`'hello_world' -> 'helloWorld'`
''',
      constant: '''
Converts to an upper case, underscore separated string

example:

`'hello world' -> 'HELLO_WORLD'`
''',
      dot: '''
Converts to a lower case period separated string

example:

`'hello World' -> 'hello.World'`
''',
      kebab: '''
Converts to a lower case, dash separated string

example:

`'hello World' -> 'hello-world'`
''',
      no: '''
Converts the string without any casing (lower case, space separated)

example:

`'Hello-World' -> 'hello world'`
''',
      none: '''
does not format the value
(e.g. `fieldName` remains `fieldName`).
''',
      pascal: '''
Converts to a string denoted in the same fashion as [camel]
but with the first letter capitalized

example:

`'hello_world' -> 'HelloWorld'`
''',
      path: '''
Converts to a lower case, slash separated string

example:

`'hello World' -> 'hello/world'`
''',
      sentence: '''
Converts to a lower case, space separated string
with the first letter capitalized

example:

`'hello World' -> 'Hello world'`
''',
      snake: '''
Converts to a lower case, underscore separated string

example:

`'hello World' -> 'hello_world'`
''',
      swap: '''
Converts to a string with every character case reversed

example:

`'Hello World' -> 'hELLO wORLD'`
''',
      capital: '''
Converts to a lowercased, first letter captialized word,
space separated string of every word

example:

`'hello world' -> 'Hello World'`
''',
      header: '''
Converts to a captialized word, dash separated string

example:

`'hello world' -> 'Hello-World'`
''',
    );
  }

  /// Returns the serialized value of the enum field.
  String get serialized {
    return map(
      camel: SerializedFormatConv._camelName,
      constant: SerializedFormatConv._constantName,
      dot: SerializedFormatConv._dotName,
      kebab: SerializedFormatConv._kebabName,
      no: SerializedFormatConv._noName,
      none: SerializedFormatConv._noneName,
      pascal: SerializedFormatConv._pascalName,
      path: SerializedFormatConv._pathName,
      sentence: SerializedFormatConv._sentenceName,
      snake: SerializedFormatConv._snakeName,
      swap: SerializedFormatConv._swapName,
      capital: SerializedFormatConv._capitalName,
      header: SerializedFormatConv._headerName,
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
  const SerializedFormatConv();

  static const _camelName = 'camel';
  static const _constantName = 'constant';
  static const _dotName = 'dot';
  static const _kebabName = 'kebab';
  static const _noName = 'no';
  static const _noneName = 'none';
  static const _pascalName = 'pascal';
  static const _pathName = 'path';
  static const _sentenceName = 'sentence';
  static const _snakeName = 'snake';
  static const _swapName = 'swap';
  static const _titleName = 'title';
  static const _capitalName = 'capital';
  static const _headerName = 'header';

  @override
  SerializedFormat fromJson(String json) {
    switch (json) {
      case _camelName:
        return SerializedFormat.camel;
      case _constantName:
        return SerializedFormat.constant;
      case _dotName:
        return SerializedFormat.dot;
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
      case _titleName:
        return SerializedFormat.capital;
      case _headerName:
        return SerializedFormat.header;
      default:
        throw Exception('Unknown field: $json');
    }
  }

  @override
  String toJson(SerializedFormat object) => object.serialized;
}

/// Extensions for the enum MethodType
extension MethodTypeX on MethodType {
  /// Map of all values of the enum
  T map<T>({
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
  T maybeMap<T>({
    required T orElse,
    T? map,
    T? maybeMap,
  }) {
    switch (this) {
      case MethodType.map:
        if (map == null) return orElse;
        return map;
      case MethodType.maybeMap:
        if (maybeMap == null) return orElse;
        return maybeMap;
    }
  }

  /// Returns the name of the enum field
  /// in a human readable format.
  String get name {
    return map(
      map: 'Map',
      maybeMap: 'maybeMap',
    );
  }

  /// Returns the description of the enum field.
  ///
  /// If the description is null, the doc comment of the enum field is returned.
  String? get description {
    return maybeMap(
      orElse: null,
      map: '''
The generated method will be `map(...)`.

requires annotation [EnumKey] on all enum values''',
      maybeMap: '''
The generated method will be `maybeMap(...)`.

__does not__ require annotation [EnumKey] all enum values''',
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
  const MethodTypeConv();

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
        throw Exception('Unknown field: $json');
    }
  }

  @override
  String toJson(MethodType object) => object.serialized;
}
