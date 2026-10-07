import 'package:tasteway/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> register({
    required String email,
    required String password,
    String? name,
  });

  Future<User> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<User?> getCurrentUser();

  Future<bool> isAuthenticated();
}
