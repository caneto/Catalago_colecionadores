import 'dart:math';

import 'package:catalago_colecionadores/src/core/database/isar_models/user_collection.dart';
import 'package:catalago_colecionadores/src/core/database/isar_service.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/pages/auth/password_recovery/widgets/confirmation_widget.dart';
import 'package:catalago_colecionadores/src/pages/auth/password_recovery/widgets/email_inputfield_widget.dart';
import 'package:catalago_colecionadores/src/pages/auth/password_recovery/widgets/footer_widget.dart';
import 'package:catalago_colecionadores/src/pages/auth/password_recovery/widgets/header_widget.dart';
import 'package:catalago_colecionadores/src/pages/auth/password_recovery/widgets/title_and_instructions_widget.dart';
import 'package:catalago_colecionadores/src/pages/auth/password_recovery/widgets/username_inputfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/send_button.dart';

// Main PasswordRecovery Widget (Stateful)
class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final IsarService _isarService = IsarService();
  bool _isSending = false;
  String? _errorTextEmail;
  String? _errorTextUsername;
  bool _sent = false;
  String? _generatedPassword;

  Future<void> _sendResetEmail() async {
    final email = _emailController.text.trim();
    final username = _usernameController.text.trim();

    if (email.isEmpty && username.isEmpty) {
      setState(() {
        _errorTextEmail = 'Por favor, informe o e-mail do usuário.';
        _errorTextUsername = 'Por favor, informe nome de usuário.';
      });
      return;
    }

    if (email.isNotEmpty && !_isValidEmail(email)) {
      setState(() {
        _errorTextEmail = 'Por favor, informe um e-mail válido.';
      });
      return;
    }

    setState(() {
      _isSending = true;
      _errorTextEmail = null;
      _errorTextUsername = null;
      _generatedPassword = null;
      _sent = false;
    });

    UserCollection? user;
    try {
      final identifier = email.isNotEmpty ? email : username;
      user = await _isarService.getUserByEmailOrUsername(identifier);
    } catch (e) {
      setState(() {
        _isSending = false;
        _errorTextEmail = 'Erro ao buscar usuário: $e';
        _errorTextUsername = 'Erro ao buscar usuário: $e';
      });
      return;
    }

    if (user == null) {
      setState(() {
        _isSending = false;
        _errorTextUsername = 'Usuário não encontrado.';
      });
      return;
    }

    // Stop loading to show dialog
    setState(() {
      _isSending = false;
    });

    // Show confirmation dialog
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar redefinição'),
          content: const Text(
            'Deseja realmente resetar a sua senha? Uma nova senha provisória será gerada.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    setState(() {
      _isSending = true;
    });

    try {
      // Generate random temporary password
      final random = Random();
      final randomNumber =
          random.nextInt(900000) + 100000; // 6 digit random number
      final tempPassword = 'senha_provisoria_$randomNumber';

      // Update user password
      user.password = tempPassword;
      await _isarService.saveUser(user);

      setState(() {
        _isSending = false;
        _generatedPassword = tempPassword;
        _sent = true;
      });
    } catch (e) {
      setState(() {
        _isSending = false;
        _errorTextEmail = 'Erro ao resetar senha: $e';
        _errorTextUsername = 'Erro ao resetar senha: $e';
      });
    }
  }

  bool _isValidEmail(String email) {
    // Basic email validation
    return RegExp(r"^[\w\.-]+@[\w\.-]+\.\w{2,}$").hasMatch(email);
  }

  void _navigateBack(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    // Outer background
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 520;
            final contentMaxWidth = isNarrow ? double.infinity : 400.0;
            final horizontalPadding = isNarrow ? 12.0 : 24.0;

            return Container(
              constraints: BoxConstraints(minHeight: sizeOf.height),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(R.ASSETS_IMAGES_CAPA_START_PNG),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      HeaderWidget(
                        onBack: () => _navigateBack(context),
                        isNarrow: isNarrow,
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            width: contentMaxWidth,
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const TitleAndInstructionsWidget(),
                                const SizedBox(height: 6),
                                EmailInputFieldWidget(
                                  controller: _emailController,
                                  errorText: _errorTextEmail,
                                  enabled: !_isSending && !_sent,
                                ),
                                UsernameInputFieldWidget(
                                  controller: _usernameController,
                                  errorText: _errorTextUsername,
                                  enabled: !_isSending && !_sent,
                                ),
                                if (!_sent)
                                  SendButton(
                                    isNarrow: isNarrow,
                                    isSending: _isSending,
                                    onPressed: _isSending
                                        ? null
                                        : () {
                                            FocusScope.of(context).unfocus();
                                            _sendResetEmail();
                                          },
                                  ),
                                if (_sent)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 20.0,
                                    ),
                                    child: ConfirmationWidget(
                                      generatedPassword: _generatedPassword,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      FooterWidget(
                        isNarrow: isNarrow,
                        onBackToLogin: () => {context.go('/login')},
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
