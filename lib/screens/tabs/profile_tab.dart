import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:greengrocer/screens/auth/controller/auth_controller.dart';

import 'package:greengrocer/widgets/common/custom_elevated_button.dart';
import 'package:greengrocer/widgets/common/custom_outlined_button.dart';
import 'package:greengrocer/widgets/common/custom_text_field.dart';

import 'package:greengrocer/utils/validators.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuário'),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          // Email
          CustomTextField(
            initialValue: authController.user.email,
            readOnly: true,
            icon: Icons.email,
            label: 'Email',
          ),

          // Nome
          CustomTextField(
            initialValue: authController.user.name,
            readOnly: true,
            icon: Icons.person,
            label: 'Nome',
          ),

          // Celular
          CustomTextField(
            initialValue: authController.user.phone,
            readOnly: true,
            icon: Icons.phone,
            label: 'Celular',
          ),

          // CPF
          CustomTextField(
            initialValue: authController.user.cpf,
            readOnly: true,
            icon: Icons.file_copy,
            label: 'CPF',
          ),

          // Botao para atualizar a senha
          CustomOutlinedButton(
            onPressed: () {
              updatePassword();
            },
            textButton: 'Atualizar senha',
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    final newPasswordController = TextEditingController();
    final currentPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (c) {
        return Dialog(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          "Atualização de senha",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      CustomTextField(
                        controller: currentPasswordController,
                        icon: Icons.lock,
                        label: 'Senha atual',
                        isSecret: true,
                        validator: passwordValidator,
                      ),
                      CustomTextField(
                        controller: newPasswordController,
                        icon: Icons.lock_outline,
                        label: 'Nova senha',
                        isSecret: true,
                        validator: passwordValidator,
                      ),
                      CustomTextField(
                        icon: Icons.lock_outline,
                        label: 'Confirmar nova senha',
                        isSecret: true,
                        validator: (password) {
                          FocusScope.of(context).unfocus();

                          final result = passwordValidator(password);

                          if (result != null) {
                            return result;
                          }

                          if (password != newPasswordController.text) {
                            return 'Senhas precisam ser iguais';
                          }

                          return null;
                        },
                      ),
                      Obx(() {
                        return CustomElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              authController.changePassword(
                                currentPassword: currentPasswordController.text,
                                newPassword: newPasswordController.text,
                              );
                            }
                          },
                          text: 'Atualizar',
                          isLoading: authController.isLoading.value,
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
