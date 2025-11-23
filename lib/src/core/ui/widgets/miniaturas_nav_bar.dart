import 'package:catalago_colecionadores/src/core/ui/theme/catalago_colecionador_theme.dart';
import 'package:flutter/material.dart';

import 'nav_bar_item.dart';

class MiniaturasNavBar extends StatelessWidget {
  final List<Map<String, String>> items;
  final int selectedIndex;
  final void Function(int) onItemTap;
  final double navHeight;
  final double iconSize;
  final double labelFontSize;
  final double navItemWidth;

  const MiniaturasNavBar({super.key, 
    required this.items,
    required this.selectedIndex,
    required this.onItemTap,
    required this.navHeight,
    required this.iconSize,
    required this.labelFontSize,
    required this.navItemWidth,
  });

  @override
  Widget build(BuildContext context) {
    final maxNavWidth = 480.0;
    return Material(
      elevation: 25,
      color: CatalagoColecionadorTheme.navBarBackkgroundColor,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: CatalagoColecionadorTheme.navBarBoxColor,
              width: 1,
            ),
          ),
        ),
        height: navHeight,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxNavWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items
                .asMap()
                .entries
                .map(
                  (e) => NavBarItem(
                    isSelected: (selectedIndex == e.key) || false,
                    iconLogo: e.value['iconLogo']!,
                    label: e.value['label']!,
                    onTap: () => onItemTap(e.key),
                    iconSize: iconSize,
                    labelFontSize: labelFontSize,
                    width: navItemWidth,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
