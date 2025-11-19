import 'package:catalago_colecionadores/src/ui/core/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {

  final bool isSelected;
  final String iconUrl;
  final String label;
  final VoidCallback onTap;
  final double iconSize;
  final double labelFontSize;
  final double width;

  const NavBarItem({
    super.key,
    required this.isSelected,
    required this.iconUrl,
    required this.label,
    required this.onTap,
    required this.iconSize,
    required this.labelFontSize,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final baseColor = CatalagoColecionadorTheme.navBarBoxItemColor;
    final selectedColor = Colors.white;
    return Semantics(
      container: true,
      label: label,
      button: true,
      selected: isSelected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          width: width,
          height: 62,
          alignment: Alignment.center,
          decoration: isSelected
              ? BoxDecoration(
                  color: CatalagoColecionadorTheme.navBarBoxContornoColor,
                  borderRadius: BorderRadius.circular(16),
                )
              : null,
          padding: EdgeInsets.only(top: iconSize / 2.6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                iconUrl,
                width: iconSize,
                height: iconSize,
                color: isSelected ? selectedColor : baseColor,
                errorBuilder: (c, _, __) => Icon(
                  Icons.circle,
                  color: isSelected ? selectedColor : baseColor,
                  size: iconSize,
                ),
              ),
              SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? selectedColor : baseColor,
                  fontSize: labelFontSize,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Plus Jakarta Sans',
                  letterSpacing: -0.07,
                  height: 1.25,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
