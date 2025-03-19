import 'dart:typed_data';

import 'package:nexo_client/nexo_client.dart';

abstract class IUserRepository {
  Future<NexoUserInfo> updatePseudo({required String pseudo});

  Future<NexoUserInfo> getUser();

  Future<bool> updateImage({required ByteData data});
}
