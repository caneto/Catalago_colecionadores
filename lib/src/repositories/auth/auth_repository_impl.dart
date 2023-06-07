import 'dart:async';

import 'package:app_agendamento/src/core/logger/app_logger.dart';
import 'package:app_agendamento/src/models/user.dart';
import 'package:app_agendamento/src/services/auth/auth_service.dart';

import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthService _authService;
  final AppLogger _log;

  AuthRepositoryImpl({
    required AuthService authService,
    required AppLogger log,
  })  : _authService = authService,
        _log = log;

  @override
  Future<void> login({required String email, required String password}) async {
  
    final loginRespose = _authService.login(email: email, password: password);

    return loginRespose;
  }

}