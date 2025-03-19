import 'package:nexo_client/nexo_client.dart';
import 'package:nexo_flutter/src/domain/i_repositories/i_user_repository.dart';

class GetUserUseCase {
  final IUserRepository userRepository;

  GetUserUseCase(this.userRepository);

  Future<NexoUserInfo> call() async {
    return await userRepository.getUser();
  }
}
