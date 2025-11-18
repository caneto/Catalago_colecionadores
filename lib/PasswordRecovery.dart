// File: PasswordRecovery.dart
import 'package:flutter/material.dart';

// Main PasswordRecovery Widget (Stateful)
class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({Key? key}) : super(key: key);

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

  void _backToLogin(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Outer background
    return Scaffold(
      backgroundColor: const Color(0xFF121721),
      body: MediaQuery(
        data: MediaQuery.of(context),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Determine responsiveness (mobile: compact, desktop: centered with width)
              final isNarrow = constraints.maxWidth < 520;
              final contentMaxWidth = isNarrow ? double.infinity : 400.0;
              final horizontalPadding = isNarrow ? 12.0 : 24.0;

              return Column(
                children: [
                  _Header(
                    onBack: () => _navigateBack(context),
                    isNarrow: isNarrow,
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        width: contentMaxWidth,
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const _TitleAndInstructions(),
                            const SizedBox(height: 6),
                            _EmailInputField(
                              controller: _emailController,
                              errorText: _errorText,
                              enabled: !_isSending && !_sent,
                            ),
                            if (!_sent)
                              _SendButton(
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
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: _Confirmation(),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _Footer(
                    isNarrow: isNarrow,
                    onBackToLogin: () => _backToLogin(context),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onBack;
  final bool isNarrow;
  const _Header({
    required this.onBack,
    required this.isNarrow,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF121721),
      elevation: 0,
      child: Container(
        height: isNarrow ? 56 : 64,
        padding: EdgeInsets.only(
          left: isNarrow ? 4 : 0,
          right: isNarrow ? 4 : 0,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFF242E47), width: 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _BackButton(onTap: onBack, isNarrow: isNarrow),
            const SizedBox(width: 8),
            const _ResetTitle(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isNarrow;
  const _BackButton({
    required this.onTap,
    required this.isNarrow,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Go Back",
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: onTap,
          child: Container(
            height: double.infinity,
            padding: isNarrow
                ? const EdgeInsets.symmetric(horizontal: 12)
                : const EdgeInsets.only(left: 24, right: 8),
            child: Row(
              children: [
                Image.network(
                  "https://app.codigma.io/api/uploads/assets/eaf26700-ba88-41e4-b229-7af52e1bd12b.svg",
                  width: 28,
                  height: 28,
                  semanticLabel: 'Back arrow',
                  color: Colors.white,
                  errorBuilder: (ctx, err, stack) => Icon(Icons.arrow_back, color: Colors.white, size: 28),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResetTitle extends StatelessWidget {
  const _ResetTitle();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Redefinir Senha",
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontFamily: 'Plus Jakarta Sans',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            letterSpacing: -0.3,
            color: Colors.white,
          ),
    );
  }
}

class _TitleAndInstructions extends StatelessWidget {
  const _TitleAndInstructions();

  @override
  Widget build(BuildContext context) {
    // Make sure vertical spacing matches design
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 44),
        Text(
          'Esqueceu sua senha?',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontFamily: 'Plus Jakarta Sans',
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 24,
                letterSpacing: -0.5,
              ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 12),
        Text(
          'Insira o e-mail associado à sua conta e enviaremos instruções para redefinir sua senha.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontFamily: 'Plus Jakarta Sans',
                fontSize: 15,
                height: 1.6,
                color: const Color(0xFF91A3C9),
              ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 28),
      ],
    );
  }
}

class _EmailInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? errorText;
  final bool enabled;
  const _EmailInputField({
    required this.controller,
    required this.errorText,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          textField: true,
          label: 'Email',
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF242E47),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'E-mail',
                  style: theme.textTheme.labelSmall?.copyWith(
                        fontFamily: 'Plus Jakarta Sans',
                        color: const Color(0xFF91A3C9),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.1,
                      ),
                ),
                TextField(
                  controller: controller,
                  enabled: enabled,
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                  cursorColor: Colors.white,
                  style: theme.textTheme.bodyMedium?.copyWith(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Colors.white,
                        fontSize: 16,
                        letterSpacing: 0.1,
                      ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.only(top: 0, bottom: 3),
                    border: InputBorder.none,
                    hintText: 'E-mail',
                    hintStyle: theme.textTheme.bodyMedium?.copyWith(
                          fontFamily: 'Plus Jakarta Sans',
                          color: const Color(0xFF6671A2),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                    errorText: null,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              errorText!,
              style: theme.textTheme.labelMedium?.copyWith(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Colors.redAccent,
                  ),
            ),
          ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class _SendButton extends StatelessWidget {
  final bool isNarrow;
  final bool isSending;
  final VoidCallback? onPressed;
  const _SendButton({
    required this.isNarrow,
    required this.isSending,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Semantics(
        button: true,
        label: 'Send instructions',
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: isNarrow ? 13 : 15,
              horizontal: 0,
            ),
            textStyle: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: isNarrow ? 17 : 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.1,
            ),
            foregroundColor: Colors.white,
            backgroundColor: Colors.transparent, // gradient will override
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
          ).copyWith(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            side: MaterialStateProperty.all(BorderSide.none),
            elevation: MaterialStateProperty.all(0),
          ),
          onPressed: onPressed,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                colors: [Color(0xFF0958D9), Color(0xFF0D40A6)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A0958D9),
                  blurRadius: 16,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(minHeight: 40),
              child: isSending
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text(
                      'Enviar',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        letterSpacing: 0.1,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Confirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Reset email sent',
      child: Container(
        margin: const EdgeInsets.only(top: 12, bottom: 24),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: const Color(0xFF242E47),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: const [
            Icon(Icons.check_circle, color: Color(0xFF17C964), size: 32),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                'Instruções para redefinir sua senha foram enviadas!',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final bool isNarrow;
  final VoidCallback onBackToLogin;
  const _Footer({required this.isNarrow, required this.onBackToLogin});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        bottom: 27,
        top: 10,
        left: 0,
        right: 0,
      ),
      alignment: Alignment.center,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onBackToLogin,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text(
            'Voltar ao Login',
            style: TextStyle(
              color: const Color(0xFF91A3C9),
              fontSize: 15,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w700,
              letterSpacing: 0.1,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}