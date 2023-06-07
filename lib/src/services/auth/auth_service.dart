abstract class AuthService {
  Future<void> login({required String email, required String password});
}