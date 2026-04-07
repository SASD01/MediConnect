import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';

class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource(this.apiClient);

  String _extractErrorMessage(dynamic data, String fallbackFallback) {
    if (data == null) return fallbackFallback;
    if (data is Map<String, dynamic>) {
      return data['detail']?.toString() ?? data['message']?.toString() ?? '$fallbackFallback: $data';
    }
    if (data is List && data.isNotEmpty) {
      final first = data.first;
      if (first is Map<String, dynamic>) {
        return first['msg']?.toString() ?? first['message']?.toString() ?? '$fallbackFallback: $data';
      }
    }
    return '$fallbackFallback: $data';
  }

  Future<Map<String, dynamic>> login(LoginRequest request) async {
    try {
      final response = await apiClient.dio.post(
        '/auth/login',
        data: request.toJson(),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(_extractErrorMessage(e.response?.data, 'Error de autenticación'));
      } else {
        throw Exception('Error de red al intentar iniciar sesión');
      }
    }
  }

  Future<void> register(RegisterRequest request) async {
    try {
      await apiClient.dio.post(
        '/auth/register',
        data: request.toJson(),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(_extractErrorMessage(e.response?.data, 'Error en el registro'));
      } else {
        throw Exception('Error de red al intentar registrarse');
      }
    }
  }

  Future<Map<String, dynamic>> loginWithGoogle(String idToken) async {
    try {
      final response = await apiClient.dio.post(
        '/auth/login/google',
        data: {'id_token': idToken},
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(_extractErrorMessage(e.response?.data, 'Error en login social'));
      } else {
        throw Exception('Error de red al conectar con Google Login');
      }
    }
  }
}
