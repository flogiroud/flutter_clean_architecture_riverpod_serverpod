import 'dart:typed_data';

import 'package:nexo_client/nexo_client.dart';
import 'package:nexo_flutter/src/domain/i_repositories/i_user_repository.dart';

class UpdateImageUseCase {
  final IUserRepository userRepository;

  UpdateImageUseCase(this.userRepository);

  Future<NexoUserInfo> call(ByteData data) async {
    final result = await userRepository.updateImage(data: data);

    if (!result) throw Exception('Error while updating image');
    return await userRepository.getUser();
  }
}
