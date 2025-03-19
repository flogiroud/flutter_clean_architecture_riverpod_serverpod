import 'dart:typed_data';

import 'package:nexo_client/nexo_client.dart';
import 'package:nexo_flutter/src/config/session_manager.dart';
import 'package:nexo_flutter/src/domain/i_repositories/i_user_repository.dart';

import '../../../config/client.dart';

class UserRepositoryImpl extends IUserRepository {
  @override
  Future<NexoUserInfo> updatePseudo({required String pseudo}) async {
    try {
      final userInfo = await client.user.updatePseudo(pseudo);

      return NexoUserInfo(userInfo: userInfo);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<NexoUserInfo> getUser() async {
    final userInfo = await client.user.getUser();

    return NexoUserInfo(userInfo: userInfo);
  }

  @override
  Future<bool> updateImage({required ByteData data}) =>
      sessionManager.uploadUserImage(data);
}
