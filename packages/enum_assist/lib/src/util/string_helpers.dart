/// {@template tab_indentation}
/// writes new line with tab indentation
/// {@endtemplate}
String tab(String s, [int n = 1]) {
  return '${tabIndentation * n}$s';
}

/// The tab indentation string.
const tabIndentation = '  ';

/// prepares values to be written to the output file
String prepareValueForGen<T>(T value) {
  if (value is String) {
    return "'$value'";
  }
  return '$value';
}
