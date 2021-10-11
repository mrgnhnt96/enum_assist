// Copyright (c) 2021, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:build/build.dart';
import 'package:enum_assist/src/enum_assist_generator.dart';
import 'package:enum_assist/src/settings.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';
import 'package:source_gen/source_gen.dart';

/// Returns a [Builder] for use within a `package:build_runner`
/// `BuildAction`.
///
/// [formatOutput] is called to format the generated code. If not provided,
/// the default Dart code formatter is used.
Builder enumAssistBuilder({
  String Function(String code)? formatOutput,
  EnumAssist? config,
}) {
  final settings = Settings(config: config);

  return SharedPartBuilder(
    [EnumAssistGenerator.fromSettings(settings)],
    'enum_assist',
    formatOutput: formatOutput,
  );
}
