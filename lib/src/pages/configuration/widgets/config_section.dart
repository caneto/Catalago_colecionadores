import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class ConfigSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ConfigSection({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: CatalagoColecionadorTheme.titleStyleNormal.copyWith(
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: CatalagoColecionadorTheme.whiteColor,
            letterSpacing: 0.02,
            height: 1.15,
          ),
        ),
        SizedBox(height: 7),
        ...children,
      ],
    );
  }
}
