import 'package:tasteway/data/datasources/remote/auth_api.dart';
import 'package:tasteway/data/models/user_model.dart';
import 'package:tasteway/domain/entities/user.dart';
import 'package:tasteway/domain/repositories/auth_repository.dart';
import 'package:tasteway/services/secure_storage_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi _api;

  AuthRepositoryImpl({AuthApi? api}) : _api = api ?? AuthApi();

  @override
  Future<User> register({
    required String email,
    required String password,
    String? name,
  }) async {
    final response = await _api.register(
      email: email,
      password: password,
      name: name,
    );

    if (response['success'] != true || response['data'] == null) {
      throw Exception(response['errors']?.first ?? 'Registration failed');
    }

    final data = response['data'] as Map<String, dynamic>;
    await _saveTokens(data);

    return UserModel.fromJson(data['user'] as Map<String, dynamic>);
  }

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    final response = await _api.login(
      email: email,
      password: password,
    );

    if (response['success'] != true || response['data'] == null) {
      throw Exception(response['errors']?.first ?? 'Login failed');
    }

    final data = response['data'] as Map<String, dynamic>;
    await _saveTokens(data);

    return UserModel.fromJson(data['user'] as Map<String, dynamic>);
  }

  @override
  Future<void> logout() async {
    await SecureStorageService.clearAll();
  }

  @override
  Future<User?> getCurrentUser() async {
    final isLoggedIn = await SecureStorageService.isLoggedIn();
    if (!isLoggedIn) return null;

    try {
      final response = await _api.getMe();
      if (response['success'] == true && response['data'] != null) {
        return UserModel.fromJson(response['data'] as Map<String, dynamic>);
      }
    } catch (_) {
      // Token might be expired, try refresh
      await _tryRefreshToken();
    }

    return null;
  }

  @override
  Future<bool> isAuthenticated() async {
    return await SecureStorageService.isLoggedIn();
  }

  Future<void> _saveTokens(Map<String, dynamic> data) async {
    final accessToken = data['accessToken'] as String?;
    final refreshToken = data['refreshToken'] as String?;
    final user = data['user'] as Map<String, dynamic>?;

    if (accessToken != null) {
      await SecureStorageService.setAccessToken(accessToken);
    }
    if (refreshToken != null) {
      await SecureStorageService.setRefreshToken(refreshToken);
    }
    if (user != null) {
      await SecureStorageService.setUserId(user['id'] as String);
    }
  }

  Future<void> _tryRefreshToken() async {
    final refreshToken = await SecureStorageService.getRefreshToken();
    if (refreshToken == null) return;

    try {
      final response = await _api.refreshToken(refreshToken);
      if (response['success'] == true && response['data'] != null) {
        final data = response['data'] as Map<String, dynamic>;
        final newAccessToken = data['accessToken'] as String?;
        if (newAccessToken != null) {
          await SecureStorageService.setAccessToken(newAccessToken);
        }
      }
    } catch (_) {
      await SecureStorageService.clearAll();
    }
  }
}
