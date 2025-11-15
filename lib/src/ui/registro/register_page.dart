import 'package:catalago_colecionadores/src/ui/core/helpers/messages.dart';
import 'package:catalago_colecionadores/src/ui/core/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/ui/core/widgets/app_default_especial_button.dart';
import 'package:catalago_colecionadores/src/ui/core/widgets/app_default_textformfield.dart';
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
    return Scaffold(
      //appBar: DeliveryAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cadastro', style: CatalagoColecionadorTheme.titleStyle),
                Text(
                  'Preeche os campos abaixo para criar o seu cadastro',
                  style: CatalagoColecionadorTheme.titleStyle.copyWith(fontSize: 18),
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
              ],
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
