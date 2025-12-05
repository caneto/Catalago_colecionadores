import 'package:catalago_colecionadores/src/core/ui/helpers/messages.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/app_default_especial_button.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/app_default_textformfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/database/isar_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with MessageViewMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: sizeOf.height),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(R.ASSETS_IMAGES_CAPA_START_PNG),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(25),
                constraints: BoxConstraints(maxWidth: sizeOf.width * .84),
                decoration: const BoxDecoration(
                  color: CatalagoColecionadorTheme.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Login',
                        style: CatalagoColecionadorTheme.titleStyle,
                      ),
                      const SizedBox(height: 32),
                      AppDefaultTextformfield(
                        title: "Email",
                        hintText: 'Digite um E-mail valido',
                        controller: _emailEC,
                        onFieldSubmitted: (_) => _enterButton(),
                        validator: Validatorless.multiple([
                          Validatorless.required('Email Obrigatório'),
                          Validatorless.email('Email inválido'),
                        ]),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      Watch((_) {
                        return AppDefaultTextformfield(
                          title: 'Password',
                          obscureControll:
                              true, // habilita o obscure e seus funcões
                          obscureText: !_passwordVisible,
                          controller: _passwordEC,
                          validator: Validatorless.required(
                            'Senha obrigatória',
                          ),
                          hintText: 'Digite uma senha valida',
                          passwordToggle: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        );
                      }),
                      const SizedBox(height: 30),
                      AppDefaultEspecialButton(
                        tipoBotao: true,
                        onPressed: _enterButton,
                        label: 'Login',
                        width: sizeOf.width * .78,
                        height: 48,
                      ),
                      const SizedBox(height: 12),
                      AppDefaultEspecialButton(
                        onPressed: () {
                          context.go('/home');
                        },
                        label: "",
                        width: sizeOf.width * .84,
                        height: 48,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              R.ASSETS_IMAGES_GOOGLE_LOGO2_PNG,
                              width: 38.0,
                              height: 38.0,
                            ),
                            const SizedBox(width: 12),
                            const Text('Entrar com Google'),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              CatalagoColecionadorTheme.blackClaroColor,
                          side: const BorderSide(
                            color: CatalagoColecionadorTheme.blackClaroColor,
                          ), // contorno branco
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppDefaultEspecialButton(
                        onPressed: () async {
                          context.go('/login');
                        },
                        label: "",
                        width: sizeOf.width * .84,
                        height: 48,
                        widget: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              R.ASSETS_IMAGES_FACEBOOK_LOGO_PNG,
                              width: 38.0,
                              height: 38.0,
                            ),
                            const SizedBox(width: 16),
                            const Text('Entrar com Facebook'),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              CatalagoColecionadorTheme.blackClaroColor,
                          side: const BorderSide(
                            color: CatalagoColecionadorTheme.blackClaroColor,
                          ), // contorno branco
                        ),
                      ),
                      SizedBox(
                        width: sizeOf.width * .84,
                        height: 44,
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: CatalagoColecionadorTheme.blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                const TextSpan(text: 'Esqueceu sua senha? '),
                                TextSpan(
                                  text: 'Click aqui.',
                                  style: const TextStyle(
                                    color:
                                        CatalagoColecionadorTheme.orangeColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.push('/password_recovery');
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: sizeOf.width * .84,
                        height: 22,
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: CatalagoColecionadorTheme.blackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                const TextSpan(text: 'Criar sua Conta - '),
                                TextSpan(
                                  text: 'Click aqui.',
                                  style: const TextStyle(
                                    color:
                                        CatalagoColecionadorTheme.orangeColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.go('/registro');
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _enterButton() {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (formValid) {
      FocusScope.of(context).unfocus();
      IsarService().loginUser(_emailEC.text, _passwordEC.text).then((user) {
        if (mounted) {
          if (user != null) {
            context.go('/home');
          } else {
            Messages.showError('Email ou senha inválidos', context);
          }
        }
      });
    }
  }
}
