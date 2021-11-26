import 'package:test/test.dart';

import 'utils/generate_file.dart';

void main() {
  const files = [
    'basic_enum',
    'create_description',
    'create_json_conv',
    'create_name',
    'create_readable',
    'create_serialized',
    'create_to_int',
  ];

  for (final file in files) {
    test(file, () async {
      await generateFile(file, getOutput: true);
    });
  }
}
