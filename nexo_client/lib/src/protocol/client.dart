/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

import 'dart:async' as _i2;
import 'dart:io' as _i4;

import 'package:serverpod_auth_client/module.dart' as _i3;
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

import 'protocol.dart' as _i5;

class _EndpointUser extends _i1.EndpointRef {
  _EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  _i2.Future<_i3.UserInfo> updatePseudo(String name) =>
      caller.callServerEndpoint<_i3.UserInfo>(
        'user',
        'updatePseudo',
        {'name': name},
      );

  _i2.Future<_i3.UserInfo> getUser() => caller.callServerEndpoint<_i3.UserInfo>(
        'user',
        'getUser',
        {},
      );
}

class _Modules {
  _Modules(Client client) {
    auth = _i3.Caller(client);
  }

  late final _i3.Caller auth;
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i4.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i5.Protocol(),
          authenticationKeyManager: authenticationKeyManager,
        ) {
    user = _EndpointUser(this);
    modules = _Modules(this);
  }

  late final _EndpointUser user;

  late final _Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {'user': user};
  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
