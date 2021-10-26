<p align="center">
<h1 align="center">Enum Assist</h1>
<h3 align="center">Seamlessly generate extension methods and json conversion classes for your enums!</h3>
</p>

<p align="center">
<a href="https://pub.dev/packages/enum_assist"><img src="https://img.shields.io/pub/v/enum_assist.svg" alt="Pub"></a>
<a href="https://github.com/mrgnhnt96/enum_assist"><img src="https://img.shields.io/github/stars/mrgnhnt96/enum_assist.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Star on Github"></a>
<a href="https://pub.dev/packages/very_good_analysis"><img src="https://img.shields.io/badge/style-very_good_analysis-B22C89.svg" alt="Very Good Analysis"></a>
<a href="https://github.com/tenhobi/effective_dart"><img src="https://img.shields.io/badge/style-effective_dart-40c4ff.svg" alt="style: effective dart"></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"></a>
</p>

# Motivation

Using enums can be a bit tedious to work with. Like serializing them to/from json, using
switch statements based off their values, or using `describeEnum` or `split('.')` to get the value's name.

Writing extensions has been a great way to add extra functionality. Though, you'll find yourself
writing the same extensions over and over again. I was getting tired of copying and pasting code and changing a couple of things whenever I created a new enum. So I did what any other sane developer would do, I took a couple of weeks to create an automation tool to save me time. 🤪

__So welcome [enum_assist] into your ~~life~~project!__ The fastest way to writing extension methods
and json conversion classes for your enums!

