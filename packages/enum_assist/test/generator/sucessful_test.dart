import 'package:test/test.dart';

import 'utils/generate_file.dart';

void main() {
  test('basic', () async {
    await generateFile('basic_enum', getOutput: true);
  });
}
