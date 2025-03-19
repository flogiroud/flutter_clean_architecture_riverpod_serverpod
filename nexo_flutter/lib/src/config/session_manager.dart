import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';

import 'client.dart';

var sessionManager = SessionManager(
  caller: client.modules.auth,
);
