/// {@template enum_assist.item_core}
/// helper class to structure enum values
/// {@endtemplate}
abstract class ItemCore {
  /// {@macro enum_assist.item_core}
  const ItemCore(this.enumName, this.field);

  /// the name of the enum
  final String enumName;

  /// the name of the field
  final String field;

  /// return `Enum.field`
  String get wholeEnum => '$enumName.$field';

  /// returns the argument string
  String get arg;
}
