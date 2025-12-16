import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfirmationWidget extends StatelessWidget {
  final String? generatedPassword;

  const ConfirmationWidget({super.key, this.generatedPassword});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Reset email sent or password generated',
      child: Container(
        margin: const EdgeInsets.only(top: 12, bottom: 24),
        padding: const EdgeInsets.all(18.0),
        decoration: BoxDecoration(
          color: const Color(0xFF242E47),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF17C964),
                  size: 32,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    generatedPassword != null
                        ? 'Sua senha provisória foi gerada com sucesso!'
                        : 'Instruções para redefinir sua senha foram enviadas!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Plus Jakarta Sans',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            if (generatedPassword != null) ...[
              const SizedBox(height: 16),
              const Text(
                'Clique abaixo para copiar:',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: generatedPassword!));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Senha copiada!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF17C964)),
                  ),
                  child: Text(
                    generatedPassword!,
                    style: const TextStyle(
                      color: Color(0xFF17C964),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
