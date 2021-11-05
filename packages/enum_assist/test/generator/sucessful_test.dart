import 'package:logging/logging.dart';
import 'package:test/test.dart';

import 'utils/generate_file.dart';

void main() {
  Logger.root.level = Level.ALL;

  test('basic', () async {
    await generateFile('basic_enum', getOutput: true);
  });
}
