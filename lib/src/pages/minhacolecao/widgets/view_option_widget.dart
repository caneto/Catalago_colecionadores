import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:catalago_colecionadores/src/core/ui/theme/resource.dart';
import 'package:flutter/material.dart';

// VIEW OPTIONS ("Grid" vs "List" Toggle)
enum ViewMode { grid, list }

class ViewOptionsWidget extends StatelessWidget {
  final ViewMode selected;
  final ValueChanged<ViewMode> onSelect;
  final bool isMobile;
  const ViewOptionsWidget({
    super.key,
    required this.selected,
    required this.onSelect,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Grid
          _ViewOptionButton(
            text: "Grid",
            iconPath: R.ASSETS_IMAGES_GRID_50_PNG,
            isSelected: selected == ViewMode.grid,
            onTap: () => onSelect(ViewMode.grid),
            isMobile: isMobile,
          ),
          SizedBox(width: 14),
          // List
          _ViewOptionButton(
            text: "List",
            iconPath: R.ASSETS_IMAGES_BULLETED_LIST_50_PNG,
            isSelected: selected == ViewMode.list,
            onTap: () => onSelect(ViewMode.list),
            isMobile: isMobile,
          ),
        ],
      ),
    );
  }
}

class _ViewOptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final String iconPath;
  final VoidCallback onTap;
  final bool isMobile;

  const _ViewOptionButton({
    required this.text,
    required this.isSelected,
    required this.iconPath,
    required this.onTap,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    const primaryBg = CatalagoColecionadorTheme.bgInput;
    const textSecondary = CatalagoColecionadorTheme.bgInputAccent;

    return SizedBox(
      height: 40,
      child: Semantics(
        button: true,
        label: "View as $text",
        selected: isSelected,
        child: ElevatedButton(
          style: ButtonStyle(
            side: WidgetStateProperty.all(
              BorderSide(
                width: 2, // Border width
                color: Colors.blueGrey, // Border color
              ),
            ),
            minimumSize: WidgetStateProperty.all(Size(isMobile ? 70 : 120, 40)),
            backgroundColor: WidgetStateProperty.all(
              isSelected ? textSecondary : primaryBg,
            ),
            foregroundColor: WidgetStateProperty.all(
              isSelected ? primaryBg : textSecondary,
            ),
            elevation: WidgetStateProperty.all(1),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            overlayColor: WidgetStateProperty.all(
              Colors.white.withValues(alpha: 0.04),
            ),
          ),
          onPressed: onTap,
          child: Row(
            children: [
              Image.asset(iconPath, width: 16, height: 16, color: Colors.white),
              SizedBox(width: isMobile ? 12 : 8),
              Text(
                text,
                style: CatalagoColecionadorTheme.titleStyle.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
