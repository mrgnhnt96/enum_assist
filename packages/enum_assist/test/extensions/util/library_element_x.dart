import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';

extension LibraryElementX on LibraryElement {
  Future<ErrorsResult> getErrorResults(String fileName) async {
    return await session.getErrors(
            '/enum_assist/test/extensions/integration/$fileName.ge.dart')
        as ErrorsResult;
  }

  bool doesConvExist(String enumName) {
    return getType('${enumName}Conv') != null;
  }

  bool doesConvNullableExist(String enumName) {
    return doesConvExist('_${enumName}Nullable');
  }
}
