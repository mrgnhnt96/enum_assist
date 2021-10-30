import 'dart:io';

import 'package:build_test/build_test.dart';
import 'package:enum_assist/src/enum_assist.dart';
import 'package:enum_assist/src/src.dart';
import 'package:source_gen/source_gen.dart';

Future generateFile(
  String fileName, {
  Settings? settings,
  bool getOutput = false,
}) =>
    generateFiles([fileName], settings: settings, getOutput: getOutput);

Future generateFiles(
  List<String> fileNames, {
  Settings? settings,
  bool getOutput = false,
}) async {
  final inputs = <String, String>{};
  final outputs = <String, String>{};

  for (final name in fileNames) {
    final path = 'test/generator/content/$name.dart';

    final file = File(path);
    final content = await file.readAsString();
    inputs['a|lib/$name.dart'] = content;

    if (!getOutput) continue;

    final outputPath = 'test/generator/output/$name.dart';
    final outputFile = File(outputPath);
    final output = await outputFile.readAsString();

    outputs['a|lib/$name.g.dart'] = output;
  }

  final builder = PartBuilder(
    [EnumAssistGenerator.fromSettings(settings ?? Settings.manual())],
    '.g.dart',
  );

  await testBuilder(
    builder,
    inputs,
    outputs: outputs,
    reader: await PackageAssetReader.currentIsolate(),
  );
}
