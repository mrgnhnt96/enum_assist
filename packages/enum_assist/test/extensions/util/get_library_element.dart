import 'package:analyzer/dart/element/element.dart';
import 'package:build_test/build_test.dart';

Future<LibraryElement> getLibraryElement(String fileName) async {
  return resolveSources(
      {
        'enum_assist|test/extensions/integration/$fileName.dart':
            useAssetReader,
      },
      (r) => r.libraries
          .firstWhere((l) => l.source.toString().contains(fileName)));
}
