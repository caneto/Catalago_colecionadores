import 'dart:io';

import 'package:dio/dio.dart';

import 'package:app_agendamento/src/core/rest_client/rest_client.dart';
import 'package:app_agendamento/src/services/auth/auth_service.dart';

import '../../core/exceptions/failure.dart';
import '../../core/exceptions/user_exists_exception.dart';
import '../../core/local_storage/local_storage.dart';
import '../../core/logger/app_logger.dart';
import '../../core/rest_client/rest_client_exception.dart';
import '../../models/user.dart';

class AuthServiceImpl implements AuthService {
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;
  final AppLogger _log;
  final RestClient _restClient;

  AuthServiceImpl({
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
    required AppLogger log,
    required RestClient restClient,
  })  : _localStorage = localStorage,
        _localSecureStorage = localSecureStorage,
        _log = log,
        _restClient = restClient;
  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _restClient.post('/v1-sign-in', data: {
        'email': email,
        'password': password,
      });

      return User.fromMap(response.data['result']);
    } on RestClientException catch (e, s) {
      if (e.statusCode == HttpStatus.badRequest &&
          e.response.data['message'].contains('Usuário já cadastrado')) {
        _log.error(e.error, e, s);
        Error.throwWithStackTrace(UserExistsException(), s);
      }

      _log.error('Erro ao cadastrar usuário', e, s);
      Error.throwWithStackTrace(
        const Failure(message: 'Erro ao registrar usuário'),
        s,
      );
    }
  }
}
