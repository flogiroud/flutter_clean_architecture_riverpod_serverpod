/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod_auth_server/module.dart' as _i2;

class NexoUserInfo extends _i1.SerializableEntity {
  NexoUserInfo({required this.userInfo});

  factory NexoUserInfo.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return NexoUserInfo(
        userInfo: serializationManager
            .deserialize<_i2.UserInfo>(jsonSerialization['userInfo']));
  }

  _i2.UserInfo userInfo;

  @override
  Map<String, dynamic> toJson() {
    return {'userInfo': userInfo};
  }

  @override
  Map<String, dynamic> allToJson() {
    return {'userInfo': userInfo};
  }
}
