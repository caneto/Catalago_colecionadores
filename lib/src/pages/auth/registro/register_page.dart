// ignore_for_file: use_build_context_synchronously

import 'package:catalago_colecionadores/src/core/ui/helpers/messages.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/app_default_especial_button.dart';
import 'package:catalago_colecionadores/src/core/ui/widgets/app_default_textformfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with MessageViewMixin {
  final _formKey = GlobalKey<FormState>();

  final _fullnameEC = TextEditingController();
  final _usernameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    _fullnameEC.dispose();
    _usernameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: CatalagoColecionadorTheme.textRegisterColor,
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
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cadastro',
                        style: CatalagoColecionadorTheme.titleStyle,
                      ),
                      Text(
                        'Preeche os campos abaixo para criar o seu cadastro',
                        style: CatalagoColecionadorTheme.titleStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 30),
                      AppDefaultTextformfield(
                        hintText: "Digite seu nome completo",
                        title: 'Nome completo',
                        controller: _fullnameEC,
                        validator: Validatorless.required(
                          'Nome completo Obrigatório',
                        ),
                      ),
                      const SizedBox(height: 20),
                      AppDefaultTextformfield(
                        hintText: "Digite seu nome de usúario",
                        title: 'Nome de Usúario',
                        controller: _usernameEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('Nome de usuario Obrigatório'),
                          Validatorless.min(3, "Minimo de 3 caracteres"),
                          Validatorless.max(12, "Maximo de 12 caracteres"),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      AppDefaultTextformfield(
                        title: 'E-mail',
                        hintText: "Entre com seu email",
                        controller: _emailEC,
                        keyboardType: TextInputType.emailAddress,
                        validator: Validatorless.multiple([
                          Validatorless.required('E-mail Obrigatório'),
                          Validatorless.email('E-mail inválido'),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      AppDefaultTextformfield(
                        title: 'Senha',
                        hintText: "Entre com sua senha",
                        controller: _passwordEC,
                        obscureText: true,
                        validator: Validatorless.multiple([
                          Validatorless.required('Senha Obrigatório'),
                          Validatorless.min(
                            6,
                            'Senha deve conter pelo menos 6 caracteres',
                          ),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      AppDefaultTextformfield(
                        title: 'Confirmar senha',
                        hintText: "Comfirme sua senha",
                        controller: _confirmPasswordEC,
                        obscureText: true,
                        validator: Validatorless.multiple([
                          Validatorless.required('Confirmar Senha Obrigatório'),
                          Validatorless.min(6, 'No mínimo 6 carecteres'),
                          Validatorless.compare(
                            _passwordEC,
                            'Senha diferente de confirmar senha!',
                          ),
                        ]),
                      ),
                      const SizedBox(height: 50),
                      Center(
                        child: AppDefaultEspecialButton(
                          width: double.infinity,
                          label: 'Cadastrar',
                          onPressed: _registerUser,
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
                                const TextSpan(text: 'Já tem uma conta? '),
                                TextSpan(
                                  text: 'Entrar.',
                                  style: const TextStyle(
                                    color:
                                        CatalagoColecionadorTheme.orangeColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.go('/login');
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
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

  Future<void> _registerUser() async {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (formValid) {
      FocusScope.of(context).unfocus();

      final ParseCloudFunction function = ParseCloudFunction('v1-sign-up');

      final Map<String, dynamic> params = <String, dynamic>{
        'email': _emailEC.text.trim(),
        'username': _usernameEC.text.trim(),
        'password': _passwordEC.text.trim(),
        'fullname': _fullnameEC.text,
      };

      final ParseResponse parseResponse = await function.execute(
        parameters: params,
      );

      if (parseResponse.success) {
        if (kDebugMode) {
          print(parseResponse.result);
        }
        if (mounted) {
          Messages.showSuccess('Usuário cadastrado com sucesso!', context);
        }
        context.go('/home');
      } else {
        //   // ignore: use_build_context_synchronously
        Messages.showError('Erro ao cadastrar usuário!', context);
      }

      //final userBack4App = ParseUser.createUser(
      //  _usernameEC.text,
      //  _passwordEC.text,
      //  _emailEC.text,
      //);

      //var response = await userBack4App.signUp();

      //if (response.success) {
      // ignore: use_build_context_synchronously
      //  Messages.showSuccess('Usuário cadastrado com sucesso!', context);
      // } else {
      //   // ignore: use_build_context_synchronously
      //   Messages.showError('Erro ao cadastrar usuário!', context);
      // }

      //final user = UserCollection()
      //  ..name = _usernameEC.text
      //  ..email = _emailEC.text
      //  ..password = _passwordEC.text; // Storing plain text as requested

      //IsarService()
      //    .saveUser(user)
      //    .then((_) {
      //      if (mounted) {
      //        Messages.showSuccess('Usuário cadastrado com sucesso!', context);
      //        context.go('/home');
      //      }
      //    })
      //    .catchError((e) {
      //      if (mounted) {
      //        Messages.showError('Erro ao cadastrar usuário: $e', context);
      //      }
      //    });
    }
  }
}
