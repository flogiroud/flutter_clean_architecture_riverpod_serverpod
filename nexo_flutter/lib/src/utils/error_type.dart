import 'package:json_annotation/json_annotation.dart';
import 'package:nexo_flutter/src/utils/constants.dart';

part 'error_type.g.dart';

@JsonEnum(fieldRename: FieldRename.snake, alwaysCreate: true)
enum ErrorType {
  // ANCHOR Server

  // ANCHOR Data
  loginFailed,
  registerFailed,
  validateAccountFailed,
  initiatePasswordResetFailed,
  resetPasswordFailed,
  // ANCHOR Domain

  // ANCHOR Presentation
  invalidPseudo,
  invalidEmail,
  passwordTooShort,
  // ANCHOR Other
  unknown,
}

class ErrorTypeConverter extends JsonConverter<ErrorType, String?> {
  const ErrorTypeConverter();

  @override
  ErrorType fromJson(String? json) =>
      $enumDecodeNullable(_$ErrorTypeEnumMap, json,
          unknownValue: ErrorType.unknown) ??
      ErrorType.unknown;

  @override
  String toJson(ErrorType object) => _$ErrorTypeEnumMap[object] ?? kUnknown;
}
