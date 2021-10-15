import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';

extension LibraryElementX on LibraryElement {
  Future<ErrorsResult> getErrorResults(String fileName) async {
    return await session.getErrors(
        '/enum_assist/test/integration/$fileName.ge.dart') as ErrorsResult;
  }
}
