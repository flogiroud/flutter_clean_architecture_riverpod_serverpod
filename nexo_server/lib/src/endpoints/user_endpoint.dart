import 'package:nexo_server/src/utils/server_exception_type.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/module.dart';

class UserEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<UserInfo> updatePseudo(Session session, String name) async {
    final userId = await session.auth.authenticatedUserId;

    if (userId == null) {
      throw Exception(ServerExceptionType.unknown);
    }
    final userInfo = await Users.changeUserName(session, userId, name);

    if (userInfo == null) {
      throw Exception('User not found');
    }
    return userInfo;
  }

  Future<UserInfo> getUser(Session session) async {
    final userId = await session.auth.authenticatedUserId;
    if (userId == null) {
      throw Exception('User not logged in');
    }
    final user = await Users.findUserByUserId(session, userId);
    if (user == null) {
      throw Exception('User not found');
    }
    return user;
  }
}
