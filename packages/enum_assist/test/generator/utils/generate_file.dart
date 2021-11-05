import 'dart:io';

import 'package:build_test/build_test.dart';
import 'package:enum_assist/src/enum_assist.dart';
import 'package:enum_assist/src/src.dart';
import 'package:source_gen/source_gen.dart';

Future<String> getGeneratedInput(String fileName,
    {bool addPart = false}) async {
  final path = 'test/generator/content/$fileName.dart';

  String? part;

  if (addPart) {
    part = "part '$fileName.g.dart';";
  }

  final content = await _getFileContent(path, part);

  return content;
}

Future<String> getGeneratedOutput(String fileName) async {
  final path = 'test/generator/content/output/$fileName.dart';

  final output = await _getFileContent(path);
  const generatedByHand = '// GENERATED CODE - DO NOT MODIFY BY HAND\n';

  final part = "part of '$fileName.dart';\n";

  const generator = '''
// **************************************************************************
// EnumAssistGenerator
// **************************************************************************''';

  return [generatedByHand, part, generator, output].join('\n');
}

Future<String> _getFileContent(String path, [String? part]) async {
  final file = File(path);
  final content = await file.readAsString();

  return content.replaceFirst(RegExp("part .*';\n"), part ?? '');
}

Future generateFile(
  String fileName, {
  Settings? settings,
  bool getOutput = false,
}) async {
  final inputs = <String, String>{};
  final outputs = <String, String>{};
  final fileBase = 'a|lib/$fileName';

  // If the output is requested, then we need to add the "part" to the file
  final addPart = getOutput;

  final content = await getGeneratedInput(fileName, addPart: addPart);

  inputs['$fileBase.dart'] = content;

  if (getOutput) {
    final output = await getGeneratedOutput(fileName);

    outputs['$fileBase.g.dart'] = output;
  }

  final builder = PartBuilder(
    [EnumAssistGenerator.fromSettings(settings ?? Settings.manual())],
    '.g.dart',
  );

  await testBuilder(
    builder,
    inputs,
    outputs: outputs,
    onLog: print,
    isInput: (String input) => input.contains(fileBase),
    reader: await PackageAssetReader.currentIsolate(),
  );
}
