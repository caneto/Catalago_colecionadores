import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/pages/configuration/widgets/circle_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HeaderSectionWidget extends StatelessWidget {
  final String textHeader;
  final String? textIcon;
  final String? iconVar;
  final bool funcStatus;
  final Function()? onTap;

  const HeaderSectionWidget({
    super.key,
    required this.textHeader,
    this.onTap,
    this.funcStatus = false,
    this.textIcon,
    this.iconVar,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //const SizedBox(width: 8),
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
        SizedBox(width: 17),
        Semantics(
          label: textHeader,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              textHeader,
              style: CatalagoColecionadorTheme.titleStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: CatalagoColecionadorTheme.whiteColor,
                letterSpacing: 0,
                height: 1.25,
              ),
              semanticsLabel: "Settings",
            ),
          ),
        ),
        if (funcStatus)
          Expanded(
            child: Semantics(
              label: textIcon,
              child: Align(
                alignment: AlignmentGeometry.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: onTap,
                    child: SvgPicture.asset(
                      'assets/images/$iconVar',
                      height: 32,
                      width: 32,
                      semanticsLabel: 'X',
                      colorFilter: ColorFilter.mode(
                        CatalagoColecionadorTheme.whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
