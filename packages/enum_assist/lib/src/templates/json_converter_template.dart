import 'package:enum_assist/src/field_data.dart';
import 'package:enum_assist/src/templates/template_core.dart';
import 'package:enum_assist/src/util/string_helpers.dart';
import 'package:enum_assist/src/util/util.dart';

/// {@template enum_assist.map_template}
/// Returns the map extension template
/// {@endtemplate}
class JsonConverterTemplate extends TemplateCoreDetailed<_Item> {
  /// {@macro enum_assist.map_template}
  JsonConverterTemplate(
    String enumName,
    Iterable<FieldData> fields, {
    required this.isNullable,
    required this.useIntValueForSerialization,
  }) : super(enumName, fields);

  /// sets the template to return a nullable value
  final bool isNullable;

  /// sets the template to return the int value for serialized
  final bool useIntValueForSerialization;

  String get _possNullType => isNullable ? '?' : '';
  String get _possNullName => isNullable ? 'Nullable' : '';
  String get _className =>
      '${isNullable ? '_' : ''}$enumName${_possNullName}Conv';
  String get _enumType => '$enumName$_possNullType';
  String get _type => 'Object$_possNullType';

  String get _templateName =>
      isNullable ? _templateNameNullable : _templateNameNonNullable;
  String get _templateNameNullable => '${_templateNameNonNullable}_nullable';
  String get _templateNameNonNullable =>
      '${enumName.toSnakeCase()}.json_converter';
  String get _annotation =>
      isNullable ? '@${enumName}Conv.nullable' : '@$_className()';

  @override
  StringBuffer writeTemplate(StringBuffer buffer) {
    buffer
      ..writeln('''
/// {@template $_templateName}
/// Serializes [$_enumType] to and from json
///
/// Can be used as annotation for `json_serializable` classes
///
/// ```dart
/// $_annotation
/// final $_enumType myEnum;
/// ```
/// {@endtemplate}''')
      ..writeobj(
        'class $_className extends JsonConverter<$_enumType, $_type>', // ignore:
        body: (classBuff, classTab) {
          classBuff.writelnTab(
              '/// {@macro ${enumName.toSnakeCase()}.json_converter}',
              classTab);

          if (!isNullable) {
            classBuff
              ..writelnTab('const $_className({this.defaultValue});', classTab)
              ..writeln()
              ..writelnTab(
                  '/// the value to be used when no match is found', classTab)
              ..writelnTab('final $enumName? defaultValue;', classTab)
              ..writeln()
              ..writelnTab('/// {@macro $_templateNameNullable}', classTab)
              ..writelnTab(
                  'static const nullable = _${enumName}NullableConv();')
              ..writeln()
              ..writeln(map((i) => tab(i.privateFieldGetter, classTab)));
          } else {
            classBuff.writelnTab('const $_className();');
          }

          classBuff
            ..writeln()
            ..writelnTab('@override', classTab)
            ..writeobj(
              '$_enumType fromJson($_type json)',
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
                      ..writelnTab('default:', switchTab);

                    if (isNullable) {
                      switchBuff
                        ..writeln()
                        ..writelnTab('return null;', switchTab);
                    } else {
                      switchBuff
                        ..writelnTab(
                            'if (defaultValue != null) return defaultValue!;',
                            switchTab + 1)
                        ..writeln()
                        ..writelnTab(
                          r"throw Exception('Unknown field: $json');",
                          switchTab + 1,
                        );
                    }
                  },
                );
              },
            )
            ..writeln()
            ..writelnTab('@override', classTab)
            ..writeln(
              '$_type toJson($_enumType object) => '
              'object$_possNullType.serialized;',
            );
        },
      );

    return buffer;
  }

  @override
  _Item convert(FieldData e) => _Item(
        enumName,
        e,
        isNullable,
        useIntValueForSerialization,
      );
}

class _Item extends FieldTemplate<FieldData> {
  const _Item(
    String enumName,
    FieldData field,
    this.isNullable,
    this.useIntValueForSerialization,
  ) : super(enumName, field);

  final bool isNullable;
  final bool useIntValueForSerialization;

  String get privateField => field.privateName;
  String get serializedValue {
    if (useIntValueForSerialization) {
      return '${field.intValue}';
    }

    return field.getSerializedValue;
  }

  String get privateFieldGetter =>
      'static const $privateField = $serializedValue;';

  String get _className => isNullable ? '${enumName}Conv.' : '';

  String caseString(String str) => 'case $_className$str:';

  String get fromReturnString => 'return ${field.wholeName};';

  String fromCaseItem(String caseTab, String returnTab) => '''
$caseTab${caseString(privateField)}
$returnTab$fromReturnString''';
}
