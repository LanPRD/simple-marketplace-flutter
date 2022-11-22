import 'package:get/get.dart';
import 'package:greengrocer/constants/storage_keys.dart';
import 'package:greengrocer/models/user.dart';
import 'package:greengrocer/routes/app_routes.dart';
import 'package:greengrocer/screens/auth/repository/auth_repository.dart';
import 'package:greengrocer/screens/auth/result/auth_result.dart';
import 'package:greengrocer/utils/utils.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  final authRepository = AuthRepository();
  final utils = Utils();

  User user = User();

  @override
  void onInit() {
    super.onInit();
    validateToken();
  }

  Future<void> validateToken() async {
    String? token = await utils.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    }

    AuthResult result = await authRepository.validateToken(token);

    result.when(
      success: (user) {
        this.user = user;

        utils.saveLocalData(key: StorageKeys.token, data: user.token!);
        Get.offAllNamed(PagesRoutes.baseRoute);
      },
      error: (message) {
        signOut();
      },
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isLoading.value = true;

    final result = await authRepository.changePassword(
      email: user.email!,
      currentPassword: currentPassword,
      newPassword: newPassword,
      token: user.token!,
    );

    isLoading.value = false;

    if (result) {
      utils.showToast(message: 'A senha foi atualizada com sucesso!');

      await signOut();
    } else {
      utils.showToast(
        message: 'A senha atual está incorreta',
        isError: true,
      );
    }
  }

  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }

  Future<void> signOut() async {
    user = User();

    await utils.removeLocalData(key: StorageKeys.token);
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  Future<void> signUp() async {
    isLoading.value = true;

    AuthResult result = await authRepository.signUp(user);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        utils.saveLocalData(key: StorageKeys.token, data: user.token!);
        Get.offAllNamed(PagesRoutes.baseRoute);
      },
      error: (message) {
        utils.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    AuthResult result =
        await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(
      success: (user) {
        this.user = user;

        utils.saveLocalData(key: StorageKeys.token, data: user.token!);
        Get.offAllNamed(PagesRoutes.baseRoute);
      },
      error: (message) {
        utils.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
