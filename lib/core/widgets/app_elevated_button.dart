import 'package:app_agendamento/app.dart';
import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/base/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppElevatedButton extends AppStateless {
  const AppElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.iconPath,
    required this.id,
  });

  final String id;
  final String label;
  final VoidCallback? onPressed;
  final String? iconPath;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return ElevatedButton(
      onPressed: onPressed != null ? () {
        onPressed!.call();
        analytics.logButtonPressed(id);
      } : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return theme.gray;
          }
          return theme.primary;
        }),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        minimumSize: MaterialStateProperty.all(const Size(128, 64)),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
        foregroundColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return theme.lightGray;
          }
          return Colors.white;
        }),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
      child: Row(
        children: [
          if (iconPath != null)
            const SizedBox(
              width: 24,
            ),
          Flexible(
            child: Center(
              child: Text(label, textAlign: TextAlign.center,),
            ),
          ),
          if (iconPath != null)
            SvgPicture.asset(
              iconPath!,
              width: 24,
            )
        ],
      ),
    );
  }
}
