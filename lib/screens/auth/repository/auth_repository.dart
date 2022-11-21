import 'package:greengrocer/constants/endpoints.dart';
import 'package:greengrocer/models/user.dart';
import 'package:greengrocer/screens/auth/repository/auth_errors.dart'
    as auth_errors;
import 'package:greengrocer/screens/auth/result/auth_result.dart';
import 'package:greengrocer/services/http_manager.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  AuthResult handleUserOrError(Map result) {
    if (result['result'] != null) {
      final user = User.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(auth_errors.authErrorsString(result['error']));
    }
  }

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.validateToken,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    return handleUserOrError(result);
  }

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signin,
      method: HttpMethods.post,
      body: {
        'email': email,
        'password': password,
      },
    );

    return handleUserOrError(result);
  }

  Future<AuthResult> signUp(User user) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.signup,
      method: HttpMethods.post,
      body: user.toJson(),
    );

    return handleUserOrError(result);
  }

  Future<void> resetPassword(String email) async {
    final result = _httpManager.restRequest(
      url: Endpoints.resetPassword,
      method: HttpMethods.post,
      body: {'email': email},
    );
  }
}
