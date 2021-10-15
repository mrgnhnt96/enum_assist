import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'serialized_format.ge.dart';

@EnumAssist(
  serializedFormat: SerializedFormat.camel,
)
enum Camel {
  formatEnum,
}

@EnumAssist(
  serializedFormat: SerializedFormat.capital,
)
enum Capital {
  formatEnum,
}

@EnumAssist(
  serializedFormat: SerializedFormat.constant,
)
enum Constant {
  formatEnum,
}

@EnumAssist(
  serializedFormat: SerializedFormat.dot,
)
enum Dot {
  formatEnum,
}

@EnumAssist(
  serializedFormat: SerializedFormat.header,
)
enum Header {
  formatEnum,
}

@EnumAssist(
  serializedFormat: SerializedFormat.kebab,
)
enum Kebab {
  formatEnum,
}

@EnumAssist(
  serializedFormat: SerializedFormat.no,
)
enum No {
  formatEnum,
}

@EnumAssist(
  serializedFormat: SerializedFormat.none,
)
enum None {
  formatEnum,
}

@EnumAssist(
  serializedFormat: SerializedFormat.pascal,
)
enum Pascal {
  formatEnum,
}

@EnumAssist(
  serializedFormat: SerializedFormat.path,
)
enum Path {
  formatEnum,
}

@EnumAssist(
  serializedFormat: SerializedFormat.sentence,
)
enum Sentence {
  formatEnum,
}

@EnumAssist(
  serializedFormat: SerializedFormat.snake,
)
enum Snake {
  formatEnum,
}

@EnumAssist(
  serializedFormat: SerializedFormat.swap,
)
enum Swap {
  formatEnum,
}
