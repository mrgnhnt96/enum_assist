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
library enum_assist.builder;

import 'package:build/build.dart';
import 'package:enum_assist/src/enum_assist_builder.dart';
import 'package:enum_assist/src/util/exceptions.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';

/// Supports `package:build_runner` creation and configuration of
/// `enum_assist`.
///
/// Not meant to be invoked by hand-authored code.
Builder enumAssist(BuilderOptions options) {
  try {
    final config = EnumAssist.fromJson(options.config);

    return enumAssistBuilder(config: config);
  } on CheckedFromEnumAssistException catch (e) {
    final lines = <String>[
      'Could not parse the options provided for `enum_assist`.'
    ];

    if (e.key != null) {
      lines.add('There is a problem with "${e.key}".');
    }
    if (e.message != null) {
      lines.add(e.message!);
    } else if (e.innerError != null) {
      lines.add(e.innerError.toString());
    }

    throw StateError(lines.join('\n'));
  }
}
