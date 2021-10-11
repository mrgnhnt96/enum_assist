import 'package:enum_assist/src/templates/template_core.dart';
import 'package:enum_assist/src/util/util.dart';

/// {@template enum_assist.map_template}
/// Returns the map extension template
/// {@endtemplate}
class MapTemplate extends TemplateCoreSimple<_MapItem> {
  /// {@macro enum_assist.map_template}
  MapTemplate(String enumName, Iterable<String> fields)
      : super(enumName, fields);

  @override
  StringBuffer writeTemplate(StringBuffer buffer) {
    buffer
      ..writeobj(
        'T map<T>',
        open: '({',
        body: (mapBuffer, tab) {
          mapBuffer.writeln(map((i) => tabn(i.arg, tab)));
        },
        close: '})',
      )
      ..writeobj(
        '',
        body: (bodyBuffer, bodyTab) {
          bodyBuffer.writeobj(
            'switch(this)',
            tab: bodyTab,
            body: (switchBuffer, bodyTab) {
              String cases(_MapItem item) {
                String _tab([int n = 0]) => tabn('', bodyTab + n);
                return item.caseItem(_tab(), _tab(1));
              }

              switchBuffer.writeln(map(cases));
            },
          );
        },
      );

    return buffer;
  }

  @override
  _MapItem convert(String e) => _MapItem(enumName, e);
}

class _MapItem extends FieldTemplate<String> {
  const _MapItem(String enumName, String field) : super(enumName, field);

  String get arg => 'required T $field,';
  String get wholeEnum => '$enumName.$field';
  String get caseString => 'case $wholeEnum:';
  String get returnString => 'return $field;';
  String caseItem(String caseTab, String returnTab) => '''
$caseTab$caseString
$returnTab$returnString''';
}
