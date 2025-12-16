
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class TitleAndInstructionsWidget extends StatelessWidget {
  const TitleAndInstructionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 44),
        Text(
          'Esqueceu sua senha?',
          style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
            color: CatalagoColecionadorTheme.whiteColor,
            fontWeight: FontWeight.w700,
            fontSize: 24,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 12),
        Text(
          'Insira o sei username ou seu e-mail associado à sua conta e será gerado uma nova senha provisória.',
          //'Insira o e-mail associado à sua conta e enviaremos instruções para redefinir sua senha.',
          style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
            fontSize: 15,
            height: 1.6,
            color: CatalagoColecionadorTheme.navBarBoxColor,
          ),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 28),
      ],
    );
  }
}
