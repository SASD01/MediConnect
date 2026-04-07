import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login(String email, String password) async {
    final response = await remoteDataSource.login(
      LoginRequest(email: email, password: password),
    );

    final String token = response['access_token'];
    final String userId = response['user_id'];
    final String role = response['role'];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);

    return UserEntity(id: userId, email: email, role: role);
  }

  @override
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) async {
    await remoteDataSource.register(
      RegisterRequest(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
      ),
    );
  }

  @override
  Future<UserEntity> loginWithGoogle(String idToken) async {
    final response = await remoteDataSource.loginWithGoogle(idToken);

    final String token = response['access_token'];
    final String userId = response['user_id'];
    final String role = response['role'];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);

    return UserEntity(id: userId, email: 'google_user', role: role);
  }
}
