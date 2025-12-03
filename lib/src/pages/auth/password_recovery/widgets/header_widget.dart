import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderWidget extends StatelessWidget {
  final VoidCallback onBack;
  final bool isNarrow;
  const HeaderWidget({super.key, required this.onBack, required this.isNarrow});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      child: Container(
        height: isNarrow ? 56 : 64,
        padding: EdgeInsets.only(
          left: isNarrow ? 4 : 0,
          right: isNarrow ? 4 : 0,
        ),
        decoration: const BoxDecoration(
          color: CatalagoColecionadorTheme.headerBlackGround,
          border: Border(
            bottom: BorderSide(color: Color(0xFF242E47), width: 1),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Semantics(
              label: "Go Back",
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(32),
                  onTap: onBack,
                  child: Container(
                    height: double.infinity,
                    padding: isNarrow
                        ? const EdgeInsets.symmetric(horizontal: 12)
                        : const EdgeInsets.only(left: 24, right: 8),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/seta_esquerda.svg',
                          height: 28,
                          width: 28,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Redefinir Senha",
                          style: CatalagoColecionadorTheme.titleSmallStyle
                              .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                letterSpacing: -0.3,
                                color: CatalagoColecionadorTheme.whiteColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
