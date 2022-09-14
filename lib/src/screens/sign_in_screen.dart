import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';

import 'package:greengrocer/src/routes/app_routes.dart';

import 'package:greengrocer/src/widgets/app_name.dart';
import 'package:greengrocer/src/widgets/custom_text_field.dart';
import 'package:greengrocer/src/widgets/custom_elevated_button.dart';
import 'package:greengrocer/src/widgets/custom_outlined_button.dart';

import 'package:greengrocer/src/theme/custom_colors.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

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
                    const AppNameWidget(greenTitleColor: Colors.white, textSize: 40),

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
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Email field
                    const CustomTextField(
                      icon: Icons.email,
                      label: 'Email',
                    ),

                    // Senha field
                    const CustomTextField(
                      icon: Icons.lock,
                      label: 'Senha',
                      isSecret: true,
                    ),

                    // Entrar
                    CustomElevatedButton(
                        text: 'Entrar',
                        onPressed: () {
                          Get.offNamed(PagesRoutes.baseRoute);
                        }),

                    // Esqueceu a senha
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}
