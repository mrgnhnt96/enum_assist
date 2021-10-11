/// {@template tab_indentation}
/// writes new line with tab indentation
/// {@endtemplate}
String tab(String s, [int n = 1]) {
  return '${tabIndentation * n}$s';
}

/// The tab indentation string.
const tabIndentation = '  ';
