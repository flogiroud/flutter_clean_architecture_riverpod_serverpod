import 'package:nexo_flutter/src/utils/error_type.dart';

class CustomExceptionOld implements Exception {
  final ErrorType errorType;
  final String? errorMessage;
  final StackTrace? trace;

  CustomExceptionOld(
    this.errorType, {
    this.errorMessage,
    this.trace,
  });
}
