import 'package:meta/meta.dart';

/// matches a set of brackets from a given string
Bracket? matchBracket(String str, String bracket, [int? bracketIndex]) {
  const _openingBrackets = ['[', '(', '{', '<'];

  final openingBracketPattern = RegExp('[${_openingBrackets.join()}]');
  final closingBracketPattern = RegExp(r'[\])}>]');
  final quotesPattern = RegExp('["\']');
  // ignore: prefer_interpolation_to_compose_strings
  final allPattern = RegExp('[' +
      _getPattern(quotesPattern) +
      _getPattern(closingBracketPattern) +
      _getPattern(openingBracketPattern) +
      ']');

  if (openingBracketPattern.hasMatch(bracket)) {
    bracket = _getOpposite(bracket)!;
  }

  assert(closingBracketPattern.hasMatch(bracket));

  final symbols = {for (final symbol in _openingBrackets) symbol: <int>[]};
  final closingSymbols = <String, Bracket?>{
    for (final symbol in _openingBrackets) symbol: null
  };

  final quotes = <String, int>{};

  var index = -1;
  for (final char in str.split('')) {
    index++;
    if (!allPattern.hasMatch(char)) continue;

    if (openingBracketPattern.hasMatch(char)) {
      /// make sure we are not in a quote
      if (quotes.isNotEmpty) continue;

      symbols[char]!.add(index);
    } else if (closingBracketPattern.hasMatch(char)) {
      final opposite = _getOpposite(char);

      /// make sure we are not in a quote
      if (quotes.isNotEmpty) continue;

      if (symbols[opposite]!.isNotEmpty) {
        var returnNow = false;
        if (bracketIndex != null &&
            symbols[opposite]!.length - 1 == bracketIndex &&
            bracket == char) {
          returnNow = true;
        }

        final start = symbols[opposite]!.removeLast();
        final _bracket = Bracket(start, index, str);
        closingSymbols[char] = _bracket;

        if (returnNow) return _bracket;
      }
    } else if (quotesPattern.hasMatch(char)) {
      if (quotes.isEmpty) {
        quotes[char] = index;
        continue;
      }

      // check if quote has preceeding backslash
      final preceedingChar = str.substring(index - 1, index);
      if (preceedingChar == r'\') continue;

      // check if single quote within double quotes
      if (quotes.containsKey("'") && char == '"') continue;

      // check if double quote within single quotes
      if (quotes.containsKey('"') && char == "'") continue;

      quotes.remove(char);
    }
  }

  return closingSymbols[bracket];
}

String _getPattern(RegExp regExp) {
  return regExp.pattern.substring(1, regExp.pattern.length - 1);
}

String? _getOpposite(String char) {
  switch (char) {
    case '[':
      return ']';
    case '(':
      return ')';
    case '{':
      return '}';
    case '<':
      return '>';
    case ']':
      return '[';
    case ')':
      return '(';
    case '}':
      return '{';
    case '>':
      return '<';
    default:
      return null;
  }
}

/// {@template bracket_matching}
/// details of a set of brackets in a string
/// {@endtemplate}
@immutable
class Bracket {
  /// {@macro bracket_matching}
  const Bracket(
    this.start,
    this.end,
    this.originalStr,
  );

  /// the index of the first bracket
  final int start;

  /// the index of the last bracket
  final int end;

  /// the original string
  final String originalStr;

  /// the string between the brackets
  String get contents => originalStr.substring(start + 1, end);

  @override
  String toString() =>
      'Bracket=start: $start, end: $end, contents: ---$contents---';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Bracket &&
        other.start == start &&
        other.end == end &&
        other.originalStr == originalStr;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode ^ originalStr.hashCode;
}
