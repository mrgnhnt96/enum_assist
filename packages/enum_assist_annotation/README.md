  Annotations for the [enum_assist] code-generator.\
  Without [enum_assist], this package does nothing.

# Index

- [Index](#index)
- [Enum Assist](#enum-assist)
  - [Creation Settings](#creation-settings)
  - [Serialized Format](#serialized-format)
  - [Use Doc Comment As Description](#use-doc-comment-as-description)
  - [Use Int Value For Serialization](#use-int-value-for-serialization)
- [Enum Value](#enum-value)
  - [Readable](#readable)
  - [Description](#description)
  - [Int Value](#int-value)
  - [Serialized Value](#serialized-value)
  - [Use Doc Comment As Description](#use-doc-comment-as-description-1)
  - [Extensions](#extensions)

# Enum Assist

Generation settings for the enum

## Creation Settings

Determine which default methods to generate

- createJsonConv
- createName
- createDescription
- createToInt
- createReadable
- createSerialized

## Serialized Format

Formats the enum's serialized values.

[change_case] is used to format the serialized value.\
  The possible values are from [SerializedFormat]

  ```dart
  // SerializedFormat.none (default)
  static const _professionalName = 'professional';

  // SerializedFormat.snake
  static const _veryProfessionalName = 'very_professional';
  ```

## Use Doc Comment As Description

Use the enum value's doc comment as the description.

Returns `null` when `false`, unless defined via [EnumValue.description](#description).

```dart
@EnumAssist(useDocCommentAsDescription: true)
enum Greeting {
  /// A professional greeting
  professional,
  /// A friendly greeting
  friendly,
  /// A relaxed greeting
  ///
  /// Which is my favorite!
  relaxed,
}

// "A relaxed greeting
//
// Which is my favorite!"
Greeting.relaxed.description;
```

## Use Int Value For Serialization

Use the enum's int value for serialization.

The [`serializedValue`](#serializedValue) arg will be ignored when `true`.

```dart
@EnumAssist(useIntValueForSerialization: true)
enum Greeting {
  professional,
  friendly,
  relaxed,
}

Greeting.relaxed.serialized; // 2
```

> __Notice This:__
Instead of returning `friendly`, it will return the `intValue` of the `friendly` field, which is `1`

# Enum Value

Customize the generator for a specific enum value.

## Readable

The name in a human readable format.

```dart
@EnumAssist()
enum Greeting {
  @EnumValue(readable: 'Formal')
  professional,
  friendly,
  relaxed,
}

Greeting.professional.readable; // Formal
Greeting.friendly.readable; // Friendly
```

## Description

The description of the enum value.

Expected Return Value:
- Doc Comment
- Value of [EnumValue.description](#description)
- `null` when the [EnumValue](#use-doc-comment-as-description), [EnumAssist, or build.yaml](#use-doc-comment-as-description) `useDocCommentAsDescription` fields are set to `false`

```dart
@EnumAssist()
enum Greeting {
  /// A professional greeting
  @EnumValue(description: 'Recommended to use in the work place')
  professional,
  /// A friendly greeting
  friendly,
  relaxed,
}

Greeting.friendly.description; // A friendly greeting
Greeting.professional.description; // Recommended to use in the work place
```

## Int Value

Provides the int value for `toInt` of the enum value.

0 indexed integers used to represent the enum value.\
When a value is assigned to EnumValue.intValue, the value will be passed on to the next enum field, incrementing by 1.

```dart
@EnumAssist()
enum ResponseCodes {
  @EnumValue(intValue: 200)
  ok,
  created,
  accepted,

  @EnumValue(intValue: 400)
  badRequest,
  unauthorized,

  @EnumValue(intValue: 403)
  forbidden,
  notFound,

  @EnumValue(intValue: 500)
  internalServerError,
  notImplemented,
  badGateway,
  serviceUnavailable,
}

ResponseCode.ok.toInt; // 200
ResponseCode.created.toInt; // 201
ResponseCode.accepted.toInt; // 202

ResponseCode.badRequest.toInt; // 400
ResponseCode.unauthorized.toInt; // 401

ResponseCode.forbidden.toInt; // 403
ResponseCode.notFound.toInt; // 404

ResponseCode.internalServerError.toInt; // 500
ResponseCode.notImplemented.toInt; // 501
ResponseCode.badGateway.toInt; // 502
ResponseCode.serviceUnavailable.toInt; // 503
```

## Serialized Value

Provides the serialized representation of the enum value for serialized and json converter classes.

> __Important!__:
While the type for `serializedValue` is `Object?`, the only accepted types are `String`, and `int`.

```dart
@EnumAssist()
enum Greeting {
  @EnumValue(serializedValue: 'formal')
  professional,
  friendly,
  @EnumValue(serializedValue: 3)
  relaxed,
}

Greeting.professional.serialized; // formal
Greeting.friendly.serialized; // friendly
Gretting.relaxed.serialized; // 3
```

## Use Doc Comment As Description

Use the enum value's doc comment as the description.

returns `null` when `false`, unless defined via [EnumValue.description](#description).

```dart
@EnumAssist()
enum Greeting {
  /// A professional greeting
  @EnumValue(useDocCommentAsDescription: false)
  professional,
  /// A friendly greeting
  friendly,
  relaxed,
}

Greeting.friendly.description; // A friendly greeting
Greeting.professional.description; // null
```

## Extensions

Custom Extension Methods to be created for the enum, specified with the value of the enum field.

Extension classes must extend
- `MapExtension`, representing the `.map(...)` method
- `MaybeExtension`, representing the `.maybeMap(...)` method

[change_case]: https://pub.dev/packages/change_case
[SerializedFormat]: https://github.com/mrgnhnt96/enum_assist/blob/main/packages/enum_assist_annotation/lib/src/util/enums.dart
[enum_assist]: https://pub.dartlang.org/packages/enum_assist
