import 'package:nexo_client/nexo_client.dart';
import 'package:nexo_flutter/src/domain/i_repositories/i_user_repository.dart';

class UpdatePseudoUseCase {
  final IUserRepository userRepository;

  UpdatePseudoUseCase(this.userRepository);

  Future<NexoUserInfo> call(String pseudo) async {
    return await userRepository.updatePseudo(pseudo: pseudo);
  }
}
