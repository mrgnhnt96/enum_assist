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
This can be done by annotating the enum's values with [`EnumKey`],
And then adding the extension to the `extensions` field.

> __Note__:\
Because the `.map(...)` requires all args to be defined, we must add the `ResponseExt` extension to ___ALL enum fields___.\
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

After the [build_runner] has run, you can now access the `.response` method on the `Greeting` enum.

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
  This is because `.maybeMap(...)` doesn't require all callbacks to be defined.
>
> The generator will use the `defaultValue` from `IsCoolExt` as the return value.

After the [build_runner] has run, you can now access the `.isCool` method on the `Greeting` enum.

```dart
var greet = Greeting.friendly;
greet.isCool; // true

Greeting.professional.isCool; // false
```


[`EnumKey`]: https://github.com/mrgnhnt96/enum_assist/blob/main/packages/enum_assist_annotation/lib/src/enum_key.dart
[build_runner]: https://pub.dev/packages/build_runner
[`MapExtension`]: https://github.com/mrgnhnt96/enum_assist/blob/main/packages/enum_assist_annotation/lib/src/map_extension.dart
[`MaybeExtension`]: https://github.com/mrgnhnt96/enum_assist/blob/main/packages/enum_assist_annotation/lib/src/maybe_extension.dart
