part of 'extension_config.dart';

const _reservedWords = {
  // dart specific
  'continue': '',
  'false': '',
  'new': '',
  'this': '',
  'default': '',
  'final': '',
  'null': '',
  'throw': '',
  'assert': '',
  'finally': '',
  'true': '',
  'do': '',
  'for': '',
  'try': '',
  'rethrow': '',
  'else': '',
  'if': '',
  'return': '',
  'var': '',
  'break': '',
  'enum': '',
  'void': '',
  'case': '',
  'while': '',
  'catch': '',
  'in': '',
  'super': '',
  'with': '',
  'class': '',
  'extends': '',
  'is': '',
  'switch': '',
  'const': '',
  'bool': '',
  'double': '',
  'dynamic': '',
  'int': '',
  'num': '',
  // enum_assist specific
  'map': '',
  'maybeMap': '',
  'name': '',
  'description': '',
  'serialized': '',
};

/// Recursively returns the declared [ExtensionConfig.valueClassName] and
/// value from [EnumKey.extensions]
///
/// An extension consists of:
/// - [ExtensionConfig.valueClassName]
/// - [ExtensionConfig.value]?
///   - Returns [ExtensionConfig.value] if [Extension.value]
///     is an assigned argument
///
/// example:
///
/// Where `FactorsExt([List<int> values = [1, 2, 3]])`
///
/// Results can be:\
/// `FactorsExt([1, 3])`, `FactorsExt()`
List<String> _getExtensions(String str) {
  if (str.isEmpty) return [];

  final bracket = matchBracket(str, '(', 0);
  if (bracket == null) return [];

  final extClass = str.substring(0, bracket.start);
  final annotation = '$extClass(${bracket.contents})';
  final remaining = str.substring(min(bracket.end + 3, str.length));

  if (remaining.isEmpty) return [annotation];

  final ext = _getExtensions(remaining);

  return [annotation, ...ext];
}

/// Gets the literal extension declaration from the annotation
/// and returns them as a list
///
/// example:
///
/// Annotation:\
/// `@EnumKey(extensions: [ToMap({'thirty-three' : 33}), IsImportant(true)])`
///
/// Results in:\
/// `[ToMap({'thirty-three' : 33}), IsImportant(true)]`
List<String> _getExtensionAnnotation(ElementAnnotation data) {
  const comparable = 'extensions: [';
  const length = comparable.length;

  final detailsRaw = data.toSource();

  if (!detailsRaw.contains(comparable)) return [];

  var details = detailsRaw.substring(detailsRaw.indexOf(comparable) + length);

  details = details.substring(0, details.lastIndexOf(']'));

  final extensions = _getExtensions(details);

  return extensions;
}

/// Checks the [ExtensionConfig.methodName] for any reserved words
///
/// If the [ExtensionConfig.methodName] is a reserved word,
/// it will be renamed by appending `Ext`
String _checkMethodNameForReservedWords(
    String methodName, String enumAndField) {
  if (_reservedWords.containsKey(methodName)) {
    final replacement = '${methodName}Ext';
    GeneratorHelper.addToWarnings(
      warning: 'Reserved Word in Method Name',
      where: enumAndField,
      what: 'The method name "$methodName" is a reserved word '
          'and it cannot be used as a method name',
      action: '"$methodName" will be RENAMED to "$replacement"',
    );
    return replacement;
  }

  return methodName;
}

void _checkIfMethodNameIsUniqueToClass(
  String className,
  String methodName,
  Map<String, String> map,
  String enumAndField,
) {
  void checkIfMethodNameIsUnique() {
    if (!map.containsValue(methodName)) {
      map[className] = methodName;
      return;
    }

    final classes = map.entries
        .where((entry) => entry.value == methodName)
        .map((entry) => entry.key)
        .toList();

    if (classes.length == 1) return;

    final classesInError = classes.join(' & ');

    throw EnumException(
      error: 'Duplicated Method Name',
      where: enumAndField,
      what: 'The method "$methodName" has been '
          'defined in $classesInError',
      rule: 'Method names must be unique.',
      fix: 'Double Check $classesInError, and change one of the '
          'method names from "$methodName" and try again',
    );
  }

  // if class doesn't exist, add it and move on
  if (!map.containsKey(className)) {
    map[className] = methodName;

    checkIfMethodNameIsUnique();
    return;
  }

  // get method name and check that is matches [methodName]
  final existingMethodName = map[className];
  if (existingMethodName == methodName) return;

  // [methodName] did not match [existingMethodName]
  throw EnumException(
    error: 'Duplicated Method Name',
    where: enumAndField,
    what: '$className has different method names assigned, '
        '"$existingMethodName" and "$methodName" were found',
    rule: 'Method names must be unique for each `enum`',
    fix: 'Double Check $className, and change one of the '
        'method names from "$methodName" or $existingMethodName '
        'and try again',
  );
}

