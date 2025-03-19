import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/utils/custom_exception.dart';
import 'package:nexo_flutter/src/utils/error_type.dart';

class NotifierErrorStateHandler {
  static AsyncValue<String> fromException(Object exception, StackTrace? trace) {
    final traceToReturn = trace ?? StackTrace.current;

    if (exception is CustomExceptionOld) {
      return AsyncValue.error(exception.errorType, traceToReturn);
    } else {
      return AsyncValue.error(ErrorType.unknown, traceToReturn);
    }
  }
}
