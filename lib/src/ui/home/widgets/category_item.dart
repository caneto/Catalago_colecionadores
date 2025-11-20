import 'package:catalago_colecionadores/src/ui/core/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String label;
  final double fontSize;
  final EdgeInsets padding;
  final double minWidth;

  const CategoryItem({
    super.key,
    required this.label,
    required this.fontSize,
    required this.padding,
    required this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: minWidth),
      padding: padding,
      decoration: BoxDecoration(
        color: CatalagoColecionadorTheme.cardCategyColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: CatalagoColecionadorTheme.textBold.copyWith(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          letterSpacing: -.1,
          height: 1.25,
        ),
      ),
    );
  }
}
