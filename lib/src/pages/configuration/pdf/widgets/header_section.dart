import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/pages/configuration/widgets/circle_icon.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 8),
        InkWell(
          child: CircleIcon(url: 'seta_esquerda.svg', size: 28),
          onTap: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          },
        ),
        SizedBox(width: 5),
        const Icon(
          Icons.picture_as_pdf,
          color: CatalagoColecionadorTheme.bgInputAccent,
        ),
        SizedBox(width: 12),
        Text(
          'Salvar como PDF',
          style: CatalagoColecionadorTheme.titleStyle.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: CatalagoColecionadorTheme.whiteColor,
            letterSpacing: 0,
            height: 1.25,
          ),
          semanticsLabel: "Settings",
        ),
      ],
    );
  }
}
