import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  final bool isNarrow;
  final VoidCallback onBackToLogin;
  const FooterWidget({
    super.key,
    required this.isNarrow,
    required this.onBackToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 27, top: 10, left: 0, right: 0),
      alignment: Alignment.center,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onBackToLogin,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Text(
            'Voltar ao Login',
            style: TextStyle(
              color: CatalagoColecionadorTheme.blackClaroColor,
              fontSize: 15,
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
