# Enum Assist

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

> Seamlessly generate extension methods and json conversion classes for your enums using [enum_assist]

---

## Motivation

Enums are great for representing a finite set of values... And thats about it!

Using enum values can be a bit tedious to work with. Serializing them to json, using
switch statements, and having to use `describeEnum` or `split('.')` everytime you want the enum value.

Writing extensions has been a great way to add functionality to enums. Even though you find yourself
writing the same extensions over and over again. I was getting tired of copying and pasting code and then changing a few variables whenever I created a new enum every so often. So I did what any other sane developer would do, I took a couple of weeks to create an automation tool to save me time. 🤪

__So now welcome [enum_assist] into your ~~life~~project!__ The fastest way to writing extension methods
and json conversion classes for your enums!

Check out [the example] or [the index](index) to see what it can do.

## Index

- [Enum Assist](#enum-assist)
  - [Motivation](#motivation)
  - [Index](#index)
  - [How to use](#how-to-use)
    - [Install](#install)
    - [Generating the Code](#generating-the-code)
      - [Build Runner Commands](#build-runner-commands)
      - [File Setup](#file-setup)
  - [`build.yaml`](#buildyaml)
  - [Annotations](#annotations)
    - [EnumAssist](#enumassist)
      - [Create Json Conv](#create-json-conv)
      - [Serialized Format](#serialized-format)
      - [Use Doc Comment As Description](#use-doc-comment-as-description)
    - [EnumKey](#enumkey)
      - [Name](#name)
      - [Description](#description)
      - [Serialized Value](#serialized-value)
      - [Use Doc Comment As Description](#use-doc-comment-as-description-1)
      - [Extensions](#extensions)
  - [Features](#features)
    - [map/maybeMap](#mapmaybemap)
      - [Inherited Type](#inherited-type)
      - [Usage Example](#usage-example)
    - [Default Extensions](#default-extensions)
      - [Name](#name-1)
      - [Description](#description-1)
      - [Serialized](#serialized)
    - [Custom Extensions](#custom-extensions)
      - [Map Extension](#map-extension)
      - [Maybe Extension](#maybe-extension)
      - [Map Example](#map-example)
      - [MaybeMap Example](#maybemap-example)
    - [Extension Classes](#extension-classes)
    - [Json Converter Classes](#json-converter-classes)

## How to use

### Install

To use [enum_assist], you will need to set up the [build_runner]/code-generator for your project.
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
  - __Why a Dependency__: The annotations are part of your code, [enum_assist_annotation]
    must be part of the `dependencies`
- [enum_assist], is the code generator for all the annotations
  - __Why a Dev Dependency?__: The generator only generates the code, so its technically not part of your code which means that [enum_assist] can be part of the `dev_dependencies`
- [build_runner], is a tool that any code-generator package uses to generate code
  - __Why a Dev Dependency?__: Same reason as [enum_assist]

### Generating the Code

#### Build Runner Commands

- If your package depends on Flutter:
  - `flutter pub run build_runner build`
- If your package _does not_ depend on Flutter:
  - `dart pub run build_runner build`

_If you're new to [build_runner], I suggest taking a look at these [commands & options]_

#### File Setup

Each file will need to start with the [enum_assist] import and the `part` keyword.

```dart
import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'example.ge.dart';
```

Heres a full example of a file `example.dart`:

```dart
import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'example.ge.dart';

@EnumAssist()
enum Numbers {
  eleven,
  twentyTwo,
  thirtyThree,
}
```

## `build.yaml`

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

## Annotations

### EnumAssist

To generate extensions for your enums, you will need to use the [`EnumAssist`] annotation.
These are the settings that you can use to customize the code generation.

#### Create Json Conv

_type_: `bool`

This tells the generator whether or not to create a [json converter class](#json-converter-classes) (non-nullable & nullable) for your enum.

[enum_assist_annotation] depends on [json_serializable] to generate the json conversion classes.\
_Even if you do not use [json_serializable] in your project, you can still use the generated conversion classes in your code._

The [json converter classes](#json-converter-classes) use the [serialized](#serialized) method to help with serialization.

_field:_ `createJsonConv`\
_default:_ `true`

#### Serialized Format

_type_:

- [enum_assist], `SerializedFormat`
- `build.yaml`, `String` (from any value of [SerializedFormat])

This tells the generator which format you want the values of the enum to be serialized to.

[enum_assist] depends on [change_case] to format the serialized value.\
The possible values for the `build.yaml` file is any value from the [SerializedFormat] enum

_field_: `serializedFormat`
_default_:
    - [`EnumAssist`]: `SerializedFormat.none`
    - `build.yaml`: `none`

#### Use Doc Comment As Description

_type_: `bool`

This tells the generator whether or not to use the enum value's doc comment as the [description](#description-1) of the enum value.

If set to false, the [description](#description-1) will return `null`, unless you define the definition on the [EnumKey.description](#description).

_field:_ `useDocCommentAsDescription`\
_default:_ `true`

### EnumKey

The [`EnumKey`] annotation is used to customize the generator for a specific enum value.

#### Name

_type_: [String]

Provides the name for the [name](#name-1) of the enum value.

The name should be a human readable format.\
For Example: `Example.isReallyCool` could be formatted as `Is Really Cool`

_default_: The name of the enum value, formatted to [Capital Case]

#### Description

_type_: [String?]

Provides the description for the [description](#description-1) of the enum value.

The description should be a human readable format.\
For Example: for `Example.isReallyCool`, the description could be `The example is really cool!`

_default_: The doc comment of the enum value

- `null`, if the [EnumKey](#use-doc-comment-as-description), or [EnumAssist/build.yaml](#use-doc-comment-as-description) `useDocCommentAsDescription` field are set to false

#### Serialized Value

_type_: `String`

__Note:__ if [createJsonConv](#create-json-conv) is set to false, this field will be ignored.

Provides the serialized representation of the enum value.

Used by the [serialized](#serialized) method & [json converter classes](#json-converter-classes)

_default_: The name of the enum value, no format changes

- Specific case formatting can be done with [serializedFormat](#serialized-format) (either [`EnumAssist`] or `build.yaml`)

#### Use Doc Comment As Description

_type_: `bool`

This tells the generator whether or not to use the enum value's doc comment as the [description](#description-1) of the enum value.

If set to false, the [description](#description-1) will return `null`, unless you define the definition on the [description](#description).

_default:_ `true`

#### Extensions

_type_: `List<Extension>`

[Custom Extension Methods](#custom-extensions) to be created for the enum, specified with the value of the enum field.

Extension classes must extend

- [`MapExtension`], representing the [`.map(...)`](#mapmaybemap) method
- [`MaybeExtension`], representing the [`.maybeMap(...)`](#mapmaybemap) method

## Features

### map/maybeMap

Each enum will generate a `.map(...)` & `.maybeMap(...)` method, which is equivalent to pattern matching.\
`map` requires all callbacks while `maybeMap` allows you to specify which to use, along with an `orElse` callback.\
Both methods _inherit_ the return type from the _callbacks_, making it very versatile.\

This enum will be used as example for [inherited type](#inherited-type) and the [usage example](#usage-example) below.

```dart
@EnumAssist()
enum Greeting {
  professional,
  friendly,
  relaxed,
}
```

#### Inherited Type

Return type: `String`

```dart
var greet = Greeting.friendly;

final whatDoYouSay = greet.map(
        professional: 'Hello Sir',
        friendly: 'Hello',
        relaxed: 'Saaa dude!',
    );

print(whatDoYouSay.runtimeType); // String
```

Return type: `String?`

```dart
var greet = Greeting.friendly;

final whatDoYouSay = greet.map(
        professional: 'Hello Sir',
        friendly: null,
        relaxed: 'Saaa dude!',
    );
print(whatDoYouSay.runtimeType); // String?
```

Return type: `Object?`

```dart
var greet = Greeting.friendly;

final whatDoYouSay = greet.map(
        professional: 'Hello Sir',
        friendly: null,
        relaxed: 3,
    );
print(whatDoYouSay.runtimeType); // Object?
```

_Note: Just because you can, doesn't mean you should..._\
_Note 2: With great power, comes great responsibility_

#### Usage Example

- map

    ```dart
    var greet = Greeting.friendly;

    final whatDoYouSay = greet.map(
            professional: 'Hello Sir',
            friendly: 'Hello',
            relaxed: 'Saaa dude!',
        );

    print(whatDoYouSay); // Hello
    ```

- maybeMap

    ```dart
    var greet = Greeting.friendly;

    final whatDoYouSay = greet.maybeMap(
            orElse: '*blank stare*',
            professional: 'Hello Sir',
        );

    print(whatDoYouSay); // *blank stare*
    ```

These two methods will be the base of all other extension methods.

### Default Extensions

The following methods will be generated with every enum annotated with [`EnumAssist`]

#### Name

Returns the [EnumKey.name](#name) of the enum value in a human readable format.

_default_: The name of the enum value, formatted to [Capital Case]

#### Description

Returns the [EnumKey.description](#description) of the enum value in a human readable format.

#### Serialized

Returns the [EnumKey.serializedValue](#serialized-value) of the enum value.

_default_: The name of the enum value, no format changes

- Specific case formatting can be done with [serializedFormat](#serialized-format) (either [`EnumAssist`] or `build.yaml`)

### Custom Extensions

[enum_assist] allows you to create your own extension methods for your enum, with minimal code!

There are two ways to create your own extension methods.\
You start by creating a class that extends [`MapExtension`] or [`MaybeExtension`].

___IMPORTANT__: All properties (other than `value`) need to be defined
within the super constructor!_

#### Map Extension

There are 4 arguments:

- `value` (required), The value for the enum field.
  - Can be any `const` value
  - Type is inherited from the class's type arguments
- `methodName` (required), The name of the method to be created
  - This must be unique and should not be shared across other classes that extend
    [`MapExtension`] or [`MaybeExtension`]
- `docComment` (optional), The doc comment for the method
  - multi-line strings are supported.
  - `///` will be prepended to each new line.
- `allowNulls` (optional), Whether or not to allow `null` values
  - To get a nullable return type, this must be set to `true`
  - _default_: `false`

For example:

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

#### Maybe Extension

There are 5 arguments, 4 are the same as [MapExtension](#map-extension)\
The last argument is:

- `defaultValue` (required), The default value to return if the enum value doesn't
  have the extension method defined
  - Can be any `const` value
  - Type is inherited from the class's type arguments

```dart
class MyExt extends MaybeExtension<String> {
  const MyExt(String value)
      : super(
          value,
          methodName: 'myExt',
          docComment: 'This is my extension',
          defaultValue: 'default',
          allowNulls: false, // default
        );
}
```

#### Map Example

Lets say you want to create a `.response` method for the enum `Greeting` enum.\
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

- __Note__: The [`MapExtension`] class also has an `allowNulls` argument, which defaults to `false`.\
  This can be set to `true` if you want the return type to be nullable.

Next, we need to add our extension to the enum.\
This can be done by adding the [`EnumKey`] annotation to ___ALL enum fields___.
And then adding the extension to the `extensions` list.

- __Note__: Because the extension method is `.map`, we must add the `ResponseExt` class to the `extensions` list
  of each enum field.
  - Failure to do so will result in an error when generating the code.

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
print(greet.response); // Hey! Hows it going?

print(Greeting.relaxed.response); // Whats up my dude!?
```

#### MaybeMap Example

Lets say you want to create a `.isCool` method for the `Greeting` enum.\
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

- __Note__: The [`MaybeExtension`] class also has an `allowNulls` argument, which defaults to `false`.\
  This can be set to `true` if you want the return type to be nullable.
- __Note 2__: The constructor could take a named argument with a default value to reduce the amount of code needed.

    ```dart
    const IsCoolExt([bool value = true])
    ```

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

- __Note__: Notice that we did not annotate `professional` with [`EnumKey`] or `IsCoolExt`.\
  The generator will use the `defaultValue` from `IsCoolExt` as the return value.
  - This applies to [`MaybeExtension`]s only, as [`MapExtension`]s do not have a default value.

After the [build_runner](#build-runner-commands) has run, you can now access the `.isCool` method on the `Greeting` enum.

```dart
var greet = Greeting.friendly;
print(greet.isCool); // true

print(Greeting.professional.isCool); // false
```

### Extension Classes

### Json Converter Classes

A class to help with the serialization of your enum.\
The class will be named `${enumName}Conv`

[enum_assist_annotation] depends on [json_serializable] to generate the json conversion classes.\
_Even if you do not use [json_serializable] in your project, you can still use the generated conversion classes in your code._

For example, with:

```dart
@EnumAssist()
enum Greeting {
  professional,
  friendly,
  relaxed,
}
```

- __Using [json_serializable]__, You can annotate a model class, like so:

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

  - if the field were nullable, you would need to annotate it with:

    ```dart
    @GreetingConv.nullable
    final Greeting? greeting;
    ```

- __By Hand__, you can convert to and from json, like so:

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
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[json_serializable]: https://pub.dev/packages/json_serializable
[change_case]: https://pub.dev/packages/change_case
[SerializedFormat]: https://github.com/mrgnhnt96/enum_assist/blob/main/packages/enum_assist_annotation/lib/src/util/enums.dart
[Capital Case]: https://github.com/mrgnhnt96/change_case#tocapitalcase
[`MapExtension`]: https://github.com/mrgnhnt96/enum_assist/blob/main/packages/enum_assist_annotation/lib/src/extension.dart
[`MaybeExtension`]: https://github.com/mrgnhnt96/enum_assist/blob/main/packages/enum_assist_annotation/lib/src/extension.dart
