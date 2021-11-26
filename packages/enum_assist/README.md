<p align="center">
<h1 align="center">Enum Assist</h1>
<h3 align="center">Seamlessly generate extension methods and json conversion classes for your enums!</h3>
</p>

<p align="center">
<a href="https://pub.dev/packages/enum_assist"><img src="https://img.shields.io/pub/v/enum_assist.svg" ></a>
<a href="https://github.com/mrgnhnt96/enum_assist"><img src="https://img.shields.io/github/stars/mrgnhnt96/enum_assist.svg?style=flat&logo=github&colorB=deeppink&label=stars" ></a>
<a href="https://pub.dev/packages/very_good_analysis"><img src="https://img.shields.io/badge/style-very_good_analysis-B22C89.svg" ></a>
<a href="https://github.com/tenhobi/effective_dart"><img src="https://img.shields.io/badge/style-effective_dart-40c4ff.svg" ></a>
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" ></a>
</p>

# Motivation

Dart enums can be a bit tedious to work with. Serializing them to/from json, using
switch statements based off their values, or using `describeEnum` or `split('.')` to get the value's name are a couple of examples where working with enums could be improved.

Writing extensions has been a great way to add extra functionality to classes & enums. Though, you'll find yourself writing the same extensions over and over again. I was getting tired of copying and pasting code and changing a couple of things whenever I created a new enum. So I did what any other sane developer would do, I took a couple of weeks to create an automation tool to save me time. 🤪

