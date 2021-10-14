import 'package:enum_assist/src/enum_field.dart';
import 'package:enum_assist/src/templates/template_core.dart';
import 'package:enum_assist/src/util/string_helpers.dart';
import 'package:enum_assist/src/util/util.dart';

/// {@template enum_assist.map_template}
/// Returns the map extension template
/// {@endtemplate}
class JsonConverterTemplate extends TemplateCoreDetailed<_Item> {
  /// {@macro enum_assist.map_template}
  JsonConverterTemplate(String enumName, Iterable<EnumField> fields)
      : super(enumName, fields);

  @override
  StringBuffer writeTemplate(StringBuffer buffer) {
    buffer
      ..writeln('''
/// {@template ${enumName.toSnakeCase()}.json_converter}
/// Serializes [$enumName] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// @${enumName}Conv()
/// final $enumName myEnum;
/// ```
/// {@endtemplate}''')
      ..writeobj(
        'class ${enumName}Conv extends JsonConverter<$enumName, String>',
        body: (classBuff, classTab) {
          classBuff
            ..writelnTab(
                '/// {@macro ${enumName.toSnakeCase()}.json_converter}',
                classTab)
            ..writelnTab('const ${enumName}Conv();\n', classTab)
            ..writeln(map((i) => tab(i.privateFieldGetter, classTab)))
            ..writeln()
            ..writelnTab('@override', classTab)
            ..writeobj(
              '$enumName fromJson(String json)',
              tab: classTab,
              body: (fromBuff, fromTab) {
                fromBuff.writeobj(
                  'switch (json)',
                  tab: fromTab,
                  body: (switchBuff, switchTab) {
                    String fromCase(_Item i) {
                      String _tab([int n = 0]) => tab('', switchTab + n);

                      return i.fromCaseItem(_tab(), _tab(1));
                    }

                    switchBuff
                      ..writeln(map(fromCase))
                      ..writelnTab('default:', switchTab)
                      ..writelnTab(
                        r"throw Exception('Unknown field: $json');",
                        switchTab + 1,
                      );
                  },
                );
              },
            )
            ..writeln()
            ..writelnTab('@override', classTab)
            ..writeln(
              'String toJson($enumName object) => object.serialized;',
            );
        },
      );

    return buffer;
  }

  @override
  _Item convert(EnumField e) => _Item(enumName, e);
}

class _Item extends FieldTemplate<EnumField> {
  const _Item(String enumName, EnumField field) : super(enumName, field);

  String get privateField => '_${field}Name';
  String get privateFieldGetter =>
      "static const $privateField = '${field.getSerializedName}';";

  String get arg => 'required T $field,';
  String caseString(String str) => 'case $str:';

  String get toReturnString => '$field: $privateField,';

  String get fromReturnString => 'return ${field.wholeName};';
  String fromCaseItem(String caseTab, String returnTab) => '''
$caseTab${caseString(privateField)}
$returnTab$fromReturnString''';
}
