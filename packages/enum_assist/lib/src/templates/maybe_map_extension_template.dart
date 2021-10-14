import 'package:enum_assist/src/templates/template_core.dart';
import 'package:enum_assist/src/util/util.dart';

/// {@template enum_assist.map_template}
/// Returns the map extension template
/// {@endtemplate}
class MaybeMapTemplate extends TemplateCoreSimple<_Item> {
  /// {@macro enum_assist.map_template}
  MaybeMapTemplate(String enumName, Iterable<String> fields)
      : super(enumName, fields);

  @override
  StringBuffer writeTemplate(StringBuffer buffer) {
    buffer
      ..writeln('''
/// Optionally map all values of the enum
///
/// default value is provided when value has not been mapped''')
      ..writeobj(
        'T maybeMap<T>',
        open: '({',
        body: (mapBuffer, tab) {
          mapBuffer
            ..writelnTab('required T orElse,', tab)
            ..writeln(map((i) => tabn(i.arg, tab)));
        },
        close: '})',
      )
      ..writeobj(
        '',
        body: (mapBuff, bodyTab) {
          mapBuff.writeobj(
            'switch(this)',
            tab: bodyTab,
            body: (switchBuff, switchTab) {
              String caseItem(_Item item) {
                String _tab([int n = 0]) => tabn('', switchTab + n);

                return item.caseItem(_tab(), _tab(1));
              }

              switchBuff.writeln(map(caseItem));
            },
          );
        },
      ); // maybeMap

    return buffer;
  }

  @override
  _Item convert(String e) => _Item(enumName, e);
}

class _Item extends FieldTemplate<String> {
  const _Item(String enumName, String field) : super(enumName, field);

  String get orElseCheck => 'if ($field == null) return orElse;';

  String get arg => 'T? $field,';

  String get wholeEnum => '$enumName.$field';

  String get caseString => 'case $wholeEnum:';

  String get returnString => 'return $field;';

  String caseItem(String caseTab, String returnTab) => '''
$caseTab$caseString
$returnTab$orElseCheck
$returnTab$returnString''';
}
