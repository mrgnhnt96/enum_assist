import 'package:enum_assist/src/templates/template_core.dart';
import 'package:enum_assist/src/util/util.dart';

/// {@template enum_assist.map_template}
/// Returns the map extension template
/// {@endtemplate}
class MapTemplate extends TemplateCoreSimple<_Item> {
  /// {@macro enum_assist.map_template}
  MapTemplate(String enumName, Iterable<String> fields)
      : super(enumName, fields);

  @override
  StringBuffer writeTemplate(StringBuffer buffer) {
    buffer
      ..writeln('/// Map of all values of the enum')
      ..writeobj(
        'T map<T extends Object?>',
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
              String cases(_Item item) {
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
  _Item convert(String e) => _Item(enumName, e);
}

class _Item extends FieldTemplate<String> {
  const _Item(String enumName, String field) : super(enumName, field);

  String get arg => 'required T $field,';
  String get wholeEnum => '$enumName.$field';
  String get caseString => 'case $wholeEnum:';
  String get returnString => 'return $field;';
  String caseItem(String caseTab, String returnTab) => '''
$caseTab$caseString
$returnTab$returnString''';
}
