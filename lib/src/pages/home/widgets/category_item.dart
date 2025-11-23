import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String label;
  final double fontSize;
  final EdgeInsets padding;
  final double minWidth;
  final Function onTap;
 

  const CategoryItem({
    super.key,
    required this.label,
    required this.fontSize,
    required this.padding,
    required this.minWidth, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(label),
        child: Container(
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
        ),
      ),
    );
  }
}
