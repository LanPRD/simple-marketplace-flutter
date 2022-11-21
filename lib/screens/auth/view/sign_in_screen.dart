import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';

import 'package:greengrocer/routes/app_routes.dart';
import 'package:greengrocer/screens/auth/components/forgot_password_dialog.dart';
import 'package:greengrocer/screens/auth/controller/auth_controller.dart';

import 'package:greengrocer/widgets/app_name.dart';
import 'package:greengrocer/widgets/common/custom_elevated_button.dart';
import 'package:greengrocer/widgets/common/custom_outlined_button.dart';
import 'package:greengrocer/widgets/common/custom_text_field.dart';

import 'package:greengrocer/theme/custom_colors.dart';
import 'package:greengrocer/utils/validators.dart';
import 'package:greengrocer/utils/utils.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final utils = Utils();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Nome do app
                    const AppNameWidget(
                        greenTitleColor: Colors.white, textSize: 40),

                    // Categorias
                    SizedBox(
                      height: 32,
                      child: DefaultTextStyle(
                        style: const TextStyle(fontSize: 24),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          pause: Duration.zero,
                          animatedTexts: [
                            FadeAnimatedText('Frutas'),
                            FadeAnimatedText('Verduras'),
                            FadeAnimatedText('Legumes'),
                            FadeAnimatedText('Carnes'),
                            FadeAnimatedText('Cereais'),
                            FadeAnimatedText('Laticíneos'),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // Formulario
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Email field
                      CustomTextField(
                        controller: emailController,
                        icon: Icons.email,
                        label: 'Email',
                        validator: emailValidator,
                      ),

                      // Senha field
                      CustomTextField(
                        controller: passwordController,
                        icon: Icons.lock,
                        label: 'Senha',
                        isSecret: true,
                        validator: passwordValidator,
                      ),

                      // Entrar
                      GetX<AuthController>(
                        builder: (authController) {
                          return CustomElevatedButton(
                            isLoading: authController.isLoading.value,
                            text: 'Entrar',
                            onPressed: () {
                              FocusScope.of(context).unfocus();

                              if (_formKey.currentState!.validate()) {
                                String email = emailController.text;
                                String password = passwordController.text;

                                authController.signIn(
                                  email: email,
                                  password: password,
                                );
                              }
                              // Get.offNamed(PagesRoutes.baseRoute);
                            },
                          );
                        },
                      ),

                      // Esqueceu a senha
                      Align(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () async {
                            final bool? result = await showDialog(
                              context: context,
                              builder: (_) {
                                return ForgotPasswordDialog(
                                  email: emailController.text,
                                );
                              },
                            );

                            if (result ?? false) {
                              utils.showToast(
                                message:
                                    'Um link de recuperação foi enviado para seu email.',
                              );
                            }
                          },
                          child: const Text(
                            'Esqueceu a senha?',
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                        ),
                      ),

                      // Divisor
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.withAlpha(90),
                              thickness: 2,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text("Ou"),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.withAlpha(90),
                              thickness: 2,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      // Criar conta
                      CustomOutlinedButton(
                        onPressed: () {
                          Get.toNamed(PagesRoutes.signUpRoute);
                        },
                        textButton: 'Criar conta',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