__So welcome [enum_assist] into your ~~life~~project!__ The fastest way to writing extension methods and json conversion classes for your enums!

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
  - [map/maybeMap](#mapmaybemap)
    - [Return Type](#return-type)
  - [Custom Extensions](#custom-extensions)
    - [Map Extension](#map-extension)
    - [Maybe Extension](#maybe-extension)
  - [Json Converter](#json-converter)
- [Build Configuration](#build-configuration)
- [Examples](#examples)
  - [Map Example](#map-example)
  - [MaybeMap Example](#maybemap-example)
  - [toJson & fromJson](#tojson--fromjson)
    - [Using json_serializable](#using-json_serializable)
    - [Manually Serializing](#manually-serializing)

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

  ```dart
  // If your package depends on Flutter
  flutter pub run build_runner build

  // If your package _does not_ depend on Flutter
  dart pub run build_runner build
  ```

<sub>_If you're new to [build_runner], I suggest taking a look at these [commands & options]_</sub>

## File Setup

Each file will need to start with the [enum_assist] import and the `part` keyword.

```dart
import 'package:enum_assist_annotation/enum_assist_annotation.dart';

part 'example.ge.dart';
```

# Features

## Default Extension Methods

The following methods will be generated with every enum annotated with [`EnumAssist`]

**Name**

The name of the enum value.

```dart
Greeting.friendly.name; // friendly
```

[**Description**](#description)

```dart
Greeting.friendly.description; // A friendly greeting
```

[**To Int**](#int-value)

```dart
Greeting.professional.toInt; // 0
Greeting.friendly.toInt; // 1
Greeting.relaxed.toInt; //2
```

[**Readable**](#readable)

```dart
Greeting.friendly.readable; // Friendly
```

[**Serialized**](#serialized-value)

> Specific case formatting can be done with [serializedFormat](#serialized-format) (either [`EnumAssist`] or [`build.yaml`])

```dart
Greeting.friendly.serialized; // friendly
```

## map/maybeMap

__The base of all [custom extension methods](#custom-extensions).__\
Each enum will generate a `.map(...)` & `.maybeMap(...)` method, which is equivalent to pattern matching.

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

`.maybeMap()` provides callbacks for each enum value, plus an `orElse` callback.\
`orElse` is the only required arg.

```dart
var greet = Greeting.friendly;

final whatDoYouSay = greet.maybeMap(
    professional: 'Hello Sir',
    orElse: '*blank stare*',
);

whatDoYouSay; // *blank stare*
```

### Return Type

`.map<T>()` and `.maybeMap<T>()` use generics to provide the return type of the callback.

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

While its not necessary to define the return type, it is recommended to do so.

  ```dart
  var greet = Greeting.friendly;

  final whatDoYouSay = greet.map(
      professional: 'Hello Sir',
      friendly: 'Hello',
      relaxed: 'Saaa dude!',
  );

  whatDoYouSay.runtimeType; // String
  ```

  ```dart
  var greet = Greeting.friendly;

  final whatDoYouSay = greet.map(
      professional: 'Hello Sir',
      friendly: null,
      relaxed: 'Saaa dude!',
  );

  whatDoYouSay.runtimeType; // String?
  ```

  ```dart
  var greet = Greeting.friendly;

  final whatDoYouSay = greet.map(
      professional: 'Hello Sir',
      friendly: null,
      relaxed: 3,
  );

  whatDoYouSay.runtimeType; // Object?
  ```

## Custom Extensions

[enum_assist] allows you to create your own extension methods for your enum

There are two ways to create your own extension methods.\
You start by creating a class that extends [MapExtension](#map-extension) or [MaybeExtension](#maybe-extension).

___IMPORTANT__: All properties (other than `value`) need to be defined
within the super constructor!_

---

### Map Extension

```dart
class SaidByExt extends MapExtension<String> {
  const SaidByExt(String value)
    : super(
        value,
        methodName: 'saidBy',
        docComment: 'Greeting that is said by...',
        allowNulls: false, // default
      );
}
```

Add it to the the [`extensions`](#extensions) property

```dart
@EnumAssist()
enum Greeting {
  @EnumValue(extensions: [SaidByExt('Executives')])
  professional,
  @EnumValue(extensions: [SaidByExt('Co-workers')])
  friendly,
  @EnumValue(extensions: [SaidByExt('Friends')])
  relaxed,
}
```

Generated code:

```dart
/// Greeting that is said by...
String get saidBy {
  return map<String>(
    professional: 'Executives',
    friendly: 'Co-workers',
    relaxed: 'Friends',
  );
}
```

---

### Maybe Extension

Expected return values:
- `defaultValue`:
  - When the extension value is not defined
  - When the extension value is `null` __AND__ `allowNulls` is `false`
- `null`
  - When the extension value is `null` __AND__ `allowNulls` is `true`

```dart
class HowFrequentExt extends MaybeExtension<int?> {
  const HowFrequentExt(int? value)
    : super(
        value,
        methodName: 'howFrequent',
        docComment: '1-10, How often this greeting is used.\n\n`null` if never used',
        defaultValue: 0,
        allowNulls: true,
      );
}
```

Add it to the the [`extensions`](#extensions) property

```dart
@EnumAssist()
enum Greeting {
  @EnumValue(extensions: [])
  professional,
  @EnumValue(extensions: [HowFrequentExt(3)])
  friendly,
  @EnumValue(extensions: [HowFrequentExt(8)])
  relaxed,
  @EnumValue(extensions: [HowFrequentExt(null)])
  rude,
}
```

Generated Code:

```dart
/// 1-10, How often this greeting is used
///
/// `null` if never used
int? get howFrequent {
  return maybeMap<int?>(
    // returns default value
    //? if theres an argument provided, it does nothing.
    orElse: HowFrequentExt(3).defaultValue,
    professional: HowFrequentExt(3).defaultValue,
    friendly: 3,
    relaxed: 8,
    rude: null,
  );
}
```

> __Notice This__:\
For the generated code to access the `defaultValue`, it must create an instance of the
extension class. If there is a required argument, the arg must be passed to avoid
exceptions. Therefore, the required arg will be ___provided___ & ___ignored___ to return default value.

> __Note__:
If an extension is omitted (like `professional`), the default value will be used.\
`null` will only be returned if declared with a `null` value. (like `rude`)

## Json Converter

Serializing enums almost always requires a switch statement.\
Mistakes can easily be made when converting from a `String` (or other types) to an enum.

The Json converter class is a great way to handle your enums' serialization.

The name of json converter class will be `${NAME_OF_ENUM}Conv`

For a detailed example, go to [toJson/fromJson](#tojson--fromjson)

```dart
// Generated Json Converter class
final conv = GreetingConv();

conv.toJson(Greeting.professional); // professional
conv.fromJson('professional'); // Greeting.professional
```

# Build Configuration

Customize the [settings](#enum-assist) for each enum, or for all enums inside your `build.yaml` file.

```yaml
targets:
  $default:
    builders:
      enum_assist:
        enabled: true
        options:
          # possible values:
          # - true
          # - false
          # default: true
          create_json_conv: true

          # possible values:
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
          # default: false
          use_int_value_for_serialization: false
```

<details>
<summary>Some Examples!</summary>

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
This can be done by annotating the enum's values with [EnumValue](#EnumValue),
And then adding the extension to the [`extensions`](#extensions) field.

> __Note__:\
Because the [`.map(...)`](#map) requires all args to be defined, we must add the `ResponseExt` extension to ___ALL enum fields___.\
_Failure to do so will result in an error when generating the code._

```dart
@EnumAssist()
enum Greeting {
  @EnumValue(
    extensions: [
      ResponseExt('Hello, how do you do?'),
    ],
  )
  professional,

  @EnumValue(
    extensions: [
      ResponseExt('Hey! Hows it going?'),
    ],
  )
  friendly,

  @EnumValue(
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
This can be done by adding the [`EnumValue`] annotation to ___any enum field___.
And then adding the extension to the `extensions` list.

```dart
@EnumAssist()
enum Greeting {
  professional,

  @EnumValue(
    extensions: [
      IsCoolExt(true),
    ],
  )
  friendly,

  @EnumValue(
    extensions: [
      IsCoolExt(true),
    ],
  )
  relaxed,
}
```

> __Notice This__:\
We did not annotate `professional` with [`EnumValue`] or `IsCoolExt`.\
  This is because [`.maybeMap(...)`](#maybe-map) doesn't require all callbacks to be defined.
>
> The generator will use the `defaultValue` from `IsCoolExt` as the return value.

After the [build_runner](#build-runner-commands) has run, you can now access the `.isCool` method on the `Greeting` enum.

```dart
var greet = Greeting.friendly;
greet.isCool; // true

Greeting.professional.isCool; // false
```

## toJson & fromJson

Serializing enums almost always requires a switch statement.\
Mistakes can easily be made when converting from a string to an enum.

[Json Converter Classes](#json-converter-class) are a great way to handle this.

Let's create an enum for the two examples below, [Using json_serializable](#using-json_serializable) & [Manually Serializing](#manually-serializing).

```dart
@EnumAssist()
enum SuperHeroes {
  @EnumValue(serializedValue: 'Capitan America')
  capitanAmerica,

  @EnumValue(serializedValue: 'Black Widow')
  blackWidow,

  @EnumValue(serializedValue: 'Dr. Strange')
  drStrange,
}
```

### Using json_serializable

[json_serializable] will automatically serialize enums to json by using [describeEnum](https://api.flutter.dev/flutter/foundation/describeEnum.html). This is great if your enum's values are exactly the same as the json values. But that is not always the case, just like our `SuperHeroes` enum.

Let's use our generated class `SuperHeroesConv` fix that problem!

Here is our example class, annotated with `JsonSerializable`

```dart
@JsonSerializable()
class Character {
  const Character(
    this.secretIdentity,
    this.hero,
    this.powerLevel,
  );

  final String secretIdentity;
  final SuperHeroes hero;

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}
```

By default, [json_serializable] will serialize our hero field using the literal enum value as a `String`.

```dart
final steve = Character('Steve Rogers', SuperHeroes.capitanAmerica);

final json = steve.toJson();

print(json['hero']); //capitanAmerica
```

To tell [json_serializable] to convert the `hero` field with the values provided by `EnumValue.serializedValue`, you'll need to annotated the field in your class

```dart
  final String secretIdentity;

  @SuperHeroesConv()
  final SuperHeroes hero;
```

__Note__:
If `hero` were nullable, you would need to annotate the field with a nullable converter

```dart
  final String secretIdentity;

  @SuperHeroesConv.nullable
  final SuperHeroes hero;
```

After you run the [build_runner], the json value for the `hero` field will now be

```dart
final steve = Character('Steve Rogers', SuperHeroes.capitanAmerica);

final json = steve.toJson();

print(json['hero']); // Capitan America
```

### Manually Serializing

Here is an example of what your class could look like

```dart
class Character {
  const Character(
    this.secretIdentity,
    this.hero,
  );

  final String secretIdentity;
  final SuperHeroes hero;

  Map<String, dynamic> toJson() {
    return {
      'secretIdentity': secretIdentity,
      'hero': superHeroToJson(hero),
    };
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      json['secretIdentity'] as String,
      superHeroFromJson(json['hero'] as String),
    );
  }
}

String superHeroToJson(SuperHeroes hero) {
  switch (hero) {
    case SuperHeroes.capitanAmerica:
      return 'Capitan America';
    case SuperHeroes.blackWidow:
      return 'Black Widow';
    case SuperHeroes.drStrange:
      return 'Dr. Strange';
  }
}

SuperHeroes superHeroFromJson(String hero) {
  switch (hero) {
    case 'Capitan America':
      return SuperHeroes.capitanAmerica;
    case 'Black Widow':
      return SuperHeroes.blackWidow;
    case 'Dr. Strange':
      return SuperHeroes.drStrange;
    default:
      throw Exception('Could not find superhero for $hero');
  }
}
```

It's a lot of work to just convert an enum to json!\
Thankfully, the generated class `SuperHeroConv` can do all of the work here

Our `toJson` and `fromJson` methods will now look like this

```dart
class Character {
  const Character(
    this.secretIdentity,
    this.hero,
  );

  final String secretIdentity;
  final SuperHeroes hero;

  static const _conv = SuperHeroesConv();

  Map<String, dynamic> toJson() {
    return {
      'secretIdentity': secretIdentity,
      'hero': _conv.toJson(hero),

      // you could also use the `serialized` method here
      // which is the same as _conv.toJson(hero)
      //
      // 'hero': hero.serialized,
    };
  }

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      json['secretIdentity'] as String,
      _conv.fromJson(json['hero'] as String),
    );
  }
}
```

Here's what the `hero`'s value would look like

```dart
final steve = Character('Steve Rogers', SuperHeroes.capitanAmerica);

final json = steve.toJson();

print(json['hero']); // Capitan America
```

</details>

[`EnumAssist`]: https://github.com/mrgnhnt96/enum_assist/blob/main/packages/enum_assist_annotation/lib/src/enum_assist.dart
[`EnumValue`]: https://github.com/mrgnhnt96/enum_assist/blob/main/packages/enum_assist_annotation/lib/src/enum_value.dart
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
[`build.yaml`]: #build-configuration
