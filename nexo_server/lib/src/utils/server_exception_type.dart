import 'package:json_annotation/json_annotation.dart';

part 'server_exception_type.g.dart';

@JsonEnum(fieldRename: FieldRename.snake, alwaysCreate: true)
enum ServerExceptionType {
  unknown,
}

class ErrorTypeConverter extends JsonConverter<ServerExceptionType, String?> {
  const ErrorTypeConverter();

  @override
  ServerExceptionType fromJson(String? json) =>
      $enumDecodeNullable(_$ServerExceptionTypeEnumMap, json,
          unknownValue: ServerExceptionType.unknown) ??
      ServerExceptionType.unknown;

  @override
  String toJson(ServerExceptionType object) =>
      _$ServerExceptionTypeEnumMap[object] ?? "unknown";
}
