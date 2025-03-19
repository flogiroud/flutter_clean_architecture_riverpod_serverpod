import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/data/data_module.dart';
import 'package:nexo_flutter/src/domain/use_cases/auth/create_account_request_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/auth/initialite_password_reset_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/auth/log_in_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/auth/reset_password_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/auth/sign_out_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/auth/validate_account_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/camera/check_camera_permission_status_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/camera/request_camera_permission_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/location/check_location_status_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/location/open_location_settings_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/location/request_location_permission_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/user/get_user_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/user/update_image_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/user/update_pseudo_use_case.dart';

// ANCHOR Auth
final signOutUseCaseProvider =
    Provider((ref) => SignOutUseCase(ref.read(authRepositoryProvider)));
final logInUseCaseProvider =
    Provider((ref) => LogInUseCase(ref.read(authRepositoryProvider)));
final createAccountRequestUseCaseProvider = Provider(
    (ref) => CreateAccountRequestUseCase(ref.read(authRepositoryProvider)));
final validateAccountUseCaseProvider =
    Provider((ref) => ValidateAccountUseCase(ref.read(authRepositoryProvider)));
final initiatePasswordResetUseCaseProvider = Provider(
    (ref) => InitiatePasswordResetUseCase(ref.read(authRepositoryProvider)));
final resetPasswordUseCaseProvider =
    Provider((ref) => ResetPasswordUseCase(ref.read(authRepositoryProvider)));
// ANCHOR User
final updatePseudoUseCaseProvider =
    Provider((ref) => UpdatePseudoUseCase(ref.read(userRepositoryProvider)));
final getUserUseCaseProvider =
    Provider((ref) => GetUserUseCase(ref.read(userRepositoryProvider)));
final updateImageUseCaseProvider =
    Provider((ref) => UpdateImageUseCase(ref.read(userRepositoryProvider)));
// ANCHOR Location
final checkLocationStatusUseCaseProvider = Provider(
    (ref) => CheckLocationStatusUseCase(ref.read(deviceRepositoryProvider)));
final requestLocationPermissionUseCaseProvider = Provider((ref) =>
    RequestLocationPermissionUseCase(ref.read(deviceRepositoryProvider)));
final openLocationUseCaseProvider = Provider(
    (ref) => OpenLocationSettingsUseCase(ref.read(deviceRepositoryProvider)));
// ANCHOR Camera
final checkCameraPermissionStatusUseCaseProvider = Provider((ref) =>
    CheckCameraPermissionStatusUseCase(ref.read(deviceRepositoryProvider)));
final requestCameraPermissionStatusUseCaseProvider = Provider((ref) =>
    RequestCameraPermissionUseCase(ref.read(deviceRepositoryProvider)));