Check out [the example] or [the index](#index) to see what it can do.

# Index

- [Motivation](#motivation)
- [Index](#index)
- [How to use](#how-to-use)
  - [Install](#install)
  - [Generating the Code](#generating-the-code)
  - [Build Runner Commands](#build-runner-commands)
  - [File Setup](#file-setup)
- [Features](#features)
  - [Default Extension Methods](#default-extension-methods)
    - [Name](#name)
    - [Description](#description)
    - [Readable Name](#readable-name)
    - [Serialized](#serialized)
  - [map/maybeMap](#mapmaybemap)
    - [Map](#map)
    - [Maybe Map](#maybe-map)
    - [Return Type](#return-type)
  - [Custom Extensions](#custom-extensions)
    - [Map Extension](#map-extension)
    - [Maybe Extension](#maybe-extension)
  - [Json Converter Classes](#json-converter-classes)
- [Annotations](#annotations)
  - [EnumAssist](#enumassist)
    - [Create Json Conversion](#create-json-conversion)
    - [Serialized Format](#serialized-format)
    - [Use Doc Comment As Description](#use-doc-comment-as-description)
  - [EnumAssist - build.yaml](#enumassist---buildyaml)
  - [EnumKey](#enumkey)
    - [Readable Name](#readable-name-1)
    - [Description](#description-1)
    - [Serialized Value](#serialized-value)
    - [Use Doc Comment As Description](#use-doc-comment-as-description-1)
    - [Extensions](#extensions)
- [Examples](#examples)
  - [Map Example](#map-example)
  - [MaybeMap Example](#maybemap-example)

# How to use

## Install

To use [enum_assist], you will need to set up the [build_runner] (code-generator) for your project.
First, add the following packages to your `pubspec.yaml`:

```yaml
depenedencies:
    enum_assist_annotation:

dev_dependencies:
    build_runner:
    enum_assist:
```

What are these packages?
- [enum_assist_annotation], contains all the annotations that [enum_assist] references to generate code.
  - __Why a Dependency__: The annotations are a part of your code, so [enum_assist_annotation]
    must be part of the `dependencies`
- [enum_assist], the code generator for all the annotations
  - __Why a Dev Dependency?__: The generator only generates the code. So its technically not part of your code which means that [enum_assist] can be part of the `dev_dependencies`
- [build_runner], a tool that any code-generator package uses to generate code
  - __Why a Dev Dependency?__: Same reason as [enum_assist]

## Generating the Code

## Build Runner Commands

- If your package depends on Flutter:

  ```dart
  flutter pub run build_runner build
  ```

- If your package _does not_ depend on Flutter:

  ```dart
  dart pub run build_runner build
  ```

<sub>_If you're new to [build_runner], I suggest taking a look at these [commands & options]_</sub>

## File Setup

Each file will need to start with the [enum_assist] import and the `part` keyword.

```dart
import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'example.ge.dart';
```

Here's a full example of `example.dart`:

```dart
import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'example.ge.dart';

@EnumAssist()
enum SuperHero {
  superman,
  spiderman,
  ironman,
}
```

# Features

## Default Extension Methods

The following methods will be generated with every enum annotated with [`EnumAssist`]

### Name

Returns the [EnumKey.name] of the enum value.

```dart
var greet = Greeting.friendly;

greet.name; // friendly
```

### Description

Returns the [EnumKey.description](#description-1) of the enum value in a human readable format.

```dart
var greet = Greeting.friendly;

greet.description; // A friendly greeting
```

### Readable Name

Returns the [EnumKey.readableName](#readable-name-1) of the enum value in a human readable format.

```dart
var greet = Greeting.friendly;

greet.readable; // Friendly
```

### Serialized

Specific case formatting can be done with [serializedFormat](#serialized-format) (either [`EnumAssist`] or [`build.yaml`])

Returns the [EnumKey.serializedValue](#serialized-value) of the enum value.

```dart
var greet = Greeting.friendly;

greet.serialized; // friendly
```

## map/maybeMap

Each enum will generate a `.map(...)` & `.maybeMap(...)` method, which is equivalent to pattern matching.

__The base of all [custom extension methods](#custom-extensions).__

This enum will be used as reference:

```dart
@EnumAssist()
enum Greeting {
  professional,
  friendly,
  relaxed,
}
```

### Map

`.map()` provides callbacks for each enum value. __All callbacks are required args__ and can return any value.

  ```dart
  var greet = Greeting.friendly;

  final whatDoYouSay = greet.map(
      professional: 'Hello Sir',
      friendly: 'Hello',
      relaxed: 'Saaa dude!',
  );

  whatDoYouSay; // Hello
  ```

### Maybe Map

`.maybeMap()` provides callbacks for each enum value, plus an `orElse` callback.\
`orElse` is the only required arg.

```dart
var greet = Greeting.friendly;

final whatDoYouSay = greet.maybeMap(
    orElse: '*blank stare*',
    professional: 'Hello Sir',
);

whatDoYouSay; // *blank stare*
```

### Return Type

`.map<T>()` and `.maybeMap<T>()` use generics to provide the return type of the callback.

While its not necessary to define the return type, it is recommended to do so.\
Defining the return type protects you by forcing a specific return type.

- Defined Return Type: `String`

  ```dart
  var greet = Greeting.friendly;

  final whatDoYouSay = greet.map<String>(
      professional: 'Hello Sir',
      friendly: 'Hello',
      // relaxed: 123, // compile error: `123` is not a type String
      relaxed: 'Saaa dude!',
  );

  whatDoYouSay.runtimeType; // String
  ```

Here are a couple of examples of inferred return types:

- Return type: `String`

  ```dart
  var greet = Greeting.friendly;

  final whatDoYouSay = greet.map(
      professional: 'Hello Sir',
      friendly: 'Hello',
      relaxed: 'Saaa dude!',
  );

  whatDoYouSay.runtimeType; // String
  ```

- Return type: `String?`

  ```dart
  var greet = Greeting.friendly;

  final whatDoYouSay = greet.map(
      professional: 'Hello Sir',
      friendly: null,
      relaxed: 'Saaa dude!',
  );

  whatDoYouSay.runtimeType; // String?
  ```

- Return type: `Object?`

  ```dart
  var greet = Greeting.friendly;

  final whatDoYouSay = greet.map(
      professional: 'Hello Sir',
      friendly: null,
      relaxed: 3,
  );

  whatDoYouSay.runtimeType; // Object?
  ```

  > <sub>_Note: Just because you can, doesn't mean you should..._\
  _With great power, comes great responsibility_</sub>

## Custom Extensions

[enum_assist] allows you to create your own extension methods for your enum, with minimal code!

There are two ways to create your own extension methods.\
You start by creating a class that extends [MapExtension](#map-extension) or [MaybeExtension](#maybe-extension).

___IMPORTANT__: All properties (other than `value`) need to be defined
within the super constructor!_

---

### Map Extension

There are 4 arguments:
- `value` (__required__), The value for the enum field.
  - Can be any `const` value
  - Type is inferred from the class's `type` arguments
- `methodName` (__required__), The name of the method to be created
  - This must be unique and should not be use by any other extension classes
- `docComment` (optional), The doc comment for the method
  - multi-line strings are supported.
  - `///` will be prepended to each new line.
- `allowNulls` (optional), Whether or not to return `null` values
  - _default_: `false`
  - _For the return type to be nullable, this must be set to `true`_

An example:

```dart
class MyExt extends MapExtension<String> {
  const MyExt(String value)
    : super(
        value,
        methodName: 'myExt',
        docComment: 'This is my extension',
        allowNulls: false, // default
      );
}
```

Generated code:

```dart
/// This is my extension
String get myExt {
  return map(...);
}
```

---

### Maybe Extension

There are 5 arguments, 4 are the same as [MapExtension](#map-extension)

The 5th argument is:
- `defaultValue` (required), the `orElse` callback value.
  - Can be any `const` value
  - Type is inferred from the class's type arguments

Expected return values:
- `defaultValue`:
  - If the extension value is not defined
  - If the extension value is `null` __AND__ `allowNulls` is `false`
- `null`
  - If the extension value is `null` __AND__ `allowNulls` is `true`
- Defined value
  - If the extension value is defined

```dart
class MyExt extends MaybeExtension<String?> {
  const MyExt(String? value)
    : super(
        value,
        methodName: 'myExt',
        docComment: 'This is my extension',
        defaultValue: 'default',
        allowNulls: true,
      );
}
```

Generated Code:

```dart
/// This is my extension
String get myExt {
  return maybeMap(
    orElse: MyExt(...).defaultValue,
    ...
  );
}
```

> __Notice This__:\
For the generated code to access the `defaultValue`, it must create an instance of the
extension class. If there is a required argument, the arg must be passed to avoid
exceptions. Therefore, the required arg will be ___provided___ & ___ignored___ to return default value.

## Json Converter Classes

A class to help with the serialization of your enum.\
The class will be named `${enumName}Conv`

[enum_assist_annotation] depends on [json_annotation] to generate [`JsonConverter`] classes.\
  _Even if you do not use [json_serializable] or [json_annotation] in your project, you can still use the generated conversion classes in your code._

For example, with:

```dart
@EnumAssist()
enum Greeting {
  professional,
  friendly,
  relaxed,
}
```

__Using [json_serializable]__, You can annotate a model class, like so:

```dart
@JsonSerializable()
class Person {
  const Person({
    required this.greeting,
  });

  @GreetingConv()
  final Greeting greeting;
}
```

- if the field is nullable, change the annotation to:

  ```dart
  @GreetingConv.nullable
  final Greeting? greeting;
  ```

__Or__ You can convert to and from json manually, like so:

```dart
Person.fromJson(Map<String, dynamic> json) {
  final conv = GreetingConv();

  return Person(
    greeting: conv.fromJson(json['greeting'])
  );
}

static Map<String, dynamic> fromJson(Person object) {
  final conv = GreetingConv();

  // using the conv class to convert
  return conv.toJson(object.greeting);

  // or using the [serialized] method
  return object.greeting.serialized;
}
```

# Annotations

## EnumAssist

Used to specify the enum you want to generate code for

### Create Json Conversion

_field_: `createJsonConv`

Whether or not to create a [json converter class](#json-converter-classes) (non-nullable & nullable) for your enum.

[enum_assist_annotation] depends on [json_annotation] to generate [`JsonConverter`] classes.\
  _Even if you do not use [json_serializable] or [json_annotation] in your project, you can still use the generated conversion classes in your code._

### Serialized Format

_field_: `serializedFormat`

Used By:
- [serialized](#serialized)

Sets the format you want the values of the enum to be serialized to.

[enum_assist] depends on [change_case] to format the serialized value.\
  The possible values for the [`build.yaml`] file is any value from the [SerializedFormat] enum

### Use Doc Comment As Description

_field_: `useDocCommentAsDescription`

Used By:
- [description](#description-1)

Whether or not to use the enum value's doc comment as the [description](#description-1) of the enum value.

If set to `false`, the [description](#description-1) will return `null`, unless defined via [EnumKey.description](#description).

## EnumAssist - build.yaml

If you want to customize the [settings](#enumassist) for each enum, you can specify it inside your `build.yaml` file.

For example:

```yaml
targets:
  $default:
    builders:
      enum_assist:
        enabled: true
        options:
          # - camel
          # - capital
          # - constant
          # - dot
          # - header
          # - kebab
          # - no
          # - none
          # - pascal
          # - path
          # - sentence
          # - snake
          # - swap
          # default: none
          serialized_format: none

          # possible values:
          # - true
          # - false
          # default: true
          use_doc_comment_as_description: true

          # possible values:
          # - true
          # - false
          # default: true
          create_json_conv: true
```

## EnumKey

The [`EnumKey`] annotation is used to customize the generator for a specific enum value.

### Readable Name

_field_: `readableName`

Used By:
- [readableName](#readable-name)

Provides the name for [readableName](#readable-name) of the enum value.
The name should be a human readable format.\
For Example: `Example.isReallyCool` could be formatted as `Is Really Cool`

### Description

_field_: `description`

Used By:
- [description](#description)

Provides the description for the [description](#description) of the enum value.

The description should be a human readable format.\
For Example: for `Example.isReallyCool`, the description could be `The example is really cool!`

Expected Return Value:
- Doc Comment of the enum value
- `null` if the [EnumKey](#use-doc-comment-as-description), [EnumAssist, or build.yaml](#use-doc-comment-as-description) `useDocCommentAsDescription` fields are set to false
- Value of [EnumKey.description](#description) (regardless of `useDocCommentAsDescription`'s value)

### Serialized Value

_field_: `serializedValue`

Used By:
- [serialized](#serialized)
- [json converter classes](#json-converter-classes)

Provides the serialized representation of the enum value.

Specific case formatting can be done with [serializedFormat](#serialized-format) (either [`EnumAssist`] or [`build.yaml`])

### Use Doc Comment As Description

_field_: `useDocCommentAsDescription`

Used By:
- [description](#description-1)

Whether or not to use the enum value's doc comment as the [description](#description-1) of the enum value.

If set to `false`, the [description](#description-1) will return `null`, unless defined via [EnumKey.description](#description).

### Extensions

_field_: `extensions`

Used By:
- [Custom Extension Methods](#custom-extensions)

[Custom Extension Methods](#custom-extensions) to be created for the enum, specified with the value of the enum field.

Extension classes must extend
- [`MapExtension`], representing the [`.map(...)`](#mapmaybemap) method
- [`MaybeExtension`], representing the [`.maybeMap(...)`](#mapmaybemap) method

# Examples

## Map Example

Lets create a `.response` method for the enum `Greeting` enum.\
This method will return a `String` with the response to the greeting.

We first need to create our extension class.

```dart
class ResponseExt extends MapExtension<String> {
  const ResponseExt(String value)
    : super(
        value,
        methodName: 'response',
        docComment: 'The response to a greeting',
      );
}
```

> __Note__:\
The [`MapExtension`] class also has an `allowNulls` argument, which defaults to `false`.\
  This can be set to `true` to change the return type nullable.

Next, we need to add our extension to the enum.\
This can be done by annotating the enum's values with [EnumKey](#enumkey),
And then adding the extension to the [`extensions`](#extensions) field.

> __Note__:\
Because the [`.map(...)`](#map) requires all args to be defined, we must add the `ResponseExt` extension to ___ALL enum fields___.\
_Failure to do so will result in an error when generating the code._

```dart
@EnumAssist()
enum Greeting {
  @EnumKey(
    extensions: [
      ResponseExt('Hello, how do you do?'),
    ],
  )
  professional,

  @EnumKey(
    extensions: [
      ResponseExt('Hey! Hows it going?'),
    ],
  )
  friendly,

  @EnumKey(
    extensions: [
      ResponseExt('Whats up my dude!?'),
    ],
  )
  relaxed,
}
```

After the [build_runner](#build-runner-commands) has run, you can now access the `.response` method on the `Greeting` enum.

```dart
var greet = Greeting.friendly;

greet.response; // Hey! Hows it going?

Greeting.relaxed.response; // Whats up my dude!?
```

## MaybeMap Example

Lets create a `.isCool` method for the `Greeting` enum.\
This method will return `true` only if the enum value is `friendly` or `relaxed`. Or else it will return `false`.

We first need to create our extension class.

```dart
class IsCoolExt extends MaybeExtension<bool> {
  const IsCoolExt(bool value)
    : super(
        value,
        methodName: 'isCool',
        defaultValue: false,
        docComment: 'Is this a cool greeting?',
      );
}
```

> __Note__:\
The [`MaybeExtension`] class also has an `allowNulls` argument, which defaults to `false`.\
  This can be set to `true` if you want the return type to be nullable.

> __Note__:\
> The constructor could take a named argument with a default value to reduce the amount of code needed.
>
> ```dart
> const IsCoolExt([bool value = true])
> ```

Next, we need to add our extension to the enum.\
This can be done by adding the [`EnumKey`] annotation to ___any enum field___.
And then adding the extension to the `extensions` list.

```dart
@EnumAssist()
enum Greeting {
  professional,

  @EnumKey(
    extensions: [
      IsCoolExt(true),
    ],
  )
  friendly,

  @EnumKey(
    extensions: [
      IsCoolExt(true),
    ],
  )
  relaxed,
}
```

> __Notice This__:\
We did not annotate `professional` with [`EnumKey`] or `IsCoolExt`.\
  This is because [`.maybeMap(...)`](#maybe-map) doesn't require all callbacks to be defined.
>
> The generator will use the `defaultValue` from `IsCoolExt` as the return value.

After the [build_runner](#build-runner-commands) has run, you can now access the `.isCool` method on the `Greeting` enum.

```dart
var greet = Greeting.friendly;
greet.isCool; // true

Greeting.professional.isCool; // false
```

[`EnumAssist`]: https://github.com/mrgnhnt96/enum_assist/blob/main/packages/enum_assist_annotation/lib/src/enum_assist.dart
[`EnumKey`]: https://github.com/mrgnhnt96/enum_assist/blob/main/packages/enum_assist_annotation/lib/src/enum_key.dart
[commands & options]: https://pub.dev/packages/build_runner#built-in-commands
[the example]: https://github.com/mrgnhnt96/enum_assist/tree/main/packages/enum_assist/example
[build_runner]: https://pub.dev/packages/build_runner
[enum_assist]: https://pub.dev/packages/enum_assist
[enum_assist_annotation]: https://pub.dev/packages/enum_assist_annotation
[enum_assist_repo]: https://github.com/mrgnhnt96/enum_assist
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[json_serializable]: https://pub.dev/packages/json_serializable
[json_annotation]: https://pub.dev/packages/json_annotation
[change_case]: https://pub.dev/packages/change_case
[SerializedFormat]: https://github.com/mrgnhnt96/enum_assist/blob/main/packages/enum_assist_annotation/lib/src/util/enums.dart
[Capital Case]: https://github.com/mrgnhnt96/change_case#tocapitalcase
[`MapExtension`]: https://github.com/mrgnhnt96/enum_assist/blob/main/packages/enum_assist_annotation/lib/src/map_extension.dart
[`MaybeExtension`]: https://github.com/mrgnhnt96/enum_assist/blob/main/packages/enum_assist_annotation/lib/src/maybe_extension.dart
[`JsonConverter`]: https://github.com/google/json_serializable.dart/blob/master/json_annotation/lib/src/json_converter.dart
[`build.yaml`]: #enumassist---buildyaml
