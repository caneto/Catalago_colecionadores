import 'package:catalago_colecionadores/src/ui/core/helpers/messages.dart';
import 'package:catalago_colecionadores/src/ui/core/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/ui/core/theme/resource.dart';
import 'package:catalago_colecionadores/src/ui/core/widgets/app_default_especial_button.dart';
import 'package:catalago_colecionadores/src/ui/core/widgets/app_default_textformfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with MessageViewMixin {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    _confirmPasswordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey,
      //appBar: ColecionadorAppbar(),
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
                        hintText: "Digite seu nome",
                        title: 'Nome',
                        controller: _nameEC,
                        validator: Validatorless.required('Nome Obrigatório'),
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
                                    color: CatalagoColecionadorTheme.orangeColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(
                                        context,
                                      ).pushReplacementNamed('/login');
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

  void _registerUser() {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (formValid) {
      FocusScope.of(context).unfocus();
      //controller.register(
      //  name: _nameEC.text,
      //  email: _emailEC.text,
      //  password: _passwordEC.text,
      //);
    }
  }
}
