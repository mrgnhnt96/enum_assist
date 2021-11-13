// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Configuration for using `package:build`-compatible build systems.
///
/// See:
/// * [build_runner](https://pub.dev/packages/build_runner)
///
/// This library is **not** intended to be imported by typical end-users unless
/// you are creating a custom compilation pipeline. See documentation for
/// details, and `build.yaml` for how these builders are configured by default.

import 'package:build/build.dart';
import 'package:enum_assist/src/enum_assist.dart';
import 'package:enum_assist/src/settings.dart';
import 'package:source_gen/source_gen.dart';

/// Supports `package:build_runner` creation and configuration of
/// `enum_assist`.
///
/// Not meant to be invoked by hand-authored code.
Builder enumAssist(BuilderOptions options) {
  // get settings from the build file
  final settings = Settings.resolve(options.config);

  final ignores = [
    'constant_identifier_names',
    'prefer_const_declarations',
    'unused_local_variable',
    'prefer_int_literals',
    'lines_longer_than_80_chars',
    'prefer_const_constructors'
  ];

  return PartBuilder([EnumAssistGenerator.fromSettings(settings)], '.ge.dart',
      header: '''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: ${ignores.join(',')}
    ''');
}
