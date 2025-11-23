
// Wigets auxiliares
import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

class CollectionConditionCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CollectionConditionCard({super.key, 
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? CatalagoColecionadorTheme.bgInputAccent
                : CatalagoColecionadorTheme.bgInput,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? CatalagoColecionadorTheme.bgInputAccent
                  : CatalagoColecionadorTheme.borderFooter,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: CatalagoColecionadorTheme.textBold.copyWith(
                color: CatalagoColecionadorTheme.textDescriptColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

