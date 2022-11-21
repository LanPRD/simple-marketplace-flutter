import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:greengrocer/screens/auth/controller/auth_controller.dart';

import 'package:greengrocer/widgets/common/custom_elevated_button.dart';
import 'package:greengrocer/widgets/common/custom_outlined_button.dart';
import 'package:greengrocer/widgets/common/custom_text_field.dart';

import 'package:greengrocer/utils/app_data.dart' as app_data;

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
            initialValue: app_data.user.email,
            readOnly: true,
            icon: Icons.email,
            label: 'Email',
          ),

          // Nome
          CustomTextField(
            initialValue: app_data.user.name,
            readOnly: true,
            icon: Icons.person,
            label: 'Nome',
          ),

          // Celular
          CustomTextField(
            initialValue: app_data.user.phone,
            readOnly: true,
            icon: Icons.phone,
            label: 'Celular',
          ),

          // CPF
          CustomTextField(
            initialValue: app_data.user.cpf,
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
    return showDialog(
      context: context,
      builder: (c) {
        return Dialog(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
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
                    const CustomTextField(
                      icon: Icons.lock,
                      label: 'Senha atual',
                      isSecret: true,
                    ),
                    const CustomTextField(
                      icon: Icons.lock_outline,
                      label: 'Nova senha',
                      isSecret: true,
                    ),
                    const CustomTextField(
                      icon: Icons.lock_outline,
                      label: 'Confirmar nova senha',
                      isSecret: true,
                    ),
                    CustomElevatedButton(
                      onPressed: () {},
                      text: 'Atualizar',
                    ),
                  ],
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
