import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/base/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIconButton extends AppStateless {
  const AppIconButton({
    Key? key,
    required this.id,
    required this.iconPath,
    required this.onPressed,
    this.size = 48,
  }) : super(key: key);

  final String id;
  final String iconPath;
  final VoidCallback? onPressed;
  final double size;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return SizedBox(
      width: size,
      height: size,
      child: Material(
        type: MaterialType.transparency,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed != null ? () {
            onPressed!.call();
            analytics.logButtonPressed(id);
          } : null,
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                onPressed != null ? theme.primary : theme.gray,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