/// __Returns__ Map<[ExtensionConfig.valueClassName], [ExtensionConfig.value]>
///
/// Checks if the [ExtensionConfig.valueClassName] already exists
///
/// If it does exist, nothing is expected to happen
/// because the [ExtensionConfig.valueClassName] should be unique
/// for each annotation. There __cannot__ be duplicates
///
/// throws an [EnumException] if another [ExtensionConfig.valueClassName]
/// already exists
Map<String, String> _checkForDuplicateDeclarations(
    List<String> annotations, String enumAndField) {
  final topLevel = <String, String>{};

  void throwIfDuplicate(
    String extClassName,
  ) {
    if (!topLevel.containsKey(extClassName)) return;

    throw EnumException(
      error: 'Duplicated Extension Declaration',
      where: enumAndField,
      what: 'The extension "$extClassName" has been '
          'declared already for $enumAndField',
      rule: 'Extensions can only be declared '
          'once for a single enum field',
      fix: 'Double check the argument '
          '`extensions: [...]` in $enumAndField '
          '& change or remove a `$extClassName` declaration',
    );
  }

  for (final extClass in annotations) {
    final parenthesisPosition = extClass.indexOf('(');

    // skip extensions with an empty list
    if (parenthesisPosition == -1) continue;

    final name = extClass.substring(0, parenthesisPosition);

    throwIfDuplicate(name);

    var value = extClass.substring(
      parenthesisPosition + 1,
      extClass.length - 1,
    );

    if (value == '') {
      topLevel[name] = 'null';
      continue;
    }

    // splits the arguments by ": "
    final namedArgPattern = RegExp(r'(\w+: )(?![^(]*\))');
    if (namedArgPattern.hasMatch(value)) {
      // can't really know exactly where the value is,
      // so just assume its the first one...
      final args = value.split(namedArgPattern)..removeWhere((e) => e.isEmpty);

      value = args[0];
    }

    topLevel[name] = value;
  }

  return topLevel;
}

void _throwIfMissingField({
  required String? methodName,
  required MethodType? methodType,
  required bool? allowNulls,
  required String? value,
  required String enumAndField,
  required String extensionClassName,
}) {
  // should never throw, as all fields are required
  // non-nullable fields
  //
  // but just in case (also helps with null safety!)
  if (methodName == null ||
      methodType == null ||
      allowNulls == null ||
      value == null) {
    final missingFields = <String>[];

    if (methodName == null) missingFields.add('methodName');
    if (methodType == null) missingFields.add('methodType');
    if (allowNulls == null) missingFields.add('allowNulls');
    if (value == null) missingFields.add('value');

    final whatsMissing = missingFields.join(', ');

    throw EnumException(
      error: 'Missing Required Fields',
      where: enumAndField,
      rule: 'All methods must have a method name [methodName], '
          'method type, a value, and whether `null`s may '
          'be a return value [allowNulls]',
      what: 'The extension "$extensionClassName" is missing '
          'the following fields: $whatsMissing',
      fix: 'Double check $extensionClassName, found in the argument '
          "`extensions: [...]` from $enumAndField's annotation. "
          'Make sure that the fields: $whatsMissing, '
          'are properly assigned',
    );
  }
}

/// make sure we aren't returnning a null value
/// when the return type cannot be null
///
/// applies to [MethodType.map]
void _throwIfNullValueOnNonNullReturn({
  required String value,
  required bool allowNulls,
  required MethodType methodType,
  required String enumAndField,
  required String extensionClassName,
}) {
  final isValueNull = value == 'null';

  if (!isValueNull) return;

  if (allowNulls) return;

  // nulls are allowed for maybeMap
  if (methodType.map(map: false, maybeMap: true)) return;

  throw EnumException(
    error: 'Null Value on Non-Null Return Type',
    where: enumAndField,
    rule: 'On `.map()` methods, return `null` only when [allowNulls] is `true`',
    what: 'The value defined by extension "$extensionClassName"  is `null`, '
        'but the return type is not nullable',
    fix: 'Set "$extensionClassName" the return type to a non-null value OR '
        'Set [allowNulls] to `true` for extension "$extensionClassName"',
  );
}
