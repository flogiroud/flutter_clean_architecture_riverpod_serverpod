import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/data/repositories/api/auth_repository_impl.dart';
import 'package:nexo_flutter/src/data/repositories/api/user_repository_impl.dart';
import 'package:nexo_flutter/src/data/repositories/system/device_repository_impl.dart';
import 'package:nexo_flutter/src/domain/i_repositories/i_auth_repository.dart';
import 'package:nexo_flutter/src/domain/i_repositories/i_device_repository.dart';
import 'package:nexo_flutter/src/domain/i_repositories/i_user_repository.dart';

final authRepositoryProvider =
    Provider<IAuthRepository>((ref) => AuthRepositoryImpl());
final userRepositoryProvider =
    Provider<IUserRepository>((ref) => UserRepositoryImpl());
final deviceRepositoryProvider =
    Provider<IDeviceRepository>((ref) => DeviceRepositoryImpl());
