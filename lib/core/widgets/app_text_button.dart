import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:app_agendamento/core/widgets/base/app_state.dart';

class AppTextButton extends AppStateless {
  const AppTextButton({
    super.key,
    required this.id,
    required this.label,
    required this.onPressed,
    this.color,
  });

  final String id;
  final String label;
  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return theme.lightGray;
          }
          return color ?? theme.black;
        }),
        minimumSize: MaterialStateProperty.all(const Size(64, 64)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16),
        ),
        overlayColor: MaterialStateProperty.all(theme.lightGray),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      onPressed: onPressed != null ? () {
        onPressed!.call();
        analytics.logButtonPressed(id);
      } : null,
      child: Text(label),
    );
  }


}