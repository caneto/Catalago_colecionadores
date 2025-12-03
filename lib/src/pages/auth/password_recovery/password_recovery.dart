// File: PasswordRecovery.dart
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:catalago_colecionadores/src/pages/auth/password_recovery/widgets/confirmation_widget.dart';
import 'package:catalago_colecionadores/src/pages/auth/password_recovery/widgets/email_inputfield_widget.dart';
import 'package:catalago_colecionadores/src/pages/auth/password_recovery/widgets/footer_widget.dart';
import 'package:catalago_colecionadores/src/pages/auth/password_recovery/widgets/header_widget.dart';
import 'package:catalago_colecionadores/src/pages/auth/password_recovery/widgets/title_and_instructions_widget.dart';
import 'package:flutter/material.dart';

import 'widgets/send_button.dart';

// Main PasswordRecovery Widget (Stateful)
class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  State<PasswordRecovery> createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  final TextEditingController _emailController = TextEditingController();
  bool _isSending = false;
  String? _errorText;
  bool _sent = false;

  // Example: Fake send action - replace with your sending logic!
  Future<void> _sendResetEmail() async {
    setState(() {
      _isSending = true;
      _errorText = null;
      _sent = false;
    });

    await Future.delayed(const Duration(seconds: 2));
    final email = _emailController.text.trim();

    setState(() {
      _isSending = false;
      if (!_isValidEmail(email)) {
        _errorText = 'Please enter a valid email.';
      } else {
        _sent = true;
      }
    });
  }

  bool _isValidEmail(String email) {
    // Basic email validation
    return RegExp(r"^[\w\.-]+@[\w\.-]+\.\w{2,}$").hasMatch(email);
  }

  void _navigateBack(BuildContext context) {
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    // Outer background
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Determine responsiveness (mobile: compact, desktop: centered with width)
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
                                  errorText: _errorText,
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
                                    child: ConfirmationWidget(),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      FooterWidget(
                        isNarrow: isNarrow,
                        onBackToLogin: () => {
                          Navigator.of(
                            context,
                          ).popUntil((route) => route.isFirst),
                        },
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
